package com.example.processservice.controller;

import com.example.processservice.dto.*;
import com.example.processservice.response.LoginResponse;
import com.example.processservice.response.RegisterResponse;
import com.example.processservice.service.ProcessService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class ProcessController {

    private final ProcessService processService;

    public ProcessController(ProcessService processService) {
        this.processService = processService;
    }

    @PostMapping("/create-test-from-excel")
    public ResponseEntity<TestDTO> createTestFromExcel(
            @RequestHeader("userId") int userId,
            @RequestHeader("quizFilePath") String quizFilePath,
            @RequestHeader("testFilePath") String testFilePath,
            @RequestHeader String timeStart,
            @RequestHeader String timeEnd,
            @RequestBody CreateTestDTO createTestDTO) {

        try {
            createTestDTO.setTimeStart(timeStart);
            createTestDTO.setTimeEnd(timeEnd);
            TestDTO createdTest = processService.createTestFromExcel(userId, quizFilePath, testFilePath, createTestDTO);
            return ResponseEntity.ok(createdTest);
        } catch (Exception e) {
            System.out.println(e);
            // Handle any exceptions that occur during the creation of the test
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping("/create-test")
    public ResponseEntity<TestDTO> createTest(@RequestHeader("userId") int userId, @RequestBody TestDTO testDTO) {
        try {
            TestDTO createdTest = processService.createTest(userId, testDTO);
            return ResponseEntity.ok(createdTest);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping("/user/save")
    public ResponseEntity<RegisterResponse> addUser(@RequestBody UserDTO userDTO) {
        try {
            RegisterResponse response = processService.addUser(userDTO);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping("/user/login")
    public ResponseEntity<LoginResponse> loginUser(@RequestBody LoginDTO loginDTO) {
        try {
            LoginResponse response = processService.loginUser(loginDTO);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PutMapping("/quizzes/{quizId}")
    public ResponseEntity<QuizDTO> updateQuiz(
            @PathVariable int quizId,
            @RequestHeader("userId") int userId,
            @RequestBody QuizDTO quizDTO) {
        try {
            ResponseEntity<QuizDTO> responseEntity = processService.updateQuiz(quizId, userId, quizDTO);
            return ResponseEntity.ok(responseEntity.getBody());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/quizzes/users")
    public ResponseEntity<List<QuizDTO>> getAllQuizzesByUserId(@RequestHeader("userId") int userId) {
        try {
            ResponseEntity<List<QuizDTO>> responseEntity = processService.getAllQuizzesByUserId(userId);
            return ResponseEntity.ok(responseEntity.getBody());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @DeleteMapping("/quizzes/{quizId}")
    public ResponseEntity<Void> deleteQuiz(
            @PathVariable int quizId,
            @RequestHeader("userId") int userId) {
        try {
            ResponseEntity<Void> responseEntity = processService.deleteQuiz(quizId, userId);
            return ResponseEntity.noContent().build();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/tests/code/{quizCode}")
    public ResponseEntity<TestDTO> getTestByQuizCode(
            @PathVariable String quizCode,
            @RequestHeader("userId") int userId) {
        try {
            ResponseEntity<TestDTO> responseEntity = processService.getTestByQuizCode(quizCode, userId);
            if (responseEntity.getStatusCode().is2xxSuccessful()) {
                return ResponseEntity.ok(responseEntity.getBody());
            } else {
                return ResponseEntity.status(responseEntity.getStatusCode()).build();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @PostMapping("/candidates")
    public ResponseEntity<CandidateDTO> createCandidate(@RequestBody CandidateDTO candidateDTO) {
        try {
            ResponseEntity<CandidateDTO> responseEntity = processService.createCandidate(candidateDTO);
            return ResponseEntity.ok(responseEntity.getBody());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/results/candidate/{candidateId}")
    public ResponseEntity<List<ResultDTO>> getAllResultsByCandidateId(@PathVariable int candidateId) {
        try {
            ResponseEntity<List<ResultDTO>> responseEntity = processService.getAllResultsByCandidateId(candidateId);
            return ResponseEntity.ok(responseEntity.getBody());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // Other controller methods...
}
