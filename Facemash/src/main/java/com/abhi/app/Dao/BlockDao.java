package com.abhi.app.Dao;

import java.util.List;

import com.abhi.app.model.Block;

public interface BlockDao {
public boolean block(Block block);
public List<Block> usersWhoBlockedMe(String id,String key);
public boolean isCurrentUserBlocked(String loggedInUser,String userId);
public List<Block> usersBlockedByMe(String id);
public boolean unblock(String loggedInUserId, String unblockedUserId);
}
