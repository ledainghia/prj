/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.users;

/**
 *
 * @author Acer
 */
public class UserDTO {
    private String userID;
    private String fullName;
    private String mail;
    private String roleID;
    private String password;
    private String imageURL;
    public UserDTO() {
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public UserDTO(String userID, String fullName, String mail, String roleID, String password) {
        this.userID = userID;
        this.fullName = fullName;
        this.mail = mail;
        this.roleID = roleID;
        this.password = password;
    }

    public UserDTO(String userID, String fullName, String mail, String roleID, String password, String imageURL) {
        this.userID = userID;
        this.fullName = fullName;
        this.mail = mail;
        this.roleID = roleID;
        this.password = password;
        this.imageURL = imageURL;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    

    

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "UserDTO{" + "userID=" + userID + ", fullName=" + fullName + ", mail=" + mail + ", roleID=" + roleID + ", password=" + password + '}';
    }
    
}
