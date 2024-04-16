package com.example.backend.service;

import com.example.backend.dto.TestDTO;
import org.springframework.data.crossstore.ChangeSetPersister;

import java.util.List;

public interface TestService {
    TestDTO createTest(int quizId, TestDTO testDTO);
    TestDTO getTestById(int testId) throws ChangeSetPersister.NotFoundException;
    List<TestDTO> getAllTests();
    TestDTO updateTest(int testId, TestDTO testDTO);
    void deleteTest(int testId);
    List<TestDTO> getAllTestsByUserId(int userId);
    TestDTO createTestFromExcel(int quizId, TestDTO testDTO, String filePath);
    TestDTO getTestByQuizCode(String quizCode);
}