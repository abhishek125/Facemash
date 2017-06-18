package com.abhi.app.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;

import com.abhi.app.Dao.BlockDao;
import com.abhi.app.Dao.FriendDao;
import com.abhi.app.Dao.ProfileDao;
import com.abhi.app.model.Block;
import com.abhi.app.model.Profile;

public class UserSearchService {
@Autowired 
private ProfileDao profileDao;
@Autowired
private FriendDao friendDao;

@Autowired
private BlockDao blockDao;

public List<Profile> searchUsers(String firstname,String lastname,String loggedInUserId)
{
	List<Profile> list=profileDao.getProfileList(firstname,lastname,loggedInUserId);
	return list;
}
public List<Profile> searchValidUsers(String firstname,String lastname,String loggedInUserId)
{
	
	List<Profile>  allUsers=searchUsers(firstname,lastname,loggedInUserId);
	Set<String> set=new TreeSet<String>();
	/*set= getFriends(loggedInUserId,set);//exclude friends*/
	set=usersWhoBlockedMe(loggedInUserId, set);//also exclude users who have blocked loggedinuser
	List<Profile> list=new ArrayList<Profile>();
	for(Profile p:allUsers)
	{	
		if(!set.contains(p.getUserId()))
			list.add(p);
		
	}
	return list;
}
public Set<String> getFriends(String loggedInUserId,Set<String> set) {
	List<Profile> friends=friendDao.getFriends(loggedInUserId);
	for(int i=0;i<friends.size();i++)
		set.add(friends.get(i).getUserId());
	return set;
}
private Set<String> usersWhoBlockedMe(String loggedInUserId,Set<String> friends)
{
	List<Block> list=blockDao.usersWhoBlockedMe(loggedInUserId,"blockedUserId");
	for(Block b:list)
		friends.add(b.getBlockPk().getUserId());
	return friends;
}
}
