package com.abhi.app.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="info")
public class Info {
	@Id
	private String infoId;
	private String infoText,videos,images;
private Status receiverStatus;
private Status senderStatus;
@ManyToOne
@JoinColumn(name = "senderId")
private Profile senderProfile;
@ManyToOne
@JoinColumn(name = "receiverId")
private Profile receiverProfile;
@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
private Date dateSent;
public static enum Status{
	READ,
	UNREAD,
	DELETED;
	
}
public Info(){
	
}

public String getInfoId() {
	return infoId;
}
public void setInfoId(String infoId) {
	this.infoId = infoId;
}

public String getInfoText() {
	return infoText;
}
public void setInfoText(String infoText) {
	this.infoText = infoText;
}

public String getVideos() {
	return videos;
}
public void setVideos(String videos) {
	this.videos = videos;
}
public String getImages() {
	return images;
}
public void setImages(String images) {
	this.images = images;
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

public Status getReceiverStatus() {
	return receiverStatus;
}

public void setReceiverStatus(Status receiverStatus) {
	this.receiverStatus = receiverStatus;
}

public Status getSenderStatus() {
	return senderStatus;
}

public void setSenderStatus(Status senderStatus) {
	this.senderStatus = senderStatus;
}

public Date getDateSent() {
	return dateSent;
}

public void setDateSent(Date dateSent) {
	this.dateSent = dateSent;
}




}
