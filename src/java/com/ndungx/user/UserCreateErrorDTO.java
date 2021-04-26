package com.ndungx.user;

import java.io.Serializable;

/*
 * @author NDungx
 */
public class UserCreateErrorDTO implements Serializable {

    private String userIDError;
    private String fullnameError;
    private String roleIDError;
    private String phoneError;
    private String emailError;
    private String addressError;
    private String passwordError;
    private String confirmError;
    private String userIDDuplicateError;

    public UserCreateErrorDTO() {
    }

    public UserCreateErrorDTO(String userIDError, String fullnameError, String roleIDError, String phoneError, String emailError, String addressError, String passwordError, String confirmError, String userIDDuplicateError) {
        this.userIDError = userIDError;
        this.fullnameError = fullnameError;
        this.roleIDError = roleIDError;
        this.phoneError = phoneError;
        this.emailError = emailError;
        this.addressError = addressError;
        this.passwordError = passwordError;
        this.confirmError = confirmError;
        this.userIDDuplicateError = userIDDuplicateError;
    }

    /**
     * @return the userIDError
     */
    public String getUserIDError() {
        return userIDError;
    }

    /**
     * @param userIDError the userIDError to set
     */
    public void setUserIDError(String userIDError) {
        this.userIDError = userIDError;
    }

    /**
     * @return the fullnameError
     */
    public String getFullnameError() {
        return fullnameError;
    }

    /**
     * @param fullnameError the fullnameError to set
     */
    public void setFullnameError(String fullnameError) {
        this.fullnameError = fullnameError;
    }

    /**
     * @return the roleIDError
     */
    public String getRoleIDError() {
        return roleIDError;
    }

    /**
     * @param roleIDError the roleIDError to set
     */
    public void setRoleIDError(String roleIDError) {
        this.roleIDError = roleIDError;
    }

    /**
     * @return the phoneError
     */
    public String getPhoneError() {
        return phoneError;
    }

    /**
     * @param phoneError the phoneError to set
     */
    public void setPhoneError(String phoneError) {
        this.phoneError = phoneError;
    }

    /**
     * @return the emailError
     */
    public String getEmailError() {
        return emailError;
    }

    /**
     * @param emailError the emailError to set
     */
    public void setEmailError(String emailError) {
        this.emailError = emailError;
    }

    /**
     * @return the addressError
     */
    public String getAddressError() {
        return addressError;
    }

    /**
     * @param addressError the addressError to set
     */
    public void setAddressError(String addressError) {
        this.addressError = addressError;
    }

    /**
     * @return the passwordError
     */
    public String getPasswordError() {
        return passwordError;
    }

    /**
     * @param passwordError the passwordError to set
     */
    public void setPasswordError(String passwordError) {
        this.passwordError = passwordError;
    }

    /**
     * @return the confirmError
     */
    public String getConfirmError() {
        return confirmError;
    }

    /**
     * @param confirmError the confirmError to set
     */
    public void setConfirmError(String confirmError) {
        this.confirmError = confirmError;
    }

    /**
     * @return the userIDDuplicateError
     */
    public String getUserIDDuplicateError() {
        return userIDDuplicateError;
    }

    /**
     * @param userIDDuplicateError the userIDDuplicateError to set
     */
    public void setUserIDDuplicateError(String userIDDuplicateError) {
        this.userIDDuplicateError = userIDDuplicateError;
    }

}
