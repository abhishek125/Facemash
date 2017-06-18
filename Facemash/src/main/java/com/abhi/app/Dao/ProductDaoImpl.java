package com.abhi.app.Dao;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaUpdate;
import javax.persistence.criteria.Root;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;

import com.abhi.app.model.Product;

public class ProductDaoImpl implements ProductDao {

	@Autowired
	private SessionFactory sessionFactory;
	public boolean saveProduct(Product product) {
		Session session=sessionFactory.openSession();
		boolean res=false;
		try{
		Transaction tx=session.beginTransaction();
		session.save(product);
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
	public List<Product> getAllProductsOfUser(String userId)
	{
		Session session=sessionFactory.openSession();
		@SuppressWarnings("rawtypes")
		Query query=session.createQuery("from Product p where p.uploaderId=:uploaderId");
		query.setParameter("uploaderId", userId);
		@SuppressWarnings("unchecked")
		List<Product> products=(List<Product>)query.getResultList();
		session.close();
		return products;
	}
	public Product getProduct(String productId) {
		Session session=sessionFactory.openSession();
		Product p= session.get(Product.class, productId);
		session.close();
		return p;
	}
	public void updateProductProperty(String propertyName,String productId,int counter) {
		Session session=sessionFactory.openSession();
		Transaction tx=session.beginTransaction();
		CriteriaBuilder builder = session.getCriteriaBuilder();
		CriteriaUpdate<Product> criteria = builder.createCriteriaUpdate(Product.class);
		Root<Product> root = criteria.from(Product.class);
		criteria.set(root.get(propertyName), counter);
		criteria.where(builder.equal(root.get("productId"), productId));
		session.createQuery(criteria).executeUpdate();
		tx.commit();
		session.close();
	}

}
