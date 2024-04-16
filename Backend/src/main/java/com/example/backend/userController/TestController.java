package com.example.backend.userController;

import com.example.backend.dto.TestDTO;
import com.example.backend.service.TestService;
import org.springframework.data.crossstore.ChangeSetPersister;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/tests")
public class TestController {
    private final TestService testService;

    public TestController(TestService testService) {
        this.testService = testService;
    }

    @PostMapping
    public ResponseEntity<TestDTO> createTest(@RequestBody TestDTO testDTO) {
        TestDTO createdTestDTO = testService.createTest(testDTO);
        return new ResponseEntity<>(createdTestDTO, HttpStatus.CREATED);
    }

    @GetMapping("/{testId}")
    public ResponseEntity<TestDTO> getTestById(@PathVariable int testId) throws ChangeSetPersister.NotFoundException {
        TestDTO testDTO = testService.getTestById(testId);

        if (testDTO == null) {
            return ResponseEntity.notFound().build();
        }

        return ResponseEntity.ok(testDTO);
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