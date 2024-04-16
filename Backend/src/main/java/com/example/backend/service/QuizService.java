package com.example.backend.service;

import com.example.backend.dto.QuizDTO;

import java.util.List;

public interface QuizService {
    QuizDTO createQuiz(QuizDTO quizDTO);
    QuizDTO getQuizById(int quizId);
    List<QuizDTO> getAllQuizzes();
    List<QuizDTO> getAllQuizzesByUserId(int userId);
    QuizDTO updateQuiz(int quizId, QuizDTO quizDTO);
    int deleteQuiz(int quizId);
    QuizDTO createQuizFromExcel(QuizDTO quizDTO, String filePath);
}
