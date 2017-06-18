package com.abhi.app.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="activity")
public class Activity {
@Id
private String activityId;
@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
private Date date;
private String text;
private ActivityType activityType;

public static enum ActivityType
{
	STATUS,
	COMMENT,
	LIKE,
	SHARE;
}
public Activity(){
	
}
@OneToOne
@JoinColumn(name="userId")
Profile profile;
@OneToOne
@JoinColumn(name="productId")
Product product;

public String getActivityId() {
	return activityId;
}
public void setActivityId(String activityId) {
	this.activityId = activityId;
}
public Date getDate() {
	return date;
}
public void setDate(Date date) {
	this.date = date;
}
public ActivityType getActivityType() {
	return activityType;
}
public void setActivityType(ActivityType activityType) {
	this.activityType = activityType;
}
public Profile getProfile() {
	return profile;
}
public void setProfile(Profile profile) {
	this.profile = profile;
}
public Product getProduct() {
	return product;
}
public void setProduct(Product product) {
	this.product = product;
}
public String getText() {
	return text;
}
public void setText(String text) {
	this.text = text;
}


}
