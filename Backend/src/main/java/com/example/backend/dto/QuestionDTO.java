package com.example.backend.dto;

import com.example.backend.entity.Answer;
import com.example.backend.entity.Question;
import com.example.backend.repo.UserRepo;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class QuestionDTO {
    private int questionId;
    private int userId;
    private String content;


    private List<Answer> answers;

    // Constructors, getters, and setters


    public QuestionDTO() {
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}