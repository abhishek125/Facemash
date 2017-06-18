package com.abhi.app.Dao;

import java.util.List;

import javax.persistence.Query;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;

import com.abhi.app.model.Notification;

public class NotificationDaoImpl implements NotificationDao {

	@Autowired
	SessionFactory sessionFactory;
	public boolean addNotification(Notification notification) {
		Session session=sessionFactory.openSession();
		boolean res=false;
		try{
		Transaction t=session.beginTransaction();
		session.persist(notification);
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
	public Notification getNotification(String notificationId)
	{
		Session session=sessionFactory.openSession();
		Notification notification=session.get(Notification.class, notificationId);
		session.close();
		return notification;
	}
	public List<Notification> checkSentFriendRequest(String loggedInUserId) {
		Session session=sessionFactory.openSession();
		Query query=session.createQuery("from Notification n where n.senderProfile.userId=:senderId");
		@SuppressWarnings("unchecked")
		List<Notification> list=(List<Notification>)query.setParameter("senderId", loggedInUserId).getResultList();
		session.close();
		return list;
	}
	public boolean deleteFriendRequest(String notificationId) {
		Session session=sessionFactory.openSession();
		Transaction tx=session.beginTransaction();
		Query query=session.createQuery("delete from Notification n where n.notificationId=:notificationId");
		query.setParameter("notificationId", notificationId);
		query.executeUpdate();
		tx.commit();
		session.close();
		return true;
	}
	@SuppressWarnings("unchecked")
	public List<Notification> checkReceivedFriendRequest(String loggedInUserId) {
		Session session= sessionFactory.openSession();
		List<Notification> list=(List<Notification>)session.createQuery("from Notification n where n.receiverProfile.userId=:receiverId").setParameter("receiverId", loggedInUserId).getResultList();
		session.close();
		return list;
	}
	public List<Notification> getNotificationAndProfile(String loggedInUserId) {
		Session session =sessionFactory.openSession();
		@SuppressWarnings("unchecked")
		List<Notification> list=(List<Notification>)session.createQuery("select n from Notification n inner join n.receiverProfile where n.receiverProfile.userId=:userId").setParameter("userId", loggedInUserId).getResultList();
		session.close();
		return list;
	}

}
