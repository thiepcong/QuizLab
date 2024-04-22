package com.example.resultservice.service.impl;

import com.example.resultservice.dto.CandidateDTO;
import com.example.resultservice.dto.ResultDTO;
import com.example.resultservice.entity.Answer;
import com.example.resultservice.entity.Result;
import com.example.resultservice.repo.CandidateRepo;
import com.example.resultservice.repo.QuestionRepo;
import com.example.resultservice.repo.ResultRepo;
import com.example.resultservice.service.ResultService;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ResultServiceImpl implements ResultService {
    private final ResultRepo resultRepo;
    private final CandidateRepo candidateRepo;
    private final QuestionRepo questionRepo;
    private final ModelMapper modelMapper;

    public ResultServiceImpl(ResultRepo resultRepo, CandidateRepo candidateRepo, QuestionRepo questionRepo, ModelMapper modelMapper) {
        this.resultRepo = resultRepo;
        this.candidateRepo = candidateRepo;
        this.questionRepo = questionRepo;
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
        result.get().setCorrect(resultDTO.isCorrect());
        result.get().setCandidate(candidateRepo.findById(resultDTO.getCandidateId()).get());
        result.get().setQuestion(questionRepo.findById(resultDTO.getQuestionId()).get());
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

    @Override
    public CandidateDTO getCandidateResult(int candidateId) {
        CandidateDTO candidateDTO = modelMapper.map(candidateRepo.findById(candidateId).get(), CandidateDTO.class);

        int totalCorrect = 0;
        for (ResultDTO resultDTO: candidateDTO.getResults()) {
            List<Answer> answersList = questionRepo.getById(resultDTO.getQuestionId()).getAnswers();
            List<String> chosenAnswers = resultDTO.getChosenAnswers();
            List<String> trueAnswers = new ArrayList<>();
            for(Answer answer: answersList){
                if(answer.isStatus())
                    trueAnswers.add(answer.getContent());
            }
            Collections.sort(chosenAnswers);
            Collections.sort(trueAnswers);
            if(chosenAnswers.equals(trueAnswers)) {
                resultDTO.setCorrect(true);
                totalCorrect += 1;
            }
            else resultDTO.setCorrect(false);
        }
        candidateDTO.setScore(totalCorrect);
        return candidateDTO;
    }

    // Implement other methods as needed
}