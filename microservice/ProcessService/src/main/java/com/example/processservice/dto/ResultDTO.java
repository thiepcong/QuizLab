package com.example.processservice.dto;

import java.util.List;

public class ResultDTO {
    private int id;
    private boolean selected;
    private CandidateDTO candidate;
    private QuestionDTO question;
    private List<String> chosenAnswers;

    // Constructors, getters, and setters
    // ...

    public ResultDTO() {
    }

    public ResultDTO(int id, boolean selected, CandidateDTO candidate, QuestionDTO question, List<String> chosenAnswers) {
        this.id = id;
        this.selected = selected;
        this.candidate = candidate;
        this.question = question;
        this.chosenAnswers = chosenAnswers;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isSelected() {
        return selected;
    }

    public void setSelected(boolean selected) {
        this.selected = selected;
    }

    public CandidateDTO getCandidate() {
        return candidate;
    }

    public void setCandidate(CandidateDTO candidate) {
        this.candidate = candidate;
    }

    public QuestionDTO getQuestion() {
        return question;
    }

    public void setQuestion(QuestionDTO question) {
        this.question = question;
    }

    public List<String> getChosenAnswers() {
        return chosenAnswers;
    }

    public void setChosenAnswers(List<String> chosenAnswers) {
        this.chosenAnswers = chosenAnswers;
    }
}
