package com.example.quizservice.entity;

import jakarta.persistence.*;


import java.sql.Timestamp;


@Entity
@Table(name = "quiz")
public class Quiz {
    @Id
    @Column(name = "id", length = 10)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    // Other attributes
    @Column(name = "title", length = 255)
    private String title;
    @Column(name = "subject", length = 255)
    private String subject;
    @Column(name = "time")
    private int time;

    @JoinColumn(name = "user_id")
    private int userId;


    // Constructors, getters, and setters
    // ...


    public Quiz() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public int getTime() {
        return time;
    }

    public void setTime(int time) {
        this.time = time;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    @Override
    public String toString() {
        return "Quiz{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", subject='" + subject + '\'' +
                ", time=" + time +
                ", userId=" + userId +
                '}';
    }
}