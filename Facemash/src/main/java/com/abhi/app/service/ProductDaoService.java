package com.abhi.app.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.abhi.app.Dao.ProductDao;
import com.abhi.app.model.Activity.ActivityType;
import com.abhi.app.model.Product;

@Service
public class ProductDaoService {

	@Autowired
	private ProductDao productDao;
	@Autowired
	private Utils utils;
	@Autowired
	ActivityDaoService activityDaoService;
	public boolean saveProduct(String loggedInUserId,String status, String images,String videos)
	{
		Product product=new Product();
		String productId=utils.nextUniqueId();
		product.setProductId(productId);
		product.setTextData(status);
		product.setImages(images);
		product.setVideos(videos);
		product.setUploaderId(loggedInUserId);
		product.setComments(0);
		product.setLikes(0);
		product.setShares(0);
		boolean res1=productDao.saveProduct(product);	
		boolean res2=activityDaoService.addStatusActivity(product,ActivityType.STATUS);
		return (res1==true&&res2==true);
	}
	public Product getProduct(String productId)
	{
		return productDao.getProduct(productId);
	}
	public List<Product> getAllProductsOfUser(String userId)
	{
		return productDao.getAllProductsOfUser(userId);
	}
	public void updateProductProperty(String propertyName, String productId,int counter) {
		productDao.updateProductProperty(propertyName,productId,counter);
		return ;
	}
 	
	
}
