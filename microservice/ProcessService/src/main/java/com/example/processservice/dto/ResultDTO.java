package com.example.processservice.dto;

import java.util.List;

public class ResultDTO {
    private int id;
    private boolean correct;
    private int candidateId;
    private int questionId;
    private List<String> chosenAnswers;

    // Getters and setters

    public ResultDTO() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }


    public boolean isCorrect() {
        return this.correct;
    }

    public void setCorrect(boolean correct) {
        this.correct = correct;
    }

    public int getCandidateId() {
        return candidateId;
    }

    public void setCandidateId(int candidateId) {
        this.candidateId = candidateId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public List<String> getChosenAnswers() {
        return chosenAnswers;
    }

    public void setChosenAnswers(List<String> chosenAnswers) {
        this.chosenAnswers = chosenAnswers;
    }
}