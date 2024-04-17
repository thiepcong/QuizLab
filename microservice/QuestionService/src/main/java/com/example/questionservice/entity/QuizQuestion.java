package com.example.questionservice.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Table;


@Table(name = "quiz_question")
public class QuizQuestion {

    @Column(name = "quiz_id", length = 10)
    private int quizId;

    @Column(name = "question_id", length = 10)
    private int questionId;
}
