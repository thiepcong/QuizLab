package com.example.resultservice.service.impl;


import com.example.resultservice.dto.CandidateDTO;
import com.example.resultservice.dto.ResultDTO;
import com.example.resultservice.entity.Candidate;
import com.example.resultservice.entity.Result;
import com.example.resultservice.repo.CandidateRepo;
import com.example.resultservice.service.CandidateService;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CandidateServiceImpl implements CandidateService {
    private final CandidateRepo candidateRepo;
    private final ModelMapper modelMapper;



    public CandidateServiceImpl(CandidateRepo candidateRepo, ModelMapper modelMapper) {
        this.candidateRepo = candidateRepo;
        this.modelMapper = modelMapper;
    }

    @Override
    public CandidateDTO createCandidate(CandidateDTO candidateDTO) {
        Candidate candidate = new Candidate();
        candidate.setName(candidateDTO.getName());
        candidate.setScore(candidateDTO.getScore());
        candidate.setTestId(candidateDTO.getTestId());

        List<Result> results = new ArrayList<>();
        for (ResultDTO resultDTO : candidateDTO.getResults()) {
            Result result = new Result();
            result.setQuestionId(resultDTO.getQuestionId());
            result.setChosenAnswers(resultDTO.getChosenAnswers());
            result.setCorrect(resultDTO.isCorrect());
            result.setCandidate(candidate);
            results.add(result);
        }

        candidate.setResults(results);
        Candidate savedCandidate = candidateRepo.save(candidate);

        return modelMapper.map(savedCandidate, CandidateDTO.class);
    }

    @Override
    public CandidateDTO getCandidateById(int candidateId) {
        Optional<Candidate> candidate = candidateRepo.findById(candidateId);
        return modelMapper.map(candidate, CandidateDTO.class);
    }

    @Override
    public List<CandidateDTO> getAllCandidates() {
        List<Candidate> candidates = candidateRepo.findAll();
        return candidates.stream()
                .map(candidate -> modelMapper.map(candidate, CandidateDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<CandidateDTO> getCandidatesByTestId(int testId) {
        List<Candidate> candidates = candidateRepo.findAllByTestId(testId);
        return candidates.stream()
                .map(candidate -> modelMapper.map(candidate, CandidateDTO.class))
                .collect(Collectors.toList());
    }

    // have bug
    @Override
    public CandidateDTO updateCandidate(int candidateId, CandidateDTO candidateDTO) {
        Optional<Candidate> existingCandidateOptional = candidateRepo.findById(candidateId);
        if (!existingCandidateOptional.isPresent()) {
            // Create a new candidate
            Candidate newCandidate = modelMapper.map(candidateDTO, Candidate.class);
            // newCandidate.setId(null); // Set the ID to null to generate a new ID when saving
            // Update other fields as needed
            candidateRepo.save(newCandidate);
            return modelMapper.map(newCandidate, CandidateDTO.class);
        }

        Candidate existingCandidate = existingCandidateOptional.get();
        // Update the necessary fields of existingCandidate with candidateDTO
        existingCandidate.setName(candidateDTO.getName());
        existingCandidate.setScore(candidateDTO.getScore());

        // Update the associated results
        List<Result> updatedResults = new ArrayList<>();
        for (ResultDTO resultDTO : candidateDTO.getResults()) {
            Result result;
            if (resultDTO.getId() != 0) {
                Optional<Result> existingResultOptional = existingCandidate.getResults().stream()
                        .filter(r -> r.getId() == resultDTO.getId())
                        .findFirst();
                if (existingResultOptional.isPresent()) {
                    result = existingResultOptional.get();
                } else {
                    // Handle result not found scenario
                    continue;
                }
            } else {
                result = new Result();
            }

            result.setCorrect(resultDTO.isCorrect());
            //result.setQuestion(resultDTO.getQuestionId());
            result.setChosenAnswers(resultDTO.getChosenAnswers());
            result.setCandidate(existingCandidate);

            updatedResults.add(result);
        }

        existingCandidate.setResults(updatedResults);
        // Update other fields as needed

        candidateRepo.save(existingCandidate);
        return modelMapper.map(existingCandidate, CandidateDTO.class);
    }

    @Override
    public void deleteCandidate(int candidateId) {
        candidateRepo.deleteById(candidateId);
    }
}