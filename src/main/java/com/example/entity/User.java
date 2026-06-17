package com.example.entity;

public class User {
    private String id;        
    private String password;    
    private String fullname;     
    private boolean admin;       

    // Constructor
    public User() {
    }

    public User(String id, String password, String fullname, boolean admin) {
        this.id = id;
        this.password = password;
        this.fullname = fullname;
        this.admin = admin;
    }

    // Getters và Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public boolean isAdmin() {
        return admin;
    }

    public void setAdmin(boolean admin) {
        this.admin = admin;
    }

    @Override
    public String toString() {
        return "User{" +
                "id='" + id + '\'' +
                ", fullname='" + fullname + '\'' +
                ", admin=" + admin +
                '}';
    }
}