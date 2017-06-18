package com.abhi.app.Dao;


import java.util.List;

import javax.persistence.Query;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;

import com.abhi.app.model.Info;

public class InfoDaoImpl implements InfoDao {

	@Autowired 
	SessionFactory sessionFactory;
	public boolean sendMessage(Info info) {
		Session session=sessionFactory.openSession();
		boolean res=false;
		try{
		Transaction tx=session.beginTransaction();
		session.persist(info);
		tx.commit();
		res=true;
		}
		catch(HibernateException e)
		{
			e.getMessage();
		}
		finally {
			session.close();
		}
		return res;
	}
	public List<Info> getInfoAndProfile(String loggedInUserId,Info.Status status) {
		Session session =sessionFactory.openSession();
		@SuppressWarnings("unchecked")
		List<Info> list=(List<Info>)session.createQuery("select i from Info i inner join i.receiverProfile where i.receiverProfile.userId=:userId and i.receiverStatus=:status ORDER BY i.dateSent DESC").setParameter("userId",loggedInUserId).setParameter("status",status).getResultList();
		session.close();
		return list;
	}
	public boolean deleteInfo(String infoId,Info.Status status) {
		Session session=sessionFactory.openSession();
		boolean res=false;
		try{
		Transaction tx=session.beginTransaction();
		Query query=session.createQuery("update Info i set i.receiverStatus=:status where i.infoId=:infoId");
		query.setParameter("infoId", infoId).setParameter("status", status);
		res=query.executeUpdate()>0?true:false;
		tx.commit();
		}
		catch(HibernateException e)
		{
			e.getMessage();
		}
		finally {
			session.close();
		}
		return res;		
	}
	

}
