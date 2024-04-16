package com.example.backend.dto;

import java.sql.Date;
import java.util.List;

public class TestDTO {
    private int id;
    private String title;
    private Date timeCreated;
    private String quizCode;
    private String note;
    private QuizDTO quiz;
    private List<CandidateDTO> candidates;

    // Constructors, getters, and setters
    // ...

    public TestDTO() {
    }

    public TestDTO(int id, String title, Date timeCreated, String quizCode, String note, QuizDTO quiz, List<CandidateDTO> candidates) {
        this.id = id;
        this.title = title;
        this.timeCreated = timeCreated;
        this.quizCode = quizCode;
        this.note = note;
        this.quiz = quiz;
        this.candidates = candidates;
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

    public Date getTimeCreated() {
        return timeCreated;
    }

    public void setTimeCreated(Date timeCreated) {
        this.timeCreated = timeCreated;
    }

    public String getQuizCode() {
        return quizCode;
    }

    public void setQuizCode(String quizCode) {
        this.quizCode = quizCode;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public QuizDTO getQuiz() {
        return quiz;
    }

    public void setQuiz(QuizDTO quiz) {
        this.quiz = quiz;
    }

    public List<CandidateDTO> getCandidates() {
        return candidates;
    }

    public void setCandidates(List<CandidateDTO> candidates) {
        this.candidates = candidates;
    }
}
