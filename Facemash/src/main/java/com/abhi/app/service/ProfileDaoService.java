package com.abhi.app.service;

import java.text.ParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.abhi.app.Dao.ProfileDao;
import com.abhi.app.model.Profile;

@Service
public class ProfileDaoService {

	@Autowired
	private ProfileDao profileDao;
	@Autowired
	private Utils utils;
	/*updates individual proerties of user profile*/
	public boolean updateProfile(String loggedInUserId,String key, String value)
	{
	if(key.equalsIgnoreCase("relationstatus"))
	{
		if(value.equalsIgnoreCase("married"))
			profileDao.updateProfile(loggedInUserId, "relationStatus", Profile.RelationStatus.MARRIED);
		else
			profileDao.updateProfile(loggedInUserId, "relationStatus", Profile.RelationStatus.SINGLE);
			
	}
	else if(key.equalsIgnoreCase("gender"))
	{
		if(value.equalsIgnoreCase("male"))
			profileDao.updateProfile(loggedInUserId, "gender", Profile.Gender.MALE);
		else
			profileDao.updateProfile(loggedInUserId, "gender", Profile.Gender.FEMALE);
			
	}
	else if(key.equalsIgnoreCase("dob"))
	{
		try {
			profileDao.updateProfile(loggedInUserId, "dob", utils.newDate(value, "yyyy-MM-dd", "yyyy-MM-dd"));
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	else
	{
		profileDao.updateProfile(loggedInUserId,key,value);
	}
		return true;
	}
	/*save profile of a user*/
	public boolean saveProfile(Profile profile , String confirm)  {
		Profile exist=profileDao.convertMailToProfile(profile.getMail());
		if (exist!=null  || !confirm.equals(profile.getPassword()))
			return false;
		profile.setUserId(utils.nextUniqueId());
		profile.setRole("ROLE_USER");
		profile.setProfilePic("/uploads/avatar.png");
		profileDao.save(profile);
		return true;
	}
	
	/*updates profile pic*/
	public boolean updateProfilePic(String loggedInUserId,String pathOfimage)
	{
		return 	profileDao.updateProfilePic(loggedInUserId,pathOfimage);
	}

	/*public String getLoggedInUserId(String mail)
	{
		String s=profileDao.convertMailToId(mail);
		return s;		
	}*/

	/*get profile using id of user*/
	public Profile getUserProfile(String userId)  {
		Profile profile=profileDao.getProfileById(userId);
		return profile;
	}
	public List<Profile> getSuggestions(List<String> excludedSuggestions) {
		return profileDao.getSuggestions(excludedSuggestions);
	}
	
}
