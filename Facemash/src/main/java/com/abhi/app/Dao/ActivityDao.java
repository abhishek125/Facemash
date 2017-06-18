package com.abhi.app.Dao;

import java.util.List;

import com.abhi.app.model.Activity;
import com.abhi.app.model.Activity.ActivityType;

public interface ActivityDao {
public List<Activity> getAllFriendActivities(List<String> listOfId);

public boolean saveActivity(Activity activity);

public List<Activity> getLikesOrSharesOfUser(String loggedInUserId,Activity.ActivityType activityType );

public List<Activity> getUserComments(String loggedInUserId);
public List<Activity> getAllComments(List<String> products);

public boolean deleteActivity(String productId, ActivityType activityType, String loggedInUserId);

public List<Activity> getMyActivities(String userId);
}
