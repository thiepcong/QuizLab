package com.example.processservice.service;

import com.example.processservice.dto.CreateTestDTO;
import com.example.processservice.dto.QuizDTO;
import com.example.processservice.dto.TestDTO;

public interface ProcessService {
    TestDTO createTest(int userId, String quizFilePath, String testFilePath, CreateTestDTO createTestDTO);

    TestDTO getTest(TestDTO testDTO);

    TestDTO getResult(TestDTO testDTO);
}
