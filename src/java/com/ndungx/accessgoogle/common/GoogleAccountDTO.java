package com.ndungx.accessgoogle.common;

import java.io.Serializable;

/*
 * @author NDungx
 */
public class GoogleAccountDTO implements Serializable {

    private String userID;
    private String fullname;
    private String roleID;

    public GoogleAccountDTO() {
    }

    public GoogleAccountDTO(String userID, String fullname, String roleID) {
        this.userID = userID;
        this.fullname = fullname;
        this.roleID = roleID;
    }

    /**
     * @return the userID
     */
    public String getUserID() {
        return userID;
    }

    /**
     * @param userID the userID to set
     */
    public void setUserID(String userID) {
        this.userID = userID;
    }

    /**
     * @return the fullname
     */
    public String getFullname() {
        return fullname;
    }

    /**
     * @param fullname the fullname to set
     */
    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    /**
     * @return the roleID
     */
    public String getRoleID() {
        return roleID;
    }

    /**
     * @param roleID the roleID to set
     */
    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

}
