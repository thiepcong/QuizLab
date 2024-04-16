package com.example.backend.service.impl;

import com.example.backend.dto.QuizDTO;
import com.example.backend.dto.TestDTO;
import com.example.backend.entity.Test;
import com.example.backend.repo.QuizRepo;
import com.example.backend.repo.TestRepo;
import com.example.backend.service.TestService;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class TestServiceImpl implements TestService {
    private final TestRepo testRepository;
    private final QuizRepo quizRepo;
    private final ModelMapper modelMapper;

    public TestServiceImpl(TestRepo testRepository, QuizRepo quizRepo, ModelMapper modelMapper) {
        this.testRepository = testRepository;
        this.quizRepo = quizRepo;
        this.modelMapper = modelMapper;
    }

    @Override
    public TestDTO createTest(int quizId, TestDTO testDTO) {
        testDTO.setQuiz(modelMapper.map(quizRepo.findById(quizId).get(), QuizDTO.class));
        Test test = modelMapper.map(testDTO, Test.class);
        Test createdTest = testRepository.save(test);
        return modelMapper.map(createdTest, TestDTO.class);
    }

    @Override
    public TestDTO createTestFromExcel(int quizId, TestDTO testDTO, String filePath) {
        testDTO.setQuiz(modelMapper.map(quizRepo.findById(quizId).get(), QuizDTO.class));
        testDTO.setCandidates(testDTO.addCandidatsFromExcel(filePath));
        Test test = modelMapper.map(testDTO, Test.class);
        Test createdTest = testRepository.save(test);
        return modelMapper.map(createdTest, TestDTO.class);
    }

    @Override
    public TestDTO getTestByQuizCode(String quizCode) {
        Test test = testRepository.findByQuizCode(quizCode);
        return modelMapper.map(test, TestDTO.class);
    }

    @Override
    public TestDTO getTestById(int testId){
        Optional<Test> test = testRepository.findById(testId);
        return modelMapper.map(test, TestDTO.class);
    }

    @Override
    public List<TestDTO> getAllTests() {
        List<Test> tests = testRepository.findAll();
        return tests.stream()
                .map(test -> modelMapper.map(test, TestDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<TestDTO> getAllTestsByUserId(int userId) {
        List<Test> tests = quizRepo.findAllById(Collections.singleton(userId))
                .stream()
                .flatMap(quiz -> quiz.getTests().stream())
                .collect(Collectors.toList());
        return tests.stream()
                .map(test -> modelMapper.map(test, TestDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public TestDTO updateTest(int testId, TestDTO testDTO) {
        Optional<Test> existingTest = testRepository.findById(testId);
        modelMapper.map(testDTO, existingTest);
        Test updatedTest = testRepository.save(existingTest.get());
        return modelMapper.map(updatedTest, TestDTO.class);
    }

    @Override
    public void deleteTest(int testId) {
        testRepository.deleteById(testId);
    }
}