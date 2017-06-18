package com.abhi.app.Dao;

import java.util.List;

import com.abhi.app.model.Product;

public interface ProductDao {
public boolean saveProduct(Product product);
public List<Product> getAllProductsOfUser(String userId);
public Product getProduct(String productId);
public void updateProductProperty(String propertyName, String productId,int counter);
}
