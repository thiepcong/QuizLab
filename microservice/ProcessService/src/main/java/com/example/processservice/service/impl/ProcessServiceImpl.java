package com.example.processservice.service.impl;

import com.example.processservice.controller.WebSocketServer;
import com.example.processservice.dto.*;
import com.example.processservice.response.LoginResponse;
import com.example.processservice.response.RegisterResponse;
import com.example.processservice.service.ProcessService;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Service
public class ProcessServiceImpl implements ProcessService {
    private final RestTemplate restTemplate;

    private final WebSocketServer webSocketServer;



    public ProcessServiceImpl(RestTemplate restTemplate) {
        this.restTemplate = restTemplate;

        this.webSocketServer = new WebSocketServer();
    }

    @Override
    public TestDTO createTestFromExcel(int userId, String quizFilePath, String testFilePath, CreateTestDTO createTestDTO) {
        HttpHeaders quizHeaders = new HttpHeaders();
        quizHeaders.set("userId", String.valueOf(userId));
        quizHeaders.set("filePath", quizFilePath);
        QuizDTO quizDTO = new QuizDTO();
        quizDTO.setSubject(createTestDTO.getSubject());
        quizDTO.setTitle(createTestDTO.getQuizTitle());
        quizDTO.setTime(createTestDTO.getTime());

        HttpEntity<QuizDTO> quizRequestEntity = new HttpEntity<>(quizDTO, quizHeaders);
        ResponseEntity<QuizDTO> quizResponseEntity;

        webSocketServer.sendMessageToAllSessions("ProcessService call QuizService to create quiz from excel " + getCurrentTimeFormatted());
        try {
            quizResponseEntity = restTemplate.exchange(
                    "http://localhost:8083/api/quizzes/create-from-excel",
                    HttpMethod.POST,
                    quizRequestEntity,
                    QuizDTO.class
            );
        } catch (Exception e) {
            e.printStackTrace();
            webSocketServer.sendMessageToAllSessions("Failed to create quiz from Excel");
            throw new RuntimeException("Failed to create quiz from Excel");

        }

        if (quizResponseEntity.getStatusCode() != HttpStatus.OK) {
            webSocketServer.sendMessageToAllSessions("Failed to create quiz from Excel");
            throw new RuntimeException("Failed to create quiz from Excel");
        }

        webSocketServer.sendMessageToAllSessions("End create quiz from excel " + getCurrentTimeFormatted());

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
        testHeaders.set("filePath", testFilePath);

        HttpEntity<TestDTO> testRequestEntity = new HttpEntity<>(testDTO, testHeaders);
        ResponseEntity<TestDTO> testResponseEntity;

        webSocketServer.sendMessageToAllSessions("ProcessService call TestService to create test from excel " + getCurrentTimeFormatted());

        try {
            testResponseEntity = restTemplate.exchange(
                    "http://localhost:8084/api/tests/create-from-excel",
                    HttpMethod.POST,
                    testRequestEntity,
                    TestDTO.class
            );
        } catch (Exception e) {
            e.printStackTrace();
            webSocketServer.sendMessageToAllSessions("Failed to create test from Excel");
            throw new RuntimeException("Failed to create test from Excel");
        }

        if (testResponseEntity.getStatusCode() != HttpStatus.OK) {
            webSocketServer.sendMessageToAllSessions("Failed to create test from Excel");
            throw new RuntimeException("Failed to create test from Excel");
        }

        return testResponseEntity.getBody();
    }

    @Override
    public TestDTO createTest(int userId, TestDTO testDTO) {

        HttpHeaders quizHeaders = new HttpHeaders();
        quizHeaders.set("userId", String.valueOf(userId));
        QuizDTO quizDTO = testDTO.getQuiz();
        System.out.println(quizDTO.getSubject());
        System.out.println(quizDTO.getQuestions().size());
        System.out.println(quizDTO.getQuestions().get(0).getContent());

        HttpEntity<QuizDTO> quizRequestEntity = new HttpEntity<>(quizDTO, quizHeaders);
        ResponseEntity<QuizDTO> quizResponseEntity;
        webSocketServer.sendMessageToAllSessions("ProcessService call QuizService to add quiz " + getCurrentTimeFormatted());
        try {
            quizResponseEntity = restTemplate.exchange(
                    "http://localhost:8083/api/quizzes/add",
                    HttpMethod.POST,
                    quizRequestEntity,
                    QuizDTO.class
            );
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to create quiz");
        }

        if (quizResponseEntity.getStatusCode() != HttpStatus.CREATED) {
            throw new RuntimeException("Failed to create quiz");
        }

        QuizDTO createdQuiz = quizResponseEntity.getBody();
        int quizId = createdQuiz.getId();

        HttpHeaders testHeaders = new HttpHeaders();
        testHeaders.set("userId", String.valueOf(userId));
        testHeaders.set("quizId", String.valueOf(quizId));
        testHeaders.set("timeStart", convertDate(testDTO.getTimeStart()));
        testHeaders.set("timeEnd", convertDate(testDTO.getTimeEnd()));
        HttpEntity<TestDTO> testRequestEntity = new HttpEntity<>(testDTO, testHeaders);
        ResponseEntity<TestDTO> testResponseEntity;
        webSocketServer.sendMessageToAllSessions("ProcessService call TestService to create test " + getCurrentTimeFormatted());
        try {
            testResponseEntity = restTemplate.exchange(
                    "http://localhost:8084/api/tests",
                    HttpMethod.POST,
                    testRequestEntity,
                    TestDTO.class
            );
        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Failed to create test");
        }

        if (testResponseEntity.getStatusCode() != HttpStatus.CREATED) {
            throw new RuntimeException("Failed to create test");
        }

        return testResponseEntity.getBody();

    }

    public RegisterResponse addUser(UserDTO userDTO) {
        String url = "http://localhost:8081/api/user/save";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<UserDTO> requestEntity = new HttpEntity<>(userDTO, headers);
        webSocketServer.sendMessageToAllSessions("ProcessService call UserService to register user " + getCurrentTimeFormatted());
        ResponseEntity<RegisterResponse> responseEntity = restTemplate.postForEntity(url, requestEntity, RegisterResponse.class);

        return responseEntity.getBody();
    }

    public LoginResponse loginUser(LoginDTO loginDTO) {
        String url = "http://localhost:8081/api/user/login";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<LoginDTO> requestEntity = new HttpEntity<>(loginDTO, headers);
        webSocketServer.sendMessageToAllSessions("ProcessService call UserService to login " + getCurrentTimeFormatted());
        ResponseEntity<LoginResponse> responseEntity = restTemplate.postForEntity(url, requestEntity, LoginResponse.class);

        return responseEntity.getBody();
    }

    public ResponseEntity<QuizDTO> updateQuiz(int quizId, int userId, QuizDTO quizDTO) {
        String url = "http://localhost:8083/api/quizzes/" + quizId;
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("userId", String.valueOf(userId));

        HttpEntity<QuizDTO> requestEntity = new HttpEntity<>(quizDTO, headers);
        webSocketServer.sendMessageToAllSessions("ProcessService call QuizService to update quiz " + getCurrentTimeFormatted());
        ResponseEntity<QuizDTO> responseEntity = restTemplate.exchange(url, HttpMethod.PUT, requestEntity, QuizDTO.class);

        return responseEntity;
    }

    public ResponseEntity<List<QuizDTO>> getAllQuizzesByUserId(int userId) {
        String url = "http://localhost:8083/api/quizzes/users";
        HttpHeaders headers = new HttpHeaders();
        headers.set("userId", String.valueOf(userId));

        HttpEntity<Void> requestEntity = new HttpEntity<>(headers);
        webSocketServer.sendMessageToAllSessions("ProcessService call QuizService to get all quiz by userId " + getCurrentTimeFormatted());
        ResponseEntity<List<QuizDTO>> responseEntity = restTemplate.exchange(url, HttpMethod.GET, requestEntity, new ParameterizedTypeReference<List<QuizDTO>>() {});

        return responseEntity;
    }

    public ResponseEntity<Void> deleteQuiz(int quizId, int userId) {
        String url = "http://localhost:8083/api/quizzes/" + quizId;
        HttpHeaders headers = new HttpHeaders();
        headers.set("userId", String.valueOf(userId));

        HttpEntity<Void> requestEntity = new HttpEntity<>(headers);
        webSocketServer.sendMessageToAllSessions("ProcessService call QuizService to delete quiz " + getCurrentTimeFormatted());
        restTemplate.exchange(url, HttpMethod.DELETE, requestEntity, Void.class);

        return ResponseEntity.noContent().build();
    }

    public ResponseEntity<TestDTO> getTestByQuizCode(String quizCode, int userId) {
        String url = "http://localhost:8084/api/tests/code/" + quizCode;
        HttpHeaders headers = new HttpHeaders();
        headers.set("userId", String.valueOf(userId));

        HttpEntity<Void> requestEntity = new HttpEntity<>(headers);
        webSocketServer.sendMessageToAllSessions("ProcessService call TestService to get test by quizcode " + getCurrentTimeFormatted());
        ResponseEntity<TestDTO> responseEntity = restTemplate.exchange(url, HttpMethod.GET, requestEntity, TestDTO.class);

        if (responseEntity.getStatusCode().is2xxSuccessful()) {
            return ResponseEntity.ok(responseEntity.getBody());
        } else {
            return ResponseEntity.status(responseEntity.getStatusCode()).build();
        }
    }

    public ResponseEntity<CandidateDTO> createCandidate(CandidateDTO candidateDTO) {
        String url = "http://localhost:9000/candidates";
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<CandidateDTO> requestEntity = new HttpEntity<>(candidateDTO, headers);
        webSocketServer.sendMessageToAllSessions("ProcessService call ResultService to create candidate " + LocalDateTime.now());
        ResponseEntity<CandidateDTO> responseEntity = restTemplate.postForEntity(url, requestEntity, CandidateDTO.class);

        return ResponseEntity.ok(responseEntity.getBody());
    }

    public ResponseEntity<List<ResultDTO>> getAllResultsByCandidateId(int candidateId) {
        String url = "http://localhost:9000/api/results/candidate/" + candidateId;
        webSocketServer.sendMessageToAllSessions("ProcessService call ResultService to get all result by candidate id " + getCurrentTimeFormatted());
        ResponseEntity<List<ResultDTO>> responseEntity = restTemplate.exchange(url, HttpMethod.GET, null, new ParameterizedTypeReference<List<ResultDTO>>() {});

        return ResponseEntity.ok(responseEntity.getBody());
    }

    public static String convertDate(Date inputDate) {
        SimpleDateFormat outputFormat = new SimpleDateFormat("HH:mm dd-MM-yyyy");


        try {
            String outputDate = outputFormat.format(inputDate);
            return outputDate;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static String getCurrentTimeFormatted() {
        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");
        String formattedTime = formatter.format(currentTime);
        return formattedTime;
    }


}
