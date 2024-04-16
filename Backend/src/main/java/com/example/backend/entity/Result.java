package com.example.backend.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "result")
public class Result {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private boolean selected;
    @ManyToOne(cascade = CascadeType.MERGE, fetch= FetchType.LAZY)
    @JoinColumn(name = "candidate_id")
    private Candidate candidate;

    @ManyToOne(cascade = CascadeType.MERGE, fetch= FetchType.LAZY)
    @JoinColumn(name = "question_id")
    private Question question;

    @ElementCollection
    @CollectionTable(name = "chosen_answers", joinColumns = @JoinColumn(name = "result_id"))
    @Column(name = "chosen_answer")
    private List<String> chosenAnswers;


    public Result() {
    }

    public Result(int id, boolean selected, Candidate candidate, Question question, List<String> chosenAnswers) {
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

    public Candidate getCandidate() {
        return candidate;
    }

    public void setCandidate(Candidate candidate) {
        this.candidate = candidate;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public List<String> getChosenAnswers() {
        return chosenAnswers;
    }

    public void setChosenAnswers(List<String> chosenAnswers) {
        this.chosenAnswers = chosenAnswers;
    }

}

