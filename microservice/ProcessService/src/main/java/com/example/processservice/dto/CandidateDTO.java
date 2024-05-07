package com.example.processservice.dto;

import java.util.List;

public class CandidateDTO {
    private int id;
    private String name;
    private int score;
    private List<ResultDTO> results;

    private int testId;

    // Constructors, getters, and setters
    // ...

    public CandidateDTO() {
    }

    public CandidateDTO(int id, String name, int score, List<ResultDTO> results, int testId) {
        this.id = id;
        this.name = name;
        this.score = score;
        this.results = results;
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

    public List<ResultDTO> getResults() {
        return results;
    }

    public void setResults(List<ResultDTO> results) {
        this.results = results;
    }

    public int getTestId() {
        return this.testId;
    }

    public void setTestId(int test) {
        this.testId = testId;
    }
}