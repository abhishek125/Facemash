package com.abhi.app.Dao;

import java.util.List;

import com.abhi.app.model.Friend;
import com.abhi.app.model.Profile;

public interface FriendDao {

	public List<Profile> getFriends(String userId);
	public boolean addFriend(Friend f);
	public boolean unfriend(String loggedInUserId,String friendId);
}
