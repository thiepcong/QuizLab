package com.example.testservice.service.impl;


import com.example.testservice.dto.CandidateDTO;
import com.example.testservice.entity.Candidate;
import com.example.testservice.repo.CandidateRepo;
import com.example.testservice.service.CandidateService;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

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
        Candidate candidate = modelMapper.map(candidateDTO, Candidate.class);
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

    @Override
    public void updateCandidate(int candidateId, CandidateDTO candidateDTO) {
        Optional<Candidate> existingCandidate = candidateRepo.findById(candidateId);
        // Update the necessary fields of existingCandidate with candidateDTO
        existingCandidate.get().setName(candidateDTO.getName());
        existingCandidate.get().setScore(candidateDTO.getScore());
        // Update other fields as needed

        candidateRepo.save(existingCandidate.get());
    }

    @Override
    public void deleteCandidate(int candidateId) {
        candidateRepo.deleteById(candidateId);
    }
}