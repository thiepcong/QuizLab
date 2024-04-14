package com.example.backend.response;

import com.example.backend.entity.User;

public class LoginResponse {
    private String message;
    private Boolean status;
    private User user;

    public LoginResponse(String message, Boolean status, User user) {
        this.message = message;
        this.status = status;
        this.user = user;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "LoginResponse{" +
                "message='" + message + '\'' +
                ", status=" + status +
                ", user=" + user +
                '}';
    }
}
