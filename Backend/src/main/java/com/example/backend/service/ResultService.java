package com.example.backend.service;

import com.example.backend.dto.ResultDTO;

import java.util.List;

public interface ResultService {
    ResultDTO createResult(ResultDTO resultDTO);
    ResultDTO getResultById(int resultId);
    List<String> getChosenAnswersByResultId(int resultId);
    List<ResultDTO> getAllResultsByCandidateId(int candidateId);
    ResultDTO updateResult(int resultId, ResultDTO resultDTO);
    void deleteResult(int resultId);
    // Add other methods as needed
}