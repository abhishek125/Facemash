package com.abhi.app.Dao;

import java.util.List;

import javax.persistence.Query;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;

import com.abhi.app.model.Block;

public class BlockDaoImpl implements BlockDao {

	@Autowired
	SessionFactory sessionFactory;
	public boolean block(Block block) {
		Session session=sessionFactory.openSession();
		boolean res=false;
		try{
		Transaction t=session.beginTransaction();
		session.persist(block);
		t.commit();
		res=true;
		}catch(HibernateException e){
			e.getMessage();
		}
		finally {
			session.close();
		}
		return res;
	}
	public List<Block> usersWhoBlockedMe(String id,String fieldname)
	{
		Session session=sessionFactory.openSession();
		/*@SuppressWarnings("deprecation")
		Criteria criteria = session.createCriteria(Block.class);
        criteria.add(Restrictions.eq(fieldname,id));
        List<Block> list= criteria.list();*/
		CriteriaBuilder builder = session.getCriteriaBuilder();
		CriteriaQuery<Block> criteria = builder.createQuery(Block.class);
		Root<Block> BlockRoot = criteria.from(Block.class);
		criteria.select(BlockRoot);
		criteria.where(builder.equal(BlockRoot.get("blockPk").get(fieldname), 
		    id));
		List<Block> list =(List<Block>) session.createQuery(criteria).getResultList();
		session.close();
		return list;
		
	}
	public List<Block> usersBlockedByMe(String id)
	{
		return usersWhoBlockedMe(id, "userId");
	}
	public boolean isCurrentUserBlocked(String loggedInUserId,String userId)
	{
		Session session=sessionFactory.openSession();
		Query query=session.createQuery("from Block b where b.blockPk.userId=:userId and b.blockPk.blockedUserId=:loggedInUserId");
		query.setParameter("userId", userId);
		query.setParameter("loggedInUserId", loggedInUserId);
		int res=query.getResultList().size();
		session.close();
		return res>0?true:false;
	}
	public boolean unblock(String loggedInUserId, String unblockedUserId) {
		Session session=sessionFactory.openSession();
		Transaction tx=session.beginTransaction();
		Query query=session.createQuery("delete from Block b where b.blockPk.userId=:loggedInUserId and b.blockPk.blockedUserId=:unblockedUserId");
		query.setParameter("loggedInUserId", loggedInUserId);
		query.setParameter("unblockedUserId", unblockedUserId);
		query.executeUpdate();
		tx.commit();
		session.close();
		return true;
	}
}
