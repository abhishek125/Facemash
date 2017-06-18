package com.abhi.app.model;

import java.io.Serializable;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="friends")
public class Friend implements Serializable {
	
	private static final long serialVersionUID = 1L;
	@EmbeddedId
	private FriendPK friendPk;
	public Friend(){
		
	}
	public FriendPK getFriendPk() {
		return friendPk;
	}

	public void setFriendPk(FriendPK friendPk) {
		this.friendPk = friendPk;
	}
	
	
}
