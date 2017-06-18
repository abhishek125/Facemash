package com.abhi.app.Dao;

import java.util.List;

import com.abhi.app.model.Notification;

public interface NotificationDao {
public boolean addNotification(Notification notification);

public List<Notification> checkSentFriendRequest(String loggedInUserId);

public boolean deleteFriendRequest(String notificationId);
public Notification getNotification(String notificationId);

public List<Notification> checkReceivedFriendRequest(String loggedInUserId);

public List<Notification> getNotificationAndProfile(String loggedInUserId);
}
