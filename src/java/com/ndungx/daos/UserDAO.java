package com.ndungx.daos;

import com.ndungx.dtos.UserDTO;
import com.ndungx.utils.DBUtils;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/*
 * @author NDungx
 */
public class UserDAO implements Serializable {

    public UserDTO checkLogin(String userID, String password)
            throws SQLException, NamingException {
        UserDTO user = null;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "select fullname, roleID, phone, email, address "
                        + "from tblUser "
                        + "where userID = ? and password = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, userID);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String fullname = rs.getString("fullname");
                    String roleID = rs.getString("roleID");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    String address = rs.getString("address");
                    user = new UserDTO(userID, fullname, roleID, phone, email, address, "");
                }
            }
        } finally {
            if (con != null) {
                con.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        return user;
    }

    private List<UserDTO> listAccount;

    public List<UserDTO> getListAccount() {
        return listAccount;
    }

    public List<UserDTO> getListUser(String search)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "select userID, fullname, roleID, phone, email, address "
                        + "from tblUser "
                        + "where fullname like ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + search + "%");
                rs = stm.executeQuery();
                while (rs.next()) {
                    String userID = rs.getString("userID");
                    String fullname = rs.getString("fullname");
                    String roleID = rs.getString("roleID");
                    String phone = rs.getString("phone");
                    String email = rs.getString("email");
                    String address = rs.getString("address");
                    String password = "******";
                    UserDTO dto = new UserDTO(userID, fullname, roleID, phone, email, address, password);
                    if (this.listAccount == null) {
                        this.listAccount = new ArrayList<>();
                    }
                    this.listAccount.add(dto);
                }
            }
        } finally {
            if (con != null) {
                con.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        return listAccount;
    }

    public boolean deleteAccount(String userID)
            throws SQLException, NamingException {
        boolean check = false;
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "delete from tblUser "
                        + "where userID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, userID);
                check = stm.executeUpdate() == 0 ? false : true;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return check;
    }

    public boolean updateAccount(UserDTO user)
            throws SQLException, NamingException {
        boolean check = false;
        Connection con = null;
        PreparedStatement stm = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "update tblUser "
                        + "set fullname = ?, roleID = ? "
                        + "where userID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, user.getFullname());
                stm.setString(2, user.getRoleID());
                stm.setString(3, user.getUserID());
                check = stm.executeUpdate() == 0 ? false : true;
            }
        } finally {
            if (con != null) {
                con.close();
            }
            if (stm != null) {
                stm.close();
            }
        }
        return check;
    }

    public boolean checkDuplicate(String userID)
            throws SQLException, NamingException {
        boolean check = false;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "select userID "
                        + "from tblUser "
                        + "where userID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    check = true;
                }
            }
        } finally {
            if (con != null) {
                con.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        return check;
    }

    public boolean createAccount(UserDTO dto)
            throws SQLException, NamingException {
        boolean check = false;
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            con = DBUtils.makeConnection();
            if (con != null) {
                String sql = "insert into tblUser(userID, fullname, roleID, [password]) "
                        + "values(?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, dto.getUserID());
                stm.setString(2, dto.getFullname());
                stm.setString(3, dto.getRoleID());
                stm.setString(4, dto.getPassword());
                check = stm.executeUpdate() == 0 ? false : true;
                if (rs.next()) {
                    check = true;
                }
            }
        } finally {
            if (con != null) {
                con.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        return check;
    }
}
