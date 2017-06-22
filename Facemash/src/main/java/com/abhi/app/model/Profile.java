package com.abhi.app.model;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="profile")
public class Profile {
	@Id
	private  String userId;
	@NotNull
	@Size(min=5,max=60)
	@Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
	private  String mail;
	@NotNull
	@Size(min=1,max=45)
	@Pattern(regexp="^[\\p{L}\\s.’\\-,]+$")
	private  String firstname;
	@NotNull
	@Size(min=1,max=45)
	@Pattern(regexp="^[\\p{L}\\s.’\\-,]+$")
	private  String lastname;
	@NotNull
	@Size(min=8, max=65)
	private  String password;
	@NotNull
	private  String role;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@Past
	Date dob;
	private  String profilePic,highSchool,college,work,about,quote,interest,religious,phone,currentCity,homeTown;
	private RelationStatus relationStatus;
	private Gender gender;
	public static enum RelationStatus{
		SINGLE,
		MARRIED;
	}
	public static enum Gender{
		MALE,
		FEMALE,
		OTHER;
	}
	public Profile(){
		
	}
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public Date getDob() {
		return dob;
	}
	public void setDob(Date dob) {
		this.dob = dob;
	}
	public String getProfilePic() {
		return profilePic;
	}
	public void setProfilePic(String profilePic) {
		this.profilePic = profilePic;
	}
	public String getHighSchool() {
		return highSchool;
	}
	public void setHighSchool(String highSchool) {
		this.highSchool = highSchool;
	}
	public String getCollege() {
		return college;
	}
	public void setCollege(String college) {
		this.college = college;
	}
	public String getWork() {
		return work;
	}
	public void setWork(String work) {
		this.work = work;
	}
	public String getAbout() {
		return about;
	}
	public void setAbout(String about) {
		this.about = about;
	}
	public String getQuote() {
		return quote;
	}
	public void setQuote(String quote) {
		this.quote = quote;
	}
	public String getInterest() {
		return interest;
	}
	public void setInterest(String interest) {
		this.interest = interest;
	}
	public String getReligious() {
		return religious;
	}
	public void setReligious(String religious) {
		this.religious = religious;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getCurrentCity() {
		return currentCity;
	}
	public void setCurrentCity(String currentCity) {
		this.currentCity = currentCity;
	}
	public String getHomeTown() {
		return homeTown;
	}
	public void setHomeTown(String homeTown) {
		this.homeTown = homeTown;
	}
	public RelationStatus getRelationStatus() {
		return relationStatus;
	}
	public void setRelationStatus(RelationStatus relationStatus) {
		this.relationStatus = relationStatus;
	}
	public Gender getGender() {
		return gender;
	}
	public void setGender(Gender gender) {
		this.gender = gender;
	}
		
	
	
}
