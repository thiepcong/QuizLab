package com.example.questionservice.service;


import com.example.questionservice.dto.QuestionDTO;
import com.example.questionservice.entity.Answer;
import com.example.questionservice.entity.Question;

import java.util.List;
import java.util.Optional;

public interface QuestionService {
    List<Question> getAllQuestions();
    QuestionDTO getQuestionById(int id);
    QuestionDTO createQuestion(QuestionDTO questionDTO);
    QuestionDTO updateQuestion(QuestionDTO questionDTO);
    void deleteQuestion(int id);
    void deleteQuestionByQuizId(int quizId);
    Optional<Answer> getAnswerById(int id);
    Answer updateAnswer(Answer answer);
    List<QuestionDTO> getAllQuestionsByUserId(int userId);
    List<QuestionDTO> getAllQuestionsByQuizId(int quizId);
}