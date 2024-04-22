package com.example.quizservice.dto;

public class AnswerDTO {

    private String content;
    private Boolean status;

    public AnswerDTO() {
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }
}
