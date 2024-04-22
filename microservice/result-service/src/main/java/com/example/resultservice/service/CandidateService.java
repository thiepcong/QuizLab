package com.example.resultservice.service;



import com.example.resultservice.dto.CandidateDTO;

import java.util.List;

public interface CandidateService {
    CandidateDTO createCandidate(CandidateDTO candidateDTO);
    CandidateDTO getCandidateById(int candidateId);
    List<CandidateDTO> getAllCandidates();
    List<CandidateDTO> getCandidatesByTestId(int testId);
    CandidateDTO updateCandidate(int candidateId, CandidateDTO candidateDTO);
    void deleteCandidate(int candidateId);
}
