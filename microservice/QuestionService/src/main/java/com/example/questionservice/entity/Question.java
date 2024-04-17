package com.example.questionservice.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "question")
public class Question {

    @Id
    @Column(name = "id", length = 10)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "content", length = 255)
    private String content;


    @Column(name = "user_id")
    private int userId;

    public Question() {
    }

    public Question(String content, int userId) {
        this.content = content;
        this.userId = userId;
    }

    public Question(int id, String content, int userId) {
        this.id = id;
        this.content = content;
        this.userId = userId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "Question{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", userId=" + userId +
                '}';
    }
}