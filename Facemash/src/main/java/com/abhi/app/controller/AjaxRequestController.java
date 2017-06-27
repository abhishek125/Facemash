package com.abhi.app.controller;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.abhi.app.model.Info;
import com.abhi.app.model.Profile;
import com.abhi.app.service.ActivityDaoService;
import com.abhi.app.service.BlockDaoService;
import com.abhi.app.service.FriendDaoService;
import com.abhi.app.service.InfoDaoService;
import com.abhi.app.service.MyUserDetailsService;
import com.abhi.app.service.NotificationDaoService;
import com.abhi.app.service.ProductDaoService;
import com.abhi.app.service.ProfileDaoService;
import com.abhi.app.service.UserSearchService;
import com.abhi.app.service.Utils;

public class AjaxRequestController {
	
	@Autowired
	private ProfileDaoService profileDaoService;
	@Autowired 
	private MyUserDetailsService myUserDetailsService;
	@Autowired 
	private ProductDaoService productDaoService;
	@Autowired 
	private UserSearchService userSearchService;
	@Autowired
	private FriendDaoService friendDaoService;
	@Autowired
	private InfoDaoService infoDaoService;
	@Autowired
	private BlockDaoService blockDaoService;
	@Autowired
	private NotificationDaoService notificationDaoService;
	@Autowired
	private ActivityDaoService activityDaoService;
	@Autowired
	private Utils utils;
	
	public String myuserid(){
		return myUserDetailsService.getLoggedInUserId();
	}
	
	
	@RequestMapping(value="/searchuser",method=RequestMethod.GET)
	@ResponseBody
	public List<Profile> searchUsers(@RequestParam("term") String term)
	{
		String lastname="$2a$10$NhlBWqCAunQgt6HWQy/GQ.vF9p5cZ66v2gPX5Mh.U2XmrpzcR1yY.";
		String[] name=term.split(" +");
		if(name.length>=2)
			lastname=name[1];
		List<Profile> list=(List<Profile>)userSearchService.searchUsers(name[0],lastname,myuserid());
		return list;
	}
	
	@RequestMapping(value="/addfriend",method=RequestMethod.POST,consumes="application/json",produces="text/plain")
	@ResponseBody
	public String addfriend(@RequestBody Map<String,String> map)
	{
		boolean res=false;
		String str="";
		for(Map.Entry<String, String> entry : map.entrySet())
		{
		String receiverId=entry.getValue();
		String notificationId;
		if(receiverId.equals(myuserid()))//checking if sender and receiver are same
			return "";
		if(blockDaoService.isCurrentUserBlocked(myuserid(), receiverId))//checking if receiver has blocked loggedinuser
			return "add friend";
		if(entry.getKey().equals("add"))
		{
		return notificationDaoService.addFriendRequest(myuserid(), receiverId);
		}
		else if(entry.getKey().equals("unfriend"))
		{
		res=friendDaoService.unfriend(myuserid(), receiverId);
		str=res==true?"add friend":"unfriend";
		}
		else if(entry.getKey().equals("cancel") || entry.getKey().equals("decline") )
		{
		notificationId=receiverId;
		res=notificationDaoService.deleteFriendRequest(notificationId);
		str=res==true?"add friend":"accept";
		}
		else if(entry.getKey().equals("accept"))
		{
		notificationId=receiverId;//receiverid var indeed holds notifactionid in this case
		res=friendDaoService.addFriend(notificationId);
		notificationDaoService.deleteFriendRequest(notificationId);
		str=res==true?"unfriend":"accept";
		}
		
		}
		
		return str;
	}
	
	@RequestMapping(value="/updateprofile",method=RequestMethod.POST, consumes="application/json")
	@ResponseBody
	public String updateProfile(@RequestBody Map<String,String> map){
		boolean res=false;
		for(Map.Entry<String, String> entry : map.entrySet())
		res=profileDaoService.updateProfile(myuserid(), entry.getKey(), entry.getValue());
		return res==true?"profile updated succesfully":"no changes made";
	}
	@RequestMapping(value="/profilepicupdate",method=RequestMethod.POST,consumes = {"multipart/form-data"})
	@ResponseBody
	public String profilePicUpdate(@RequestPart("profile[]") MultipartFile[] profile ) throws ParseException
	{
		String path=utils.fileUpload(profile);
		profileDaoService.updateProfilePic(myuserid(),path);
		return path;
	}
	
	@RequestMapping(value="/block",method=RequestMethod.POST, consumes="application/json")
	@ResponseBody
	public String blockUser(@RequestBody Map<String,String> map){
		boolean res=false;
		for(Map.Entry<String, String> entry : map.entrySet())
		{
		if(entry.getKey().equals("block"))
		res=blockDaoService.blockUser(myuserid(),entry.getValue());
		else if(entry.getKey().equals("unblock"))
		res=blockDaoService.unblockUser(myuserid(),entry.getValue());
		}
		return res==true?"preferences updated succesfully":"no changes made";
	}
	
	@RequestMapping(value="/post",method=RequestMethod.POST,consumes = {"multipart/form-data"})
	@ResponseBody
	public String statusUpdate(@RequestPart("status") String status,
	        @RequestPart("images[]") MultipartFile[] images,@RequestPart("videos[]") MultipartFile[] videos ) throws ParseException
	{
		status=status.substring(1,status.length()-1);
		boolean res=productDaoService.saveProduct(myuserid(),status,utils.fileUpload(images),utils.fileUpload(videos));
		return res==true?"status has been updated":"status update failed";
	}
	@RequestMapping(value="/sendmessage",method=RequestMethod.POST,consumes = {"multipart/form-data"})
	@ResponseBody
	public String sendMessage(@RequestPart("message") String message,@RequestPart("receiverId") String receiverId,
	        @RequestPart("images[]") MultipartFile[] images,@RequestPart("videos[]") MultipartFile[] videos ) throws ParseException
	{
		receiverId=receiverId.substring(1,receiverId.length()-1);
		message=message.substring(1,message.length()-1);
		if(blockDaoService.isCurrentUserBlocked(myuserid(), receiverId) || receiverId.equals(myuserid()))
			return "error sending message";
		boolean res=infoDaoService.sendMessage(myuserid(), receiverId,message,utils.fileUpload(images),utils.fileUpload(videos));
		return res==true?"message has been sent":"error sending message";
	}
	@RequestMapping(value="/updatemessage",method=RequestMethod.POST,consumes="application/json",produces="text/plain")
	@ResponseBody
	public String updateMessage(@RequestBody Map<String,String> map)
	{
		if(map.get("action").equalsIgnoreCase("delete"))
		infoDaoService.deleteInfo(map.get("infoid"),Info.Status.DELETED);
		else if(map.get("action").equalsIgnoreCase("read"))
		infoDaoService.deleteInfo(map.get("infoid"),Info.Status.READ);
		else
			infoDaoService.deleteInfo(map.get("infoid"),Info.Status.UNREAD);	
		return "";
		
	}
	
	@RequestMapping(value="/updateproduct",consumes="application/json",method=RequestMethod.POST,produces="text/plain")
	@ResponseBody
	public String updateProduct(@RequestBody Map<String,String> map){
		String res="";
		String action=map.get("action");
		String productId=map.get("productId");
		if(action.equalsIgnoreCase("like") || action.equalsIgnoreCase("share"))
			res=activityDaoService.saveLikeOrShare( productId,action,myuserid());
		else if(action.equalsIgnoreCase("unlike") || action.equalsIgnoreCase("unshare"))
			res=activityDaoService.undoLikeOrShare(productId,action,myuserid());
		return res;
	}
	@RequestMapping(value="/submitcomment",consumes="application/json",method=RequestMethod.POST,produces="text/plain")
	@ResponseBody
	public String saveComment(@RequestBody Map<String,String> map)
	{
		String countOfComments=activityDaoService.saveComment(map.get("productId"),map.get("comment"),myuserid());
		return countOfComments;
	}
}
