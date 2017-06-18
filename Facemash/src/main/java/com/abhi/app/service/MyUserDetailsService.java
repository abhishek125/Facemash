package com.abhi.app.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.abhi.app.Dao.ProfileDao;
@Service("myUserDetailsService")
public class MyUserDetailsService implements UserDetailsService {
	@Autowired
	private  ProfileDao profileDao;
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		com.abhi.app.model.Profile profile = profileDao.convertMailToProfile(username);
		if(profile==null)
			return null;
		List<GrantedAuthority> grantedAuthorities=new ArrayList<GrantedAuthority>();
		grantedAuthorities.add(new SimpleGrantedAuthority(profile.getRole()));
		return new RequestUserDetails(profile.getMail(),profile.getPassword(),profile.getUserId(),grantedAuthorities);
		
		

	}
	public String getLoggedInUserId()
	{
		Authentication authentication =SecurityContextHolder.getContext().getAuthentication();
		RequestUserDetails requestUserDetails=(RequestUserDetails)authentication.getPrincipal();
		return requestUserDetails.getUserId();
	}

}
