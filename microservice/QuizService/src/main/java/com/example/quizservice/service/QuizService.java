package com.example.quizservice.service;

import com.example.quizservice.dto.QuizDTO;

import java.util.List;

public interface QuizService {
    QuizDTO createQuiz(QuizDTO quizDTO);
    QuizDTO getQuizById(int quizId);
    List<QuizDTO> getAllQuizzes();
    List<QuizDTO> getAllQuizzesByUserId(int userId);
    QuizDTO updateQuiz(QuizDTO quizDTO);
    int deleteQuiz(int quizId);
    QuizDTO createQuizFromExcel(QuizDTO quizDTO, String filePath);
}
