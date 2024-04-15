package com.example.backend.service;

import com.example.backend.dto.QuestionDTO;
import com.example.backend.entity.Question;

import java.util.List;
import java.util.Optional;

import com.example.backend.entity.Answer;

public interface QuestionService {
    List<Question> getAllQuestions();
    Question getQuestionById(int id);
    Question createQuestion(QuestionDTO questionDTO);
    Question updateQuestion(QuestionDTO questionDTO);
    void deleteQuestion(int id);
    Optional<Answer> getAnswerById(int id);
    Answer updateAnswer(Answer answer);
}