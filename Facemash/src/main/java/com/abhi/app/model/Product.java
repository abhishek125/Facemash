package com.abhi.app.model;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
@Entity
@Table(name="product")
public class Product {
@Id
private String productId;
private String textData,uploaderId,images,videos;
private int likes,comments,shares;

public Product(){
	
}

public String getProductId() {
	return productId;
}
public void setProductId(String productId) {
	this.productId = productId;
}


/*public Profile getUploaderProfile() {
	return uploaderProfile;
}
public void setUploaderProfile(Profile uploaderProfile) {
	this.uploaderProfile = uploaderProfile;
}
*/
public String getTextData() {
	return textData;
}
public String getUploaderId() {
	return uploaderId;
}
public void setUploaderId(String uploaderId) {
	this.uploaderId = uploaderId;
}
public void setTextData(String textData) {
	this.textData = textData;
}
public String getImages() {
	return images;
}
public void setImages(String images) {
	this.images = images;
}
public String getVideos() {
	return videos;
}
public void setVideos(String videos) {
	this.videos = videos;
}
public int getLikes() {
	return likes;
}
public void setLikes(int likes) {
	this.likes = likes;
}
public int getComments() {
	return comments;
}
public void setComments(int comments) {
	this.comments = comments;
}
public int getShares() {
	return shares;
}
public void setShares(int shares) {
	this.shares = shares;
}

}
