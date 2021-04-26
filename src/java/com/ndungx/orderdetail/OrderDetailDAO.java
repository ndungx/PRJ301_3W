package com.ndungx.orderdetail;

import com.ndungx.utils.DBUtils;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;

/*
 * @author NDungx
 */
public class OrderDetailDAO implements Serializable {

    private List<OrderDetailDTO> listOrderDetail;

    public List<OrderDetailDTO> getListOrderDetail() {
        return this.listOrderDetail;
    }

    public boolean addOrderDetail(int orderID, int productID, int quantity)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "insert into dbo.OrderDetail(orderID, productID, quantity) "
                        + "values(? ,? ,?)";
                stm = con.prepareStatement(sql);
                stm.setInt(1, orderID);
                stm.setInt(2, productID);
                stm.setInt(3, quantity);

                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public boolean rollBackOrderDetail(int orderID)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "delete from dbo.OrderDetail "
                        + "where orderID = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, orderID);
                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public int getQuantity(int productID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "select quantity "
                        + "from Product "
                        + "where [productID] = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, productID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int quantity = rs.getInt("quantity");
                    return quantity;
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return 0;
    }

    public boolean updateQuantity(int productID, int quantity)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "update dbo.Product "
                        + "set quantity = ? "
                        + "where productID = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, quantity);
                stm.setInt(2, productID);

                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public boolean rollBackQuantity(int productID, int quantityRollBack)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "update dbo.Product "
                        + "set quantity = ? "
                        + "where productID = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, quantityRollBack);
                stm.setInt(2, productID);

                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

}
