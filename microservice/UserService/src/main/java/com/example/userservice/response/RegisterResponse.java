package com.example.userservice.response;


import com.example.userservice.entity.User;

public class RegisterResponse {
    private String message;
    private Boolean status;
    private User user;

    public RegisterResponse(String message, Boolean status, User user) {
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
        return "RegisterResponse{" +
                "message='" + message + '\'' +
                ", status=" + status +
                ", user=" + user +
                '}';
    }
}