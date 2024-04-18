package com.example.questionservice.entity;

import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "question")
public class Question {

    @Id
    @Column(name = "id", length = 10)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "content", length = 255)
    private String content;


    @Column(name = "user_id", length = 10)
    private int userId;
    @Column(name = "quiz_id", length = 10)
    private int quizId;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "question_id")
    private List<Answer> answers;

    public Question() {
    }

    public Question(String content, int userId, int quizId, List<Answer> answers) {
        this.content = content;
        this.userId = userId;
        this.quizId = quizId;
        this.answers = answers;
    }

    public Question(int id, String content, int userId, int quizId, List<Answer> answers) {
        this.id = id;
        this.content = content;
        this.userId = userId;
        this.quizId = quizId;
        this.answers = answers;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public List<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }

    @Override
    public String toString() {
        return "Question{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", userId=" + userId +
                ", quizId=" + quizId +
                ", answers=" + answers +
                '}';
    }
}