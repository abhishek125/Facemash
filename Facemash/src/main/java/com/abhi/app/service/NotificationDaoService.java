package com.abhi.app.service;

import java.util.List;
import java.util.TreeMap;

import org.springframework.beans.factory.annotation.Autowired;

import com.abhi.app.Dao.NotificationDao;
import com.abhi.app.model.Notification;

public class NotificationDaoService {

	@Autowired
	private NotificationDao notificationDao;
	@Autowired
	private Utils utils;
	@Autowired 
	private ProfileDaoService profileDaoService;
	public String addFriendRequest(String loggedInUserId,String targetUserId)
	{
		Notification notification=new Notification();
		notification.setNotificationId(utils.nextUniqueId());
		notification.setSenderProfile(profileDaoService.getUserProfile(loggedInUserId));
		notification.setReceiverProfile(profileDaoService.getUserProfile(targetUserId));
		notification.setNotificationType(Notification.NotificationType.FRIENDREQUEST);
		notificationDao.addNotification(notification);
		return notification.getNotificationId();
				
	}
	public boolean deleteFriendRequest(String notificationId)
	{
		return notificationDao.deleteFriendRequest(notificationId);		
	}
	public TreeMap<String, String> checkFriendReqeustSentByUser(String loggedInUserId)
	{
		List<Notification> list=notificationDao.checkSentFriendRequest(loggedInUserId);
		TreeMap<String, String> hash=new TreeMap<String,String>();
		for(Notification n:list)
		{
			hash.put(n.getReceiverProfile().getUserId(),n.getNotificationId());
		}
		return hash;
	}
	public TreeMap<String, String> checkFriendReqeustReceivedByUser(String loggedInUserId)
	{
		List<Notification> list=notificationDao.checkReceivedFriendRequest(loggedInUserId);
		TreeMap<String, String> hash=new TreeMap<String,String>();
		for(Notification n:list)
		{
			hash.put(n.getSenderProfile().getUserId(), n.getNotificationId());
		}
		return hash;
	}
	public List<Notification> getNotificationAndProfile(String loggedInUserId) {

		return notificationDao.getNotificationAndProfile(loggedInUserId);
	}
}
