package com.abhi.app.model;

import java.io.Serializable;
import javax.persistence.Embeddable;

@Embeddable
public class BlockPK implements Serializable {

	private static final long serialVersionUID = 1L;
	protected String userId;
    protected String blockedUserId;
    public BlockPK(){
    	
    }
    public BlockPK(String userId, String blockedUserId) {
        this.userId=userId;
        this.blockedUserId=blockedUserId;
    }
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getBlockedUserId() {
		return blockedUserId;
	}
	public void setBlockedUserId(String blockedUserId) {
		this.blockedUserId = blockedUserId;
	}
	

}
