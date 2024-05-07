package com.example.processservice.service;

import com.example.processservice.dto.*;
import com.example.processservice.response.LoginResponse;
import com.example.processservice.response.RegisterResponse;
import org.springframework.http.ResponseEntity;

import java.util.List;

public interface ProcessService {
    TestDTO createTestFromExcel(int userId, String quizFilePath, String testFilePath, CreateTestDTO createTestDTO);

    TestDTO createTest(int userId, TestDTO testDTO);

    LoginResponse loginUser(LoginDTO loginDTO);

    ResponseEntity<List<QuizDTO>> getAllQuizzesByUserId(int userId);

    ResponseEntity<QuizDTO> updateQuiz(int quizId, int userId, QuizDTO quizDTO);

    RegisterResponse addUser(UserDTO userDTO);

    ResponseEntity<Void> deleteQuiz(int quizId, int userId);

    ResponseEntity<TestDTO> getTestByQuizCode(String quizCode, int userId);

    ResponseEntity<CandidateDTO> createCandidate(CandidateDTO candidateDTO);

    ResponseEntity<List<ResultDTO>> getAllResultsByCandidateId(int candidateId);
}
