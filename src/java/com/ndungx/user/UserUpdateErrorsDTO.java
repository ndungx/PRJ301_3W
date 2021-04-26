package com.ndungx.user;

import java.io.Serializable;

/*
 * @author NDungx
 */
public class UserUpdateErrorsDTO implements Serializable {

    private String fullnameLengthErr;
    private String roleIDLengthErr;

    public UserUpdateErrorsDTO() {
    }

    /**
     * @return the fullnameLengthErr
     */
    public String getFullnameLengthErr() {
        return fullnameLengthErr;
    }

    /**
     * @param fullnameLengthErr the fullnameLengthErr to set
     */
    public void setFullnameLengthErr(String fullnameLengthErr) {
        this.fullnameLengthErr = fullnameLengthErr;
    }

    /**
     * @return the roleIDLengthErr
     */
    public String getRoleIDLengthErr() {
        return roleIDLengthErr;
    }

    /**
     * @param roleIDLengthErr the roleIDLengthErr to set
     */
    public void setRoleIDLengthErr(String roleIDLengthErr) {
        this.roleIDLengthErr = roleIDLengthErr;
    }

}
