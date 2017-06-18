package com.abhi.app.service;
import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
public class RequestUserDetails extends User {
private static final long serialVersionUID = -6411988532329234916L;
private String userId;

public RequestUserDetails(String username, String password, String userId,
    Collection<? extends GrantedAuthority> authorities) {
super(username, password, authorities);
this.userId = userId;
}

public String getUserId() {
return userId;
}
}