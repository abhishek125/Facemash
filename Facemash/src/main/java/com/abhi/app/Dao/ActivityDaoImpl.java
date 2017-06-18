package com.abhi.app.Dao;

import java.util.List;

import javax.persistence.Query;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;

import com.abhi.app.model.Activity;
import com.abhi.app.model.Activity.ActivityType;

public class ActivityDaoImpl implements ActivityDao {

	@Autowired
	SessionFactory sessionFactory;
	public List<Activity> getAllFriendActivities(List<String> listOfId) {
		listOfId.add(null);
		Session session=sessionFactory.openSession();
		Transaction tx=session.beginTransaction();
		Query query=session.createQuery("select a from Activity a inner join a.profile where a.profile.userId IN (:friendList) ORDER BY a.date DESC");
		query.setParameter("friendList", listOfId);
		@SuppressWarnings("unchecked")
		List<Activity> list=(List<Activity>)query.getResultList();
		tx.commit();
		session.close();
		return list;
	}
	public boolean saveActivity(Activity activity) {
		Session session=sessionFactory.openSession();
		boolean res=false;
		try{
		Transaction tx=session.beginTransaction();
		session.save(activity);
		tx.commit();
		res=true;
		}
		catch(HibernateException h){
			h.printStackTrace();
		}
		finally {
			session.close();	
		}
		return res;
	}
	public List<Activity> getLikesOrSharesOfUser(String loggedInUserId,Activity.ActivityType activityType ) {
		Session session=sessionFactory.openSession();
		@SuppressWarnings("unchecked")
		List<Activity> list=(List<Activity>)session.createQuery("from Activity a where a.profile.userId=:loggedInUserId and a.activityType=:activityType")
				.setParameter("loggedInUserId", loggedInUserId)
				.setParameter("activityType", activityType)
				.getResultList();
				;
				session.close();
		return list;
	}
	public List<Activity> getUserComments(String loggedInUserId) {
		Session session=sessionFactory.openSession();
		@SuppressWarnings("unchecked")
		List<Activity> list=(List<Activity>)session.createQuery("from Activity a where a.activityType=:activityType and a.profile.userId=:loggedInUserId ORDER BY a.date DESC")
				.setParameter("activityType", ActivityType.COMMENT)
				.setParameter("loggedInUserId",loggedInUserId )
				.getResultList();
		session.close();
		return list;
		
	}
	public List<Activity> getAllComments(List<String> products) {
		products.add(null);
		Session session=sessionFactory.openSession();
		@SuppressWarnings("unchecked")
		List<Activity> list=(List<Activity>)session.createQuery("from Activity a where a.activityType=:activity and a.product.productId IN (:products) ORDER BY a.date DESC")
				.setParameter("activity", ActivityType.COMMENT)
				.setParameter("products",products)
				.getResultList();
		session.close();
		return list;
		
	}
	public boolean deleteActivity(String productId, ActivityType activityType, String loggedInUserId) {
		Session session=sessionFactory.openSession();
		boolean res=false;
		try{
			Transaction tx=session.beginTransaction();
			session.createQuery("delete from Activity a where a.product.productId=:productId and "
					+ "a.activityType=:activityType and a.profile.userId=:userId")
			.setParameter("productId", productId)
			.setParameter("activityType", activityType)
			.setParameter("userId", loggedInUserId)
			.executeUpdate();
			tx.commit();
			res=true;
		}catch(HibernateException h){
			h.printStackTrace();
		}
		finally {
			session.close();
		}
		return res;
	}
	public List<Activity> getMyActivities(String userId) {
		Session session=sessionFactory.openSession();
		@SuppressWarnings("unchecked")
		List<Activity> list=(List<Activity>)session.createQuery("from Activity a where a.profile.userId=:userId ORDER BY a.date DESC")
				.setParameter("userId",userId )
				.getResultList();
		session.close();
		return list;

	}

	

}
