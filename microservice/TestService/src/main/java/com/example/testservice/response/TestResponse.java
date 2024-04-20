package com.example.testservice.response;

import com.example.testservice.dto.CandidateDTO;
import com.example.testservice.dto.QuizDTO;

import java.sql.Timestamp;
import java.util.List;

public class TestResponse {
    private int id;
    private String title;
    private String timeCreated;

    private String timeStart;
    private String quizCode;
    private String note;
    private QuizDTO quiz;
    private List<CandidateDTO> candidates;

    public TestResponse() {
    }

    public TestResponse(int id, String title, String timeCreated, String timeStart, String quizCode, String note, QuizDTO quiz, List<CandidateDTO> candidates) {
        this.id = id;
        this.title = title;
        this.timeCreated = timeCreated;
        this.timeStart = timeStart;
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

    public String getTimeCreated() {
        return timeCreated;
    }

    public void setTimeCreated(String timeCreated) {
        this.timeCreated = timeCreated;
    }

    public String getTimeStart() {
        return timeStart;
    }

    public void setTimeStart(String timeStart) {
        this.timeStart = timeStart;
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
