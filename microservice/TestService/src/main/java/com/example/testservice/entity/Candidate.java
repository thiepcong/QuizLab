package com.example.testservice.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "candidate")
public class Candidate {
    @Id
    @Column(name = "id", length = 10)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    // Other attributes
    @Column(name = "name", length = 255)
    private String name;
    @Column(name = "score", length = 10)
    private int score;

    @Column(name = "test_id", length = 10)
    private int testId;



    // Constructors, getters, and setters
    // ...


    public Candidate() {
}

    public Candidate(int id, String name, int score, int testId) {
        this.id = id;
        this.name = name;
        this.score = score;
        this.testId = testId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getTest() {
        return testId;
    }

    public void setTest(int testId) {
        this.testId = testId;
    }

    public int getTestId() {
        return testId;
    }

    public void setTestId(int testId) {
        this.testId = testId;
    }

    @Override
    public String toString() {
        return "Candidate{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", score=" + score +
                ", testId=" + testId +
                '}';
    }
}