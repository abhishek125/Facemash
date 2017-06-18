package com.abhi.app.Dao;

import java.util.List;

import com.abhi.app.model.Profile;

public interface ProfileDao {
	public void save(Profile p);
	public Profile convertMailToProfile(String mail);
	public Profile getProfileById(String id);
	public int updateProfile(String loggedInUserId,String key,Object value);
	public boolean updateProfilePic(String loggedInUserId,String imagePath);
	public List<Profile> getProfileList(String firstname,String lastname,String loggedInUserId);
	public List<Profile> getSuggestions(List<String> excludedSuggestions);
}
