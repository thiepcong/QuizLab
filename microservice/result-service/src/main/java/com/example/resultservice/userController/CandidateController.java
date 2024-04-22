package com.example.resultservice.userController;

import com.example.resultservice.dto.CandidateDTO;
import com.example.resultservice.entity.Candidate;
import com.example.resultservice.service.CandidateService;
import org.modelmapper.ModelMapper;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
@RequestMapping("/candidates")
public class CandidateController {

    private final CandidateService candidateService;
    private final ModelMapper modelMapper;

    public CandidateController(CandidateService candidateService, ModelMapper modelMapper) {
        this.candidateService = candidateService;
        this.modelMapper = modelMapper;
    }

    // ... other methods ...

    @PostMapping
    public ResponseEntity<CandidateDTO> createCandidate(@RequestBody CandidateDTO candidateDTO) {
        return ResponseEntity.ok(candidateService.createCandidate(candidateDTO));
    }
}
