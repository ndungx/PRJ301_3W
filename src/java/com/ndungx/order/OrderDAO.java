package com.ndungx.order;

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
public class OrderDAO implements Serializable {

    private List<OrderDTO> listOrder;

    public List<OrderDTO> getListOrder() {
        return this.listOrder;
    }

    public boolean addOrder(String userID, float total, String address)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "insert into dbo.[Order]([userID], [date], total, [address]) "
                        + "values(?, CURRENT_TIMESTAMP, ?, ?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, userID);
                stm.setFloat(2, total);
                stm.setString(3, address);

                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (con != null) {
                con.close();
            }
            if (stm != null) {
                stm.close();
            }
        }
        return false;
    }

    public boolean rollBackOrder(int orderID)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "delete from dbo.[Order] "
                        + "where orderID = ?; "
                        + "DBCC CHECKIDENT ('[Order]', RESEED, ?);";
                stm = con.prepareStatement(sql);
                stm.setInt(1, orderID);
                stm.setInt(2, orderID - 1);
                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (con != null) {
                con.close();
            }
            if (stm != null) {
                stm.close();
            }
        }
        return false;
    }

    public int getLastOrderID(String userID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "select max(orderID) as orderID "
                        + "from dbo.[Order] "
                        + "where userID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    int orderID = rs.getInt("orderID");
                    return orderID;
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

    public String getOrderDate(int orderID)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "select [date] as [date] "
                        + "from dbo.[Order] "
                        + "where orderID = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, orderID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String date = rs.getString("date");
                    return date;
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
        return null;
    }

    public String getProductName(int productID)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "select [productName] as [productName] "
                        + "from dbo.[Product] "
                        + "where productID = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, productID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String productName = rs.getString("productName");
                    return productName;
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
        return null;
    }
}
