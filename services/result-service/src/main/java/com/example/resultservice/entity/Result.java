package com.example.resultservice.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "result")
public class Result {
    @Id
    @Column(name = "id", length = 10)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private boolean isCorrect;
    @ManyToOne(cascade = CascadeType.MERGE, fetch= FetchType.LAZY)
    @JoinColumn(name = "candidate_id")
    @JsonBackReference
    private Candidate candidate;

    @ManyToOne(cascade = CascadeType.MERGE, fetch= FetchType.LAZY)
    @JoinColumn(name = "question_id")
    @JsonManagedReference
    private Question question;

    @ElementCollection
    @CollectionTable(name = "chosen_answers", joinColumns = @JoinColumn(name = "result_id"))
    @Column(name = "chosen_answer")
    private List<String> chosenAnswers;


    public Result() {
    }

    public Result(int id, boolean isCorrect, Candidate candidate, Question question, List<String> chosenAnswers) {
        this.id = id;
        this.isCorrect = isCorrect;
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

    public boolean isCorrect() {
        return isCorrect;
    }

    public void setCorrect(boolean correct) {
        isCorrect = correct;
    }

    public Candidate getCandidate() {
        return candidate;
    }

    public void setCandidate(Candidate candidate) {
        this.candidate = candidate;
    }

    public Question getQuestion() {
        return question;
    }

    public List<String> getChosenAnswers() {
        return chosenAnswers;
    }

    public void setChosenAnswers(List<String> chosenAnswers) {
        this.chosenAnswers = chosenAnswers;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }
}

