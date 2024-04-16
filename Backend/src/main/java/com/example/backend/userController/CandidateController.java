package com.example.backend.userController;

import com.example.backend.dto.CandidateDTO;
import com.example.backend.service.CandidateService;
import com.example.backend.service.TestService;
import com.example.backend.service.UserService;
import org.springframework.data.crossstore.ChangeSetPersister;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/api/candidates")
public class CandidateController {
    private final UserService userService;
    private final TestService testService;

    private final CandidateService candidateService;

    public CandidateController(UserService userService, TestService testService, CandidateService candidateService) {
        this.userService = userService;
        this.testService = testService;
        this.candidateService = candidateService;
    }

    @PostMapping
    public ResponseEntity<CandidateDTO> createCandidate(@RequestHeader("userId") int userId,
                                                        @RequestBody CandidateDTO candidateDTO) {
        CandidateDTO createdCandidate = candidateService.createCandidate(candidateDTO);
        return new ResponseEntity<>(createdCandidate, HttpStatus.CREATED);
    }

    @GetMapping("/{candidateId}")
    public ResponseEntity<CandidateDTO> getCandidateById(@PathVariable int candidateId,
                                                         @RequestHeader("userId") int userId) throws ChangeSetPersister.NotFoundException {
        CandidateDTO candidate = candidateService.getCandidateById(candidateId);
        if(testService.getTestById(candidate.getTestId()).getQuiz().getId() != userId) return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        return new ResponseEntity<>(candidate, HttpStatus.OK);
    }

    @GetMapping
    public ResponseEntity<List<CandidateDTO>> getAllCandidates(@RequestHeader("userId") int userId) {
        String userRole = userService.findById(userId).get().getRole();

        if (!"admin".equals(userRole)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }
        List<CandidateDTO> candidates = candidateService.getAllCandidates();
        return new ResponseEntity<>(candidates, HttpStatus.OK);
    }

    @GetMapping("/test/{testId}")
    public ResponseEntity<List<CandidateDTO>> getCandidatesByTestId(@PathVariable int testId,
                                                                    @RequestHeader("userId") int userId)
            throws ChangeSetPersister.NotFoundException {
        if(userId != testService.getTestById(testId).getQuiz().getUserId())
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        List<CandidateDTO> candidates = candidateService.getCandidatesByTestId(testId);
        return new ResponseEntity<>(candidates, HttpStatus.OK);
    }

    @PutMapping("/{candidateId}")
    public ResponseEntity<Void> updateCandidate(@PathVariable int candidateId,
                                                @RequestBody CandidateDTO candidateDTO,
                                                @RequestHeader("userId") int userId) throws ChangeSetPersister.NotFoundException {
        if(userId != testService.getTestById(candidateService.getCandidateById(candidateId).getTestId()).getQuiz().getUserId())
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        if(candidateService.getCandidateById(candidateId) == null)
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        candidateService.updateCandidate(candidateId, candidateDTO);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }

    @DeleteMapping("/{candidateId}")
    public ResponseEntity<Void> deleteCandidate(@PathVariable int candidateId,
                                                @RequestHeader("userId") int userId) throws ChangeSetPersister.NotFoundException {
        if(userId != testService.getTestById(candidateService.getCandidateById(candidateId).getTestId()).getQuiz().getUserId())
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        if(candidateService.getCandidateById(candidateId) == null)
            return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
        candidateService.deleteCandidate(candidateId);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }
}
