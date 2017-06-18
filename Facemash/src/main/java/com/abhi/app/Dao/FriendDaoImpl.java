package com.abhi.app.Dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;

import com.abhi.app.model.Friend;
import com.abhi.app.model.Profile;

public class FriendDaoImpl implements FriendDao {

	@Autowired
	SessionFactory sessionFactory; 
	@SuppressWarnings("unchecked")
	public List<Profile> getFriends(String userId) {
		Session session=sessionFactory.openSession();
		Query query1=session.createQuery("from Friend where userId=:userId");
		query1.setParameter("userId", userId);
		Query query2=session.createQuery("from Friend where friendId=:friendId");
		query2.setParameter("friendId", userId);
		List<Friend> list1=(List<Friend>)query1.getResultList();
		List<Friend> list2=(List<Friend>)query2.getResultList();
		List<String> list=new ArrayList<String>();
		for(Friend f:list1)
			list.add(f.getFriendPk().getFriendId());
		for(Friend f:list2)
			list.add(f.getFriendPk().getUserId());
		List<Profile> profiles=new ArrayList<Profile>();
		if(!list.isEmpty())
		{
		Query query3=session.createQuery("from Profile p where p.userId IN (:list)");
		query3.setParameter("list", list);
		profiles=(List<Profile>)query3.getResultList();
		}
		session.close();
		return profiles;
		
	}
	public boolean addFriend(Friend friend){
		Session session =sessionFactory.getCurrentSession();
		boolean res=false;
		try{
		Transaction t=session.beginTransaction();
		session.persist(friend);
		t.commit();
		res=true;
		}
		catch(HibernateException h)
		{
			h.printStackTrace();
		}
		finally {
			session.close();
		}
		return res;
	}
	public boolean unfriend(String loggedInUserId, String friendId) {
		Session session=sessionFactory.openSession();
		Transaction tx=session.beginTransaction();
		Query query=session.createQuery("delete from Friend f where (f.friendPk.userId=:loggedInUserId or f.friendPk.friendId=:loggedInUserId) "
				+ "and (f.friendPk.userId=:friendId or f.friendPk.friendId=:friendId)").setParameter("loggedInUserId", loggedInUserId)
				.setParameter("friendId", friendId);
		int res=query.executeUpdate();
		tx.commit();
		session.close();
		return res>0?true:false;
	}
	

}
