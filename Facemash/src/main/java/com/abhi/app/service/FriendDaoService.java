package com.abhi.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.abhi.app.Dao.FriendDao;
import com.abhi.app.Dao.NotificationDao;
import com.abhi.app.model.Friend;
import com.abhi.app.model.FriendPK;
import com.abhi.app.model.Notification;
import com.abhi.app.model.Profile;

public class FriendDaoService {

	@Autowired 
	private FriendDao friendDao;
	@Autowired
	private NotificationDao notificationDao;
	public List<Profile> getFriends(String userId)
	{
		return friendDao.getFriends(userId);
	}
	public boolean addFriend(String notificationId)
	{
		Notification notification=notificationDao.getNotification(notificationId);
		FriendPK frpk=new FriendPK();
		frpk.setUserId(notification.getSenderProfile().getUserId());
		frpk.setFriendId(notification.getReceiverProfile().getUserId());
		Friend f=new Friend();
		f.setFriendPk(frpk);
		return friendDao.addFriend(f);
	}
	public boolean unfriend(String loggedInUserId,String friendId)
	{
		return friendDao.unfriend(loggedInUserId, friendId);
	}
}
