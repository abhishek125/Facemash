package com.abhi.app.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="notification")
public class Notification {
@Id
private String notificationId;
private NotificationType notificationType;
@ManyToOne
@JoinColumn(name = "senderId")
private Profile senderProfile;
@ManyToOne
@JoinColumn(name = "receiverId")
private Profile receiverProfile;
public static enum NotificationType{
	FRIENDREQUEST,
}
public Notification(){
	
}

public String getNotificationId() {
	return notificationId;
}
public void setNotificationId(String notificationId) {
	this.notificationId = notificationId;
}

public NotificationType getNotificationType() {
	return notificationType;
}
public void setNotificationType(NotificationType notificationType) {
	this.notificationType = notificationType;
}

public Profile getSenderProfile() {
	return senderProfile;
}

public void setSenderProfile(Profile senderProfile) {
	this.senderProfile = senderProfile;
}

public Profile getReceiverProfile() {
	return receiverProfile;
}

public void setReceiverProfile(Profile receiverProfile) {
	this.receiverProfile = receiverProfile;
}



}
