package com.example.backend.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "candidate")
public class Candidate {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    // Other attributes
    private String name;
    private int score;
    @OneToMany(mappedBy = "candidate", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Result> results;
    @ManyToOne(fetch= FetchType.LAZY)
    @JoinColumn(name = "test_id")
    private Test test;


    // Constructors, getters, and setters
    // ...

    public Candidate() {
    }

    public Candidate(int id, String name, int score, List<Result> results, Test test) {
        this.id = id;
        this.name = name;
        this.score = score;
        this.results = results;
        this.test = test;
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

    public List<Result> getResults() {
        return results;
    }

    public void setResults(List<Result> results) {
        this.results = results;
    }

    public Test getTest() {
        return test;
    }

    public void setTest(Test test) {
        this.test = test;
    }
}