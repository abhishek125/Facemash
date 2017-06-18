package com.abhi.app.model;

import java.io.Serializable;

import javax.persistence.Embeddable;

@Embeddable
public class FriendPK implements Serializable {
    
	private static final long serialVersionUID = 1L;
	protected String userId;
    protected String friendId;

    public FriendPK() {}

    public FriendPK(String userId, String friendId) {
        this.userId=userId;
        this.friendId=friendId;
    }
    // equals, hashCode

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getFriendId() {
		return friendId;
	}

	public void setFriendId(String friendId) {
		this.friendId = friendId;
	}
    
}
