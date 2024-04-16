package com.example.backend.userController;

import com.example.backend.dto.QuizDTO;
import com.example.backend.dto.TestDTO;
import com.example.backend.service.TestService;
import org.springframework.data.crossstore.ChangeSetPersister;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/api/tests")
public class TestController {
    private final TestService testService;

    public TestController(TestService testService) {
        this.testService = testService;
    }

    @PostMapping
    public ResponseEntity<TestDTO> createTest(@RequestHeader int quizId, @RequestBody TestDTO testDTO) {
        TestDTO createdTestDTO = testService.createTest(quizId, testDTO);
        return new ResponseEntity<>(createdTestDTO, HttpStatus.CREATED);
    }

    @PostMapping("/create-from-excel")
    public ResponseEntity<TestDTO> createTestFromExcel(
            @RequestHeader("userId") int userId,
            @RequestHeader("filePath") String filePath,
            @RequestHeader int quizId,
            @RequestBody TestDTO testDTO) {

        try {
            TestDTO createdTest = testService.createTestFromExcel(quizId, testDTO, filePath);
            return ResponseEntity.ok(createdTest);
        } catch (Exception e) {
            System.out.println(e);
            // Handle any exceptions that occur during the creation of the quiz
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/{testId}")
    public ResponseEntity<TestDTO> getTestById(@PathVariable int testId) throws ChangeSetPersister.NotFoundException {
        TestDTO testDTO = testService.getTestById(testId);

        if (testDTO == null) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(testDTO);
    }
    @GetMapping("/code/{quizCode}")
    public ResponseEntity<TestDTO> getTestByQuizCode(@PathVariable String quizCode) {
        TestDTO testDTO = testService.getTestByQuizCode(quizCode);
        if (testDTO != null) {
            return ResponseEntity.ok(testDTO);
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        }
    }

    @GetMapping
    public ResponseEntity<List<TestDTO>> getAllTests() {
        List<TestDTO> tests = testService.getAllTests();
        return ResponseEntity.ok(tests);
    }

    @GetMapping("/users/{userId}")
    public ResponseEntity<List<TestDTO>> getAllTestsByUserId(@PathVariable int userId) {
        List<TestDTO> tests = testService.getAllTestsByUserId(userId);
        return ResponseEntity.ok(tests);
    }

    @PutMapping("/{testId}")
    public ResponseEntity<TestDTO> updateTest(@PathVariable int testId,
                                              @RequestBody TestDTO testDTO) {
        TestDTO updatedTestDTO = testService.updateTest(testId, testDTO);

        if (updatedTestDTO == null) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(updatedTestDTO);
    }

    @DeleteMapping("/{testId}")
    public ResponseEntity<Void> deleteTest(@PathVariable int testId) {
        testService.deleteTest(testId);
        return ResponseEntity.noContent().build();
    }
}