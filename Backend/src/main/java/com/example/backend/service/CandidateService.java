package com.example.backend.service;

import com.example.backend.dto.CandidateDTO;

import java.util.List;

public interface CandidateService {
    CandidateDTO createCandidate(CandidateDTO candidateDTO);
    CandidateDTO getCandidateById(int candidateId);
    List<CandidateDTO> getAllCandidates();
    List<CandidateDTO> getCandidatesByTestId(int testId);
    void updateCandidate(int candidateId, CandidateDTO candidateDTO);
    void deleteCandidate(int candidateId);
}
