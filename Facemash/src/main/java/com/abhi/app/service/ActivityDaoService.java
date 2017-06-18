package com.abhi.app.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.TreeMap;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;

import com.abhi.app.Dao.ActivityDao;
import com.abhi.app.model.Activity;
import com.abhi.app.model.Product;
import com.abhi.app.model.Profile;

public class ActivityDaoService {
	@Autowired
	ActivityDao activityDao;
	@Autowired
	ProfileDaoService profileDaoService;
	@Autowired
	Utils utils;
	@Autowired
	FriendDaoService friendDaoService;
	@Autowired
	ProductDaoService productDaoService;
	public List<Activity> getAllFriendActivities(String loggedInUserId) {
		List<Profile> list=friendDaoService.getFriends(loggedInUserId);
		List<String> listOfId = getList(list);
		return activityDao.getAllFriendActivities(listOfId);
		
	}
	public List<Activity> getMyActivities(String userId) {
		return activityDao.getMyActivities(userId);
	}
	public TreeMap<String,ArrayList<Activity>> userToComments(List<Activity> list)
	{
		TreeMap<String,ArrayList<Activity>> map=new TreeMap<String,ArrayList<Activity>>();
		Iterator<Activity> i = list.iterator();
		while(i.hasNext())
		{
			Activity a=i.next();
			ArrayList<Activity> listOfComments;
			if(a.getActivityType()==Activity.ActivityType.COMMENT)
				{
				listOfComments= map.get(a.getProfile().getUserId());
				if(listOfComments!=null)
					listOfComments.add(a);
				else{
					listOfComments=new ArrayList<Activity>();
					listOfComments.add(a);
				}
				map.put(a.getProfile().getUserId(), listOfComments);
				i.remove();
				}
			
		}
		return map;
	}
	private List<String> getList(List<Profile> list) {
		List<String> listOfId=new ArrayList<String>();
		for(Profile p:list)
			listOfId.add(p.getUserId());
		return listOfId;
	}
	public boolean addStatusActivity(Product product,Activity.ActivityType activityType) {
		Activity activity=new Activity();
		activity.setActivityId(utils.nextUniqueId());
		activity.setProfile(profileDaoService.getUserProfile(product.getUploaderId()));
		activity.setActivityType(activityType);
		activity.setDate(utils.currentDateAndTime("yyyy-MM-dd HH:mm:ss"));
		activity.setProduct(product);
		return activityDao.saveActivity(activity);
	}
	public TreeSet<String> getLikesOrSharesOfUser(String loggedInUserId,Activity.ActivityType activityType ) {
		List<Activity> list=activityDao.getLikesOrSharesOfUser(loggedInUserId,activityType);
		TreeSet<String> set=new TreeSet<String>();
		for(Activity a:list)
			set.add(a.getProduct().getProductId());
		return set;
	}
	public TreeMap<String, ArrayList<Activity>> getUserComments(String loggedInUserId)
	{
		TreeMap<String, ArrayList<Activity>> map=new TreeMap<String,ArrayList<Activity>>();
		List<Activity> list=activityDao.getUserComments(loggedInUserId);
		return productToAllComments(map, list);
		
	}
	private TreeMap<String, ArrayList<Activity>> productToAllComments(TreeMap<String, ArrayList<Activity>> map,
			List<Activity> list) {
		ArrayList<Activity> listOfComments;
		for(Activity a:list)
		{
			listOfComments= map.get(a.getProduct().getProductId());
			if(listOfComments!=null)
				listOfComments.add(a);
			else{
				listOfComments=new ArrayList<Activity>();
				listOfComments.add(a);
			}
			map.put(a.getProduct().getProductId(), listOfComments);
		}
		return map;
	}
	public TreeMap<String, ArrayList<Activity>> getAllComments(String loggedInUserId,List<Profile> profiles){
		TreeSet<String> excludedUsers=new TreeSet<String>();
		for(Profile profile:profiles)
			excludedUsers.add(profile.getUserId());
		TreeMap<String, ArrayList<Activity>> map=new TreeMap<String,ArrayList<Activity>>();
		List<Activity> list=(List<Activity>)getAllFriendActivities(loggedInUserId);
		List<String> products=new ArrayList<String>();
		for(Activity a:list)
			products.add(a.getProduct().getProductId());
		List<Activity> commentsActivities=activityDao.getAllComments(products);
		Iterator<Activity> i = commentsActivities.iterator();
		while(i.hasNext())
		{
			Activity a=i.next();
			if(excludedUsers.contains(a.getProfile().getUserId()))
				i.remove();
			
		}
		return productToAllComments(map, commentsActivities);
		
	}
	public String saveComment(String productId,String comment,String loggedInUserId) {
		int counter=productDaoService.getProduct(productId).getComments();
		Activity activity=new Activity();
		activity.setActivityId(utils.nextUniqueId());
		activity.setDate(utils.currentDate("yyyy-MM-dd"));
		activity.setActivityType(Activity.ActivityType.COMMENT);
		activity.setText(comment);
		activity.setProfile(profileDaoService.getUserProfile(loggedInUserId));
		activity.setProduct(productDaoService.getProduct(productId));
		boolean res=activityDao.saveActivity(activity);
		if(res)
		productDaoService.updateProductProperty("comments",productId,counter+1);
		return productDaoService.getProduct(productId).getComments()+"";
	}
	public String saveLikeOrShare(String productId,String action,String loggedInUserId){
		int counter=0;
		String property="";//hold the field name of product to be updated
		Activity activity=new Activity();
		activity.setActivityId(utils.nextUniqueId());
		activity.setDate(utils.currentDate("yyyy-MM-dd"));
		if(action.equalsIgnoreCase("like")){
		activity.setActivityType(Activity.ActivityType.LIKE);
		activity.setText("LIKE");
		counter=productDaoService.getProduct(productId).getLikes();
		property="likes";
		}
		else if(action.equalsIgnoreCase("share")){
		activity.setActivityType(Activity.ActivityType.SHARE);	
		activity.setText("SHARE");
		counter=productDaoService.getProduct(productId).getShares();
		property="shares";
		}
		activity.setProfile(profileDaoService.getUserProfile(loggedInUserId));
		activity.setProduct(productDaoService.getProduct(productId));
		if(activityDao.saveActivity(activity))
			productDaoService.updateProductProperty(property,productId,counter+1);
		if(action.equalsIgnoreCase("like"))
		counter=productDaoService.getProduct(productId).getLikes();
		else if(action.equalsIgnoreCase("share"))
		counter=productDaoService.getProduct(productId).getShares();
		return counter+"";
		
	}
	public String undoLikeOrShare(String productId,String action,String loggedInUserId){
		Activity.ActivityType activityType=null;
		int counter=0;
		String property="";
		if(action.equalsIgnoreCase("unlike"))
		{	activityType=Activity.ActivityType.LIKE;
		counter=productDaoService.getProduct(productId).getLikes();
		property="likes";
		}
		else if(action.equalsIgnoreCase("unshare")){
			activityType=Activity.ActivityType.SHARE;
			counter=productDaoService.getProduct(productId).getShares();
			property="shares";
		}
		if(activityDao.deleteActivity(productId,activityType,loggedInUserId))
		{
			productDaoService.updateProductProperty(property,productId,counter-1);	
		}
		if(action.equalsIgnoreCase("unlike"))
			counter=productDaoService.getProduct(productId).getLikes();
		else if(action.equalsIgnoreCase("unshare"))
			counter=productDaoService.getProduct(productId).getShares();
		return counter+"";
	}
}
