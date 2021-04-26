package com.ndungx.orderdetail;

import java.io.Serializable;

/*
 * @author NDungx
 */
public class OrderDetailDTO implements Serializable {

    private String orderID;
    private String productID;
    private String quantity;

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(String orderID, String productID, String quantity) {
        this.orderID = orderID;
        this.productID = productID;
        this.quantity = quantity;
    }

    /**
     * @return the orderID
     */
    public String getOrderID() {
        return orderID;
    }

    /**
     * @param orderID the orderID to set
     */
    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    /**
     * @return the productID
     */
    public String getProductID() {
        return productID;
    }

    /**
     * @param productID the productID to set
     */
    public void setProductID(String productID) {
        this.productID = productID;
    }

    /**
     * @return the quantity
     */
    public String getQuantity() {
        return quantity;
    }

    /**
     * @param quantity the quantity to set
     */
    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

}
