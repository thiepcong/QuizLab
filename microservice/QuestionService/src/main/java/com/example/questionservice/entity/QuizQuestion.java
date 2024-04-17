package com.example.questionservice.entity;

import jakarta.persistence.*;


@Table(name = "quiz_question")
@Entity
public class QuizQuestion {

    @Id
    @Column(name = "id", length = 10)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "quiz_id", length = 10)
    private int quizId;

    @Column(name = "question_id", length = 10)
    private int questionId;
}
