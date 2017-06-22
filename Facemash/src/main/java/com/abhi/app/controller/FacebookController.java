package com.abhi.app.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.TreeSet;

import javax.validation.ConstraintViolationException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.abhi.app.model.Activity;
import com.abhi.app.model.Info;
import com.abhi.app.model.Notification;
import com.abhi.app.model.Product;
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

@Controller
public class FacebookController {

	@Autowired
	private ProfileDaoService profileDaoService;
	@Autowired
	private Utils utils;
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
	BlockDaoService blockDaoService;
	@Autowired
	NotificationDaoService notificationDaoService;
	@Autowired
	ActivityDaoService activityDaoService;
	
	public String myuserid(){
		return myUserDetailsService.getLoggedInUserId();
	}
	
	/*ajax request*/
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
	@RequestMapping(value="/profilepicupdate",method=RequestMethod.POST,consumes = {"multipart/form-data"})
	@ResponseBody
	public String profilePicUpdate(@RequestPart("profile[]") MultipartFile[] profile ) throws ParseException
	{
		String path=utils.fileUpload(profile);
		profileDaoService.updateProfilePic(myuserid(),path);
		return path;
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
	
	
	
	/*view request*/

	@RequestMapping(value="/", method=RequestMethod.GET)
	public String loginPage()
	{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(!(authentication instanceof AnonymousAuthenticationToken))
			return "redirect:/home";
			//System.out.println("thennemis"+authentication.getName()+authentication.isAuthenticated());
		return "login";
	}
	
	@RequestMapping(value="/signup", method=RequestMethod.GET)
	public String signUpPage()
	{
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(!(authentication instanceof AnonymousAuthenticationToken))
			return "redirect:/home";
		return "signup";
	}
	@RequestMapping(value="/searchallusers", method=RequestMethod.GET)
	public String searchAllUsers(@RequestParam(value="username") String username,Model model)
	{
		String lastname="$2a$10$NhlBWqCAunQgt6HWQy/GQ.vF9p5cZ66v2gPX5Mh.U2XmrpzcR1yY.";
		String[] name=username.split(" +");
		if(name.length>=2)
			lastname=name[1];
		List<Profile> list=userSearchService.searchValidUsers(name[0],lastname,myuserid());
		Profile profile=null;
		profile = profileDaoService.getUserProfile(myuserid());
		List<Product> products=productDaoService.getAllProductsOfUser(myuserid());
		List<Profile> friends=friendDaoService.getFriends(myuserid());
		List<String> excludedSuggestions=new ArrayList<String>();
		TreeSet<String> frndSet=new TreeSet<String>();
		for(Profile p:friends)
		{
			frndSet.add(p.getUserId());
			excludedSuggestions.add(p.getUserId());
		}
		excludedSuggestions.add(profile.getUserId());
		for(Profile p:list)
			excludedSuggestions.add(p.getUserId());//exclude users who are in search results(don't undo it)
		List<Info> unread=infoDaoService.getInfoAndProfile(myuserid(),Info.Status.UNREAD);
		List<Info> read=infoDaoService.getInfoAndProfile(myuserid(),Info.Status.READ);
		List<Notification> listNotification=notificationDaoService.getNotificationAndProfile(myuserid());
		TreeSet<String> blocked=blockDaoService.usersBlockedByMe(myuserid());
		TreeMap<String, String> friendRequestSentByUser= notificationDaoService.checkFriendReqeustSentByUser(myuserid());
		TreeMap<String, String> friendRequestReceivedByUser= notificationDaoService.checkFriendReqeustReceivedByUser(myuserid());
		List<Profile> suggestions=generateSuggestion(excludedSuggestions, blocked,friendRequestSentByUser,friendRequestReceivedByUser);
		model.addAttribute("users",list);
		model.addAttribute("profile",profile);
		model.addAttribute("products",products);
		model.addAttribute("friends",friends);
		model.addAttribute("friendSet",frndSet);
		model.addAttribute("blocked",blocked);
		model.addAttribute("suggestions",suggestions);
		model.addAttribute("sentRequest",friendRequestSentByUser);
		model.addAttribute("receivedRequest",friendRequestReceivedByUser);
		model.addAttribute("notificationObjects",listNotification);
		model.addAttribute("unreadMessageObjects",unread);
		model.addAttribute("readMessageObjects",read);
		return "searchuser";
	}
	
	private List<Profile> generateSuggestion(List<String> excludedSuggestions, TreeSet<String> blocked,
			TreeMap<String, String> friendRequestSentByUser, TreeMap<String, String> friendRequestReceivedByUser) {
		for(String s:blocked)
			excludedSuggestions.add(s);
		for(Map.Entry<String, String> entry:friendRequestSentByUser.entrySet())
			excludedSuggestions.add(entry.getKey());
		for(Map.Entry<String, String> entry:friendRequestReceivedByUser.entrySet())
			excludedSuggestions.add(entry.getKey());
		return profileDaoService.getSuggestions(excludedSuggestions);
	}

	@ExceptionHandler(ConstraintViolationException.class)
	public String exception(Model model)
	{
		model.addAttribute("errorMsg","validation error occured please try again");
		return "notfound";
	}
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String saveNewUser(@ModelAttribute("profile") Profile profile, String confirm,Model model) throws ParseException
	{
		profile.setMail(profile.getMail().toLowerCase());
		String res="";
		boolean error=false;
		if(profile.getPassword().length()<8)
			{
			res="password length is too short";
			error=true;
			}
		if(!error)
			res=profileDaoService.saveProfile(profile, confirm)==true?"account created successfully":"account creation error please try again";
		model.addAttribute("message",res);
		return "login";
	}
	@RequestMapping(value="/profile/{id}", method=RequestMethod.GET)
	public String profilePage(@PathVariable("id") String userId, Model model) throws ParseException
	{
		if (userId.equals(myuserid()))
			return "redirect:/profileedit";
		Profile profile=profileDaoService.getUserProfile(userId);
		List<Product> products=productDaoService.getAllProductsOfUser(userId);
		List<Profile> friends=friendDaoService.getFriends(userId);
		List<Info> unread=infoDaoService.getInfoAndProfile(myuserid(),Info.Status.UNREAD);
		List<Info> read=infoDaoService.getInfoAndProfile(myuserid(),Info.Status.READ);
		List<Notification> listNotification=notificationDaoService.getNotificationAndProfile(myuserid());
		List<Activity> activities=activityDaoService.getMyActivities(userId);
		TreeMap<String,ArrayList<Activity>> map=activityDaoService.userToComments(activities);//this fn delete comment activities from list
		//getting loggedinuser friends so we can know if this user is already a frnd or not
		List<Profile> myFriends=friendDaoService.getFriends(myuserid());
		List<String> excludedSuggestions=new ArrayList<String>();
		TreeSet<String> myFrndSet=new TreeSet<String>();
		for(Profile p:myFriends)
		{
			myFrndSet.add(p.getUserId());
			excludedSuggestions.add(p.getUserId());
		}
		excludedSuggestions.add(profileDaoService.getUserProfile(myuserid()).getUserId());
		excludedSuggestions.add(profile.getUserId());//exclude user whose profile is being opened
		//making a list of friends id's
		TreeSet<String> frndSet=new TreeSet<String>();
		for(Profile p:friends)
			frndSet.add(p.getUserId());
		TreeSet<String> blocked=blockDaoService.usersBlockedByMe(myuserid());
		TreeMap<String, String> friendRequestSentByUser= notificationDaoService.checkFriendReqeustSentByUser(myuserid());
		TreeMap<String, String> friendRequestReceivedByUser= notificationDaoService.checkFriendReqeustReceivedByUser(myuserid());
		List<Profile> suggestions=generateSuggestion(excludedSuggestions, blocked, friendRequestSentByUser, friendRequestReceivedByUser);
		model.addAttribute("profile", profile );
		model.addAttribute("products",products);
		model.addAttribute("friends",friends);
		model.addAttribute("suggestions",suggestions);
		model.addAttribute("notificationObjects",listNotification);
		model.addAttribute("unreadMessageObjects",unread);
		model.addAttribute("readMessageObjects",read);
		model.addAttribute("activities",activities);//now "activities" doesn't have comment activities of user 
		model.addAttribute("myCommentGroup",map);//it has comment activities of my group by friend
		model.addAttribute("likes",activityDaoService.getLikesOrSharesOfUser(myuserid(),Activity.ActivityType.LIKE));
		model.addAttribute("shares",activityDaoService.getLikesOrSharesOfUser(myuserid(),Activity.ActivityType.SHARE));
		model.addAttribute("userComments",activityDaoService.getUserComments(myuserid()));
		model.addAttribute("friendSet",frndSet);
		model.addAttribute("blocked",blocked);
		model.addAttribute("sentRequest",friendRequestSentByUser);
		model.addAttribute("receivedRequest",friendRequestReceivedByUser);
		model.addAttribute("myFriendSet",myFrndSet);
		model.addAttribute("loggedInUser",profileDaoService.getUserProfile(myuserid()));
		 
		return "profile";
	}
	@RequestMapping(value="/profileedit", method=RequestMethod.GET)
	public String profileEdit(Model model) throws ParseException
	{
		Profile profile=profileDaoService.getUserProfile(myuserid());
		List<Product> products=productDaoService.getAllProductsOfUser(myuserid());
		List<Profile> friends=friendDaoService.getFriends(myuserid());
		List<Info> unread=infoDaoService.getInfoAndProfile(myuserid(),Info.Status.UNREAD);
		List<Info> read=infoDaoService.getInfoAndProfile(myuserid(),Info.Status.READ);
		List<Notification> listNotification=notificationDaoService.getNotificationAndProfile(myuserid());
		model.addAttribute("notificationObjects",listNotification);
		model.addAttribute("unreadMessageObjects",unread);
		model.addAttribute("readMessageObjects",read);
		model.addAttribute("profile",profile);
		model.addAttribute("products",products);
		model.addAttribute("friends",friends);
		
		return "profileedit";
	}
	
	@RequestMapping(value="/home", method=RequestMethod.GET)
	public String homePage(Model model) throws ParseException
	{
		Profile profile=profileDaoService.getUserProfile(myuserid());
		List<Product> products=productDaoService.getAllProductsOfUser(myuserid());
		List<Profile> friends=friendDaoService.getFriends(myuserid());
		List<String> excludedSuggestions=new ArrayList<String>();
		for(Profile p:friends)
			excludedSuggestions.add(p.getUserId());
		excludedSuggestions.add(profile.getUserId());
		List<Info> unread=infoDaoService.getInfoAndProfile(myuserid(),Info.Status.UNREAD);
		List<Info> read=infoDaoService.getInfoAndProfile(myuserid(),Info.Status.READ);
		List<Notification> listNotification=notificationDaoService.getNotificationAndProfile(myuserid());
		List<Activity> activities=activityDaoService.getAllFriendActivities(myuserid());
		TreeMap<String,ArrayList<Activity>> map=activityDaoService.userToComments(activities);//this function will delete comment activities from list
		TreeSet<String> blocked=blockDaoService.usersBlockedByMe(myuserid());
		TreeMap<String, String> friendRequestSentByUser= notificationDaoService.checkFriendReqeustSentByUser(myuserid());
		TreeMap<String, String> friendRequestReceivedByUser= notificationDaoService.checkFriendReqeustReceivedByUser(myuserid());
		List<Profile> suggestions=generateSuggestion(excludedSuggestions, blocked,friendRequestSentByUser,friendRequestReceivedByUser);
		model.addAttribute("profile", profile );
		model.addAttribute("products",products);
		model.addAttribute("friends",friends);
		model.addAttribute("blocked",blocked);
		model.addAttribute("sentRequest",friendRequestSentByUser);
		model.addAttribute("receivedRequest",friendRequestReceivedByUser);
		model.addAttribute("notificationObjects",listNotification);
		model.addAttribute("unreadMessageObjects",unread);
		model.addAttribute("suggestions",suggestions);
		model.addAttribute("readMessageObjects",read);
		model.addAttribute("activities",activities);//now "activities" doesn't have comment activities of friends 
		model.addAttribute("friendCommentGroup",map);//it has comment activities of friends group by friend
		model.addAttribute("likes",activityDaoService.getLikesOrSharesOfUser(myuserid(),Activity.ActivityType.LIKE));
		model.addAttribute("shares",activityDaoService.getLikesOrSharesOfUser(myuserid(),Activity.ActivityType.SHARE));
		model.addAttribute("userComments",activityDaoService.getUserComments(myuserid()));
		List<Profile> excluded = new ArrayList<Profile>(friends);
		excluded.add(profile);//dont include loggedinuser comments as well they are sent as different in var name
		model.addAttribute("allComments",activityDaoService.getAllComments(myuserid(),excluded));
		return "home";
	}
	
	
}
