package com.example.backend.userController;

import com.example.backend.dto.ResultDTO;
import com.example.backend.service.ResultService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/results")
public class ResultController {
    private final ResultService resultService;

    public ResultController(ResultService resultService) {
        this.resultService = resultService;
    }

    @PostMapping
    public ResponseEntity<ResultDTO> createResult(@RequestBody ResultDTO resultDTO) {
        ResultDTO createdResult = resultService.createResult(resultDTO);
        return new ResponseEntity<>(createdResult, HttpStatus.CREATED);
    }

    @GetMapping("/{resultId}")
    public ResponseEntity<ResultDTO> getResultById(@PathVariable int resultId) {
        ResultDTO resultDTO = resultService.getResultById(resultId);
        return new ResponseEntity<>(resultDTO, HttpStatus.OK);
    }

    @GetMapping("/{resultId}/chosen-answers")
    public ResponseEntity<List<String>> getChosenAnswersByResultId(@PathVariable int resultId) {
        List<String> chosenAnswers = resultService.getChosenAnswersByResultId(resultId);
        return new ResponseEntity<>(chosenAnswers, HttpStatus.OK);
    }

    @GetMapping("/candidate/{candidateId}")
    public ResponseEntity<List<ResultDTO>> getAllResultsByCandidateId(@PathVariable int candidateId) {
        List<ResultDTO> results = resultService.getAllResultsByCandidateId(candidateId);
        return new ResponseEntity<>(results, HttpStatus.OK);
    }

    @PutMapping("/{resultId}")
    public ResponseEntity<ResultDTO> updateResult(@PathVariable int resultId, @RequestBody ResultDTO resultDTO) {
        ResultDTO updatedResult = resultService.updateResult(resultId, resultDTO);
        return new ResponseEntity<>(updatedResult, HttpStatus.OK);
    }

    @DeleteMapping("/{resultId}")
    public ResponseEntity<Void> deleteResult(@PathVariable int resultId) {
        resultService.deleteResult(resultId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
