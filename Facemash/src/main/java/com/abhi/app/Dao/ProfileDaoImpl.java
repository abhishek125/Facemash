package com.abhi.app.Dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaUpdate;
import javax.persistence.criteria.Root;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.abhi.app.model.Profile;

public class ProfileDaoImpl implements ProfileDao {

	@Autowired
	private SessionFactory sessionFactory;
	@Autowired
    private PasswordEncoder passwordEncoder;
	


	public void save(Profile p) {
		p.setPassword(passwordEncoder.encode(p.getPassword()));
		Session session = sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		session.persist(p);
		tx.commit();
		session.close();
	}
	public boolean updateProfilePic(String loggedInUserId,String imagePath) {
		Session session = sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		@SuppressWarnings("rawtypes")
		Query query=session.createQuery("update Profile p set p.profilePic=:profilePic where p.userId=:userId");
		query.setParameter("profilePic", imagePath);
		query.setParameter("userId", loggedInUserId);
		int res=query.executeUpdate();
		tx.commit();
		session.close();
		return res>0?true:false;
	}
	
	public List<Profile> getProfileList(String firstname,String lastname,String loggedInUserId)
	{
		Session session=sessionFactory.openSession();
		@SuppressWarnings("unchecked")
		List<Profile> list=(List<Profile>)session.createQuery("from Profile p where (p.firstname like:firstname"
				+ " or p.lastname like:firstname or p.lastname like:firstname or  p.lastname like:lastname) and (p.userId!=:loggedInUserId)")
		.setParameter("firstname", firstname+"%").setParameter("lastname", lastname+"%").setParameter("loggedInUserId",loggedInUserId).setMaxResults(10).getResultList();
		session.close();
		return list;
		
	}
	@SuppressWarnings("unchecked")
	public Profile convertMailToProfile(String mail) {

		List<Profile> profiles = new ArrayList<Profile>();
		Session session=sessionFactory.openSession();
		profiles = (List<Profile>)session.createQuery("from Profile where mail=:mail")
			.setParameter("mail", mail).getResultList();
		session.close();
		return (profiles.size()>0)?profiles.get(0):null;

	}
	
	public Profile getProfileById(String id)
	{
		Session session=sessionFactory.openSession();
		Profile profile=(Profile)session.createQuery("from Profile p where p.userId=:userId")
		.setParameter("userId", id)
		.getResultList().get(0);
		session.close();
		return profile;
	}
	public int updateProfile(String loggedInUserId,String key,Object value)
	{
		Session session=sessionFactory.openSession();
		Transaction tx = session.beginTransaction();
		CriteriaBuilder builder = session.getCriteriaBuilder();
		CriteriaUpdate<Profile> criteria = builder.createCriteriaUpdate(Profile.class);
		Root<Profile> root = criteria.from(Profile.class);
		criteria.set(root.get(key), value);
		criteria.where(builder.equal(root.get("userId"), loggedInUserId));
		int res=session.createQuery(criteria).executeUpdate();
		tx.commit();
		session.close();
		return res;
		
		 
	}
	public List<Profile> getSuggestions(List<String> excludedSuggestions) {
		Session session=sessionFactory.openSession();
		@SuppressWarnings("unchecked")
		List<Profile> profiles=(List<Profile>)session.createQuery("from Profile p where p.userId not in (:excluded) ORDER BY rand()")
		.setParameter("excluded",excludedSuggestions )
		.setMaxResults(10)
		.getResultList();
		session.close();
		return profiles;
	}
	
}
