package com.ndungx.controller;

import com.ndungx.product.ProductDTO;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/*
 * @author NDungx
 */
public class CartObj implements Serializable {

    private Map<Integer, ProductDTO> cart;

    public CartObj() {
    }

    public CartObj(Map<Integer, ProductDTO> cart) {
        this.cart = cart;
    }

    //key là productID
    public Map<Integer, ProductDTO> getCart() {
        return cart;
    }

    public int getSize() {
        return cart.size();
    }

    public void setCart(Map<Integer, ProductDTO> cart) {
        this.cart = cart;
    }

    public void add(ProductDTO product) {
        if (cart == null) {
            cart = new HashMap<>();
        }
        if (cart.containsKey(product.getProductID())) {
            int quantity = cart.get(product.getProductID()).getQuantity();
            product.setQuantity(quantity + product.getQuantity());
        }
        cart.put(product.getProductID(), product);
    }

    public void delete(int id) {
        if (cart == null) {
            return;
        }
        if (cart.containsKey(id)) {
            cart.remove(id);
        }
    }

    public void update(int id, ProductDTO product) {
        if (cart == null) {
            return;
        }
        if (cart.containsKey(id)) {
            cart.replace(id, product);
        }
    }

}
