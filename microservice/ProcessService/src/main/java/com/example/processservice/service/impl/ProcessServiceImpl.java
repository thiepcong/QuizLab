package com.example.processservice.service.impl;

import com.example.processservice.dto.CreateTestDTO;
import com.example.processservice.dto.QuizDTO;
import com.example.processservice.dto.TestDTO;
import com.example.processservice.service.ProcessService;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class ProcessServiceImpl implements ProcessService {
    private final RestTemplate restTemplate;

    public ProcessServiceImpl(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;
    }

    @Override
    public TestDTO createTest(int userId, String quizFilePath, String testFilePath, CreateTestDTO createTestDTO) {
        HttpHeaders quizHeaders = new HttpHeaders();
        quizHeaders.set("userId", String.valueOf(userId));
        quizHeaders.set("filePath", quizFilePath);
        QuizDTO quizDTO = new QuizDTO();
        quizDTO.setSubject(createTestDTO.getSubject());
        quizDTO.setTitle(createTestDTO.getQuizTitle());
        quizDTO.setTime(createTestDTO.getTime());

        HttpEntity<QuizDTO> quizRequestEntity = new HttpEntity<>(quizDTO, quizHeaders);
        ResponseEntity<QuizDTO> quizResponseEntity = restTemplate.exchange(
                "http://localhost:8083/api/quizzes/create-from-excel",
                HttpMethod.POST,
                quizRequestEntity,
                QuizDTO.class
        );
        if (quizResponseEntity.getStatusCode() != HttpStatus.OK) {
            throw new RuntimeException("Failed to create quiz from Excel");
        }

        QuizDTO createdQuiz = quizResponseEntity.getBody();
        int quizId = createdQuiz.getId();

        TestDTO testDTO = new TestDTO();
        testDTO.setTitle(createTestDTO.getTestTitle());
        testDTO.setNote(createTestDTO.getTestNote());
        HttpHeaders testHeaders = new HttpHeaders();
        testHeaders.set("userId", String.valueOf(userId));
        testHeaders.set("quizId", String.valueOf(quizId));
        testHeaders.set("timeStart", createTestDTO.getTimeStart());
        testHeaders.set("timeEnd", createTestDTO.getTimeEnd());

        HttpEntity<TestDTO> testRequestEntity = new HttpEntity<>(testDTO, testHeaders);
        ResponseEntity<TestDTO> testResponseEntity = restTemplate.exchange(
                "http://localhost:8084/api/tests/create-from-excel",
                HttpMethod.POST,
                testRequestEntity,
                TestDTO.class
        );
        if (testResponseEntity.getStatusCode() != HttpStatus.OK) {
            throw new RuntimeException("Failed to create test from Excel");
        }

        return testResponseEntity.getBody();
    }

    @Override
    public TestDTO getTest (TestDTO testDTO) {
        return null;
    }

    @Override
    public TestDTO getResult(TestDTO testDTO) {
        return null;
    }
}
