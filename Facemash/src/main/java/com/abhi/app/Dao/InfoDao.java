package com.abhi.app.Dao;

import java.util.List;

import com.abhi.app.model.Info;

public interface InfoDao {
public boolean sendMessage(Info info);


public List<Info> getInfoAndProfile(String loggedInUserId,Info.Status status);


public boolean deleteInfo( String infoId,Info.Status status);
}
