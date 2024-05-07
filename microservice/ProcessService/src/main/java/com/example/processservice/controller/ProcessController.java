package com.example.processservice.controller;

import com.example.processservice.dto.CreateTestDTO;
import com.example.processservice.dto.QuizDTO;
import com.example.processservice.dto.TestDTO;
import com.example.processservice.service.ProcessService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/process")
public class ProcessController {

    private ProcessService processService;

    public ProcessController(ProcessService processService) {
        this.processService = processService;
    }

    @PostMapping("/createTest")
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
            TestDTO createdTest = processService.createTest(userId, quizFilePath, testFilePath, createTestDTO);
            return ResponseEntity.ok(createdTest);
        } catch (Exception e) {
            System.out.println(e);
            // Handle any exceptions that occur during the creation of the test
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    // Other controller methods...
}
