package com.example.testservice.entity;

import jakarta.persistence.*;

import java.sql.Date;
import java.sql.Timestamp;


@Entity
@Table(name = "test")
public class Test {
    @Id
    @Column(name = "id", length = 10)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    // Other attributes
    @Column(name = "title", length = 255)
    private String title;
    @Column(name = "time_created")
    private Timestamp timeCreated;

    @Column(name = "quiz_code", length = 255)
    private String quizCode;
    @Column(name = "note", length = 255)
    private String note;
    @Column(name = "time_start")
    private Timestamp timeStart;

    @Column(name = "time_end")
    private Timestamp timeEnd;

    @Column(name = "quiz_id", length = 10)
    private int quizId;


    // Constructors, getters, and setters
    // ...


    public Test() {
    }

    public Test(int id, String title, Timestamp timeCreated, String quizCode, String note,
                Timestamp timeStart, Timestamp timeEnd, int quizId) {
        this.id = id;
        this.title = title;
        this.timeCreated = timeCreated;
        this.quizCode = quizCode;
        this.note = note;
        this.timeStart = timeStart;
        this.timeEnd = timeEnd;
        this.quizId = quizId;
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

    public Timestamp getTimeCreated() {
        return timeCreated;
    }

    public void setTimeCreated(Timestamp timeCreated) {
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

    public Timestamp getTimeStart() {
        return timeStart;
    }

    public void setTimeStart(Timestamp timeStart) {
        this.timeStart = timeStart;
    }

    public Timestamp getTimeEnd() {
        return timeEnd;
    }

    public void setTimeEnd(Timestamp timeEnd) {
        this.timeEnd = timeEnd;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }
}



