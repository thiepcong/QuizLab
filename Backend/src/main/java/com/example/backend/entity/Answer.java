package com.example.backend.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "answer")
public class Answer {

    @Id
    @Column(name = "id", length = 10)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Column(name = "content", length = 255)
    private String content;

    @Column(name = "status")
    private boolean status;

    public Answer() {
    }

    public Answer(String content, boolean status) {
        this.content = content;
        this.status = status;
    }

    public Answer(int id, String content, boolean status) {
        this.id = id;
        this.content = content;
        this.status = status;
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Answer{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", status=" + status +
                '}';
    }
}