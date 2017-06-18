package com.abhi.app.service;

import java.util.List;
import java.util.TreeSet;

import org.springframework.beans.factory.annotation.Autowired;

import com.abhi.app.Dao.BlockDao;
import com.abhi.app.model.Block;
import com.abhi.app.model.BlockPK;

public class BlockDaoService {
@Autowired 
private BlockDao blockDao;
public boolean blockUser(String loggedInUserId,String blockedUserId)
{
	Block block=new Block();
	block.setBlockPk(new BlockPK());
	block.getBlockPk().setUserId(loggedInUserId);
	block.getBlockPk().setBlockedUserId(blockedUserId);
	return blockDao.block(block);
}
public boolean unblockUser(String loggedInUserId,String unblockedUserId)
{
	return blockDao.unblock(loggedInUserId,unblockedUserId);
}
public boolean isCurrentUserBlocked(String loggedInUserId,String userId)
{
	return blockDao.isCurrentUserBlocked(loggedInUserId,userId);
}
public TreeSet<String > usersBlockedByMe(String loggedInUserId)
{
	TreeSet<String > set=new TreeSet<String >();
	List<Block> list=blockDao.usersBlockedByMe(loggedInUserId);
	for(Block b:list)
		set.add(b.getBlockPk().getBlockedUserId());
	return set;
}
}
