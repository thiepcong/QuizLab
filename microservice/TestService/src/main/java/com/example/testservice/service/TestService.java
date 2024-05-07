package com.example.testservice.service;


import com.example.testservice.dto.TestDTO;
import org.springframework.data.crossstore.ChangeSetPersister;

import javax.websocket.DeploymentException;
import java.text.ParseException;
import java.util.List;

public interface TestService {
    TestDTO createTest(int quizId, int userId, TestDTO testDTO, String timeStart, String timeEnd) throws ParseException, DeploymentException;
    TestDTO getTestById(int testId) throws ChangeSetPersister.NotFoundException;
    List<TestDTO> getAllTests();
    TestDTO updateTest(int testId, TestDTO testDTO);
    void deleteTest(int testId);
    /*List<TestDTO> getAllTestsByUserId(int userId);*/
    TestDTO createTestFromExcel(int quizId ,int userId, TestDTO testDTO, String filePath, String timeStart, String timeEnd) throws ParseException, DeploymentException;
    TestDTO getTestByQuizCode(String quizCode, int userId) throws DeploymentException;
}