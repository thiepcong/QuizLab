package com.example.backend.entity;

import jakarta.persistence.*;

import java.sql.Date;
import java.util.List;

@Entity
@Table(name = "test")
public class Test {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    // Other attributes
    private String title;
    private Date timeCreaed;
    private String quizCode;
    private String note;

    @ManyToOne(fetch= FetchType.LAZY)
    @JoinColumn(name = "quiz_id")
    private Quiz quiz;

    @OneToMany(mappedBy = "test", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Candidate> candidates;


    // Constructors, getters, and setters
    // ...

    public Test() {
    }

    public Test(int id, String title, Date timeCreaed, String quizCode, String note, Quiz quiz, List<Candidate> candidates) {
        this.id = id;
        this.title = title;
        this.timeCreaed = timeCreaed;
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

    public Date getTimeCreaed() {
        return timeCreaed;
    }

    public void setTimeCreaed(Date timeCreaed) {
        this.timeCreaed = timeCreaed;
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

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public List<Candidate> getCandidates() {
        return candidates;
    }

    public void setCandidates(List<Candidate> candidates) {
        this.candidates = candidates;
    }
}