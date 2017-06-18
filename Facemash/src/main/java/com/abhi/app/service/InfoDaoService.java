package com.abhi.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.abhi.app.Dao.InfoDao;
import com.abhi.app.model.Info;
import com.abhi.app.model.Profile;

public class InfoDaoService {
	@Autowired
	private InfoDao infoDao;
	@Autowired
	private Utils utils;
	@Autowired
	private ProfileDaoService profileDaoService;
public boolean sendMessage(String loggedInuserId,String receiverId,String text,String images,String videos)
{
	Profile profile=null;
	profile = profileDaoService.getUserProfile(receiverId);
	if(profile==null)
		return false;
	Info info=new Info();
	info.setInfoId(utils.nextUniqueId());
	info.setReceiverProfile(profileDaoService.getUserProfile(receiverId));
	info.setSenderProfile(profileDaoService.getUserProfile(loggedInuserId));
	
	info.setInfoText(text);
	info.setImages(images);
	info.setVideos(videos);
	info.setSenderStatus(Info.Status.UNREAD);
	info.setReceiverStatus(Info.Status.UNREAD);
	info.setDateSent(utils.currentDateAndTime("yyyy-MM-dd HH:mm:ss"));
	boolean res=infoDao.sendMessage(info);
	return res;
}
public List<Info> getInfoAndProfile(String loggedInUserId,Info.Status status) {

	return infoDao.getInfoAndProfile(loggedInUserId, status);
}
public boolean deleteInfo( String infoId,Info.Status status) {
return infoDao.deleteInfo(infoId, status);
}
}
