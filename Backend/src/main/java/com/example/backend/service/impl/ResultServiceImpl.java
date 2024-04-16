package com.example.backend.service.impl;

import com.example.backend.dto.ResultDTO;
import com.example.backend.entity.Candidate;
import com.example.backend.entity.Question;
import com.example.backend.entity.Result;
import com.example.backend.repo.ResultRepo;
import com.example.backend.service.ResultService;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ResultServiceImpl implements ResultService {
    private final ResultRepo resultRepo;
    private final ModelMapper modelMapper;

    public ResultServiceImpl(ResultRepo resultRepo, ModelMapper modelMapper) {
        this.resultRepo = resultRepo;
        this.modelMapper = modelMapper;
    }

    @Override
    public ResultDTO createResult(ResultDTO resultDTO) {
        Result result = modelMapper.map(resultDTO, Result.class);
        Result savedResult = resultRepo.save(result);
        return modelMapper.map(savedResult, ResultDTO.class);
    }

    @Override
    public ResultDTO getResultById(int resultId) {
        Optional<Result> result = resultRepo.findById(resultId);
        return modelMapper.map(result, ResultDTO.class);
    }

    @Override
    public List<String> getChosenAnswersByResultId(int resultId) {
        return resultRepo.findChosenAnswersByResultId(resultId);
    }

    @Override
    public List<ResultDTO> getAllResultsByCandidateId(int candidateId) {
        List<Result> results = resultRepo.findAllByCandidateId(candidateId);
        return results.stream()
                .map(result -> modelMapper.map(result, ResultDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public ResultDTO updateResult(int resultId, ResultDTO resultDTO) {
        Optional<Result> result = resultRepo.findById(resultId);

        // Update the result entity with the new values from resultDTO
        result.get().setSelected(resultDTO.isSelected());
        result.get().setCandidate(modelMapper.map(resultDTO.getCandidate(), Candidate.class));
        result.get().setQuestion(modelMapper.map(resultDTO.getQuestion(), Question.class));
        result.get().setChosenAnswers(resultDTO.getChosenAnswers());

        Result updatedResult = resultRepo.save(result.get());
        return modelMapper.map(updatedResult, ResultDTO.class);
    }

    @Override
    public void deleteResult(int resultId) {
        if (!resultRepo.existsById(resultId)) {
            return;
        }
        resultRepo.deleteById(resultId);
    }

    // Implement other methods as needed
}