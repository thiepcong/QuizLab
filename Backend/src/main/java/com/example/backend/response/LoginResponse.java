package com.example.backend.response;

import com.example.backend.entity.User;

public class LoginResponse {
    private String message;
    private Boolean status;
    private int userId;

    public LoginResponse(String message, Boolean status, int userId) {
        this.message = message;
        this.status = status;
        this.userId = userId;
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

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "LoginResponse{" +
                "message='" + message + '\'' +
                ", status=" + status +
                ", userId=" + userId +
                '}';
    }
}
