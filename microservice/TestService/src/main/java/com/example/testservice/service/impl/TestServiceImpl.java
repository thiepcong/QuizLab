package com.example.testservice.service.impl;


import com.example.testservice.dto.QuizDTO;
import com.example.testservice.dto.TestDTO;
import com.example.testservice.entity.Test;
import com.example.testservice.repo.TestRepo;
import org.modelmapper.ModelMapper;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;


import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class TestServiceImpl implements TestService {
    private final TestRepo testRepository;

    private final RestTemplate restTemplate;
    private final ModelMapper modelMapper;

    public TestServiceImpl(TestRepo testRepository, RestTemplate restTemplate, ModelMapper modelMapper) {
        this.testRepository = testRepository;
        this.restTemplate = restTemplate;
        this.modelMapper = modelMapper;
    }

    @Override
    public TestDTO createTest(int quizId, int userId,  TestDTO testDTO) {

        HttpHeaders headers = new HttpHeaders();
        headers.set("userId", String.valueOf(userId));
        String url = "http://localhost:8083/api/quizzes/" + quizId;
        ResponseEntity<QuizDTO> responseEntity = restTemplate
                .exchange(url, HttpMethod.GET,new HttpEntity<>(headers), QuizDTO.class);


        QuizDTO quizDTO = responseEntity.getBody();

        testDTO.setQuiz(modelMapper.map(quizDTO, QuizDTO.class));
        Test test = modelMapper.map(testDTO, Test.class);
        Test createdTest = testRepository.save(test);
        return modelMapper.map(createdTest, TestDTO.class);
    }

    @Override
    public TestDTO createTestFromExcel(int quizId,int userId, TestDTO testDTO, String filePath) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("userId", String.valueOf(userId));
        String url = "http://localhost:8083/api/quizzes/" + quizId;
        ResponseEntity<QuizDTO> responseEntity = restTemplate
                .exchange(url, HttpMethod.GET,new HttpEntity<>(headers), QuizDTO.class);


        QuizDTO quizDTO = responseEntity.getBody();
        testDTO.setCandidates(testDTO.addCandidatsFromExcel(filePath));
        Test test = modelMapper.map(testDTO, Test.class);
        Test createdTest = testRepository.save(test);
        TestDTO createdTestDTO = modelMapper.map(createdTest, TestDTO.class);
        createdTestDTO.setQuiz(quizDTO);
        return createdTestDTO;
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

/*    @Override
    public List<TestDTO> getAllTestsByUserId(int userId) {
        List<Test> rest = new ArrayList<>();
        List<Test> testList = quizRepo.findAllByUserId(userId).stream().map(quiz -> {

            rest = Stream.of(testRepository.findByQuizId(quiz.getId()),).flatMap(Collection::stream).collect(Collectors.toList());
        });
        List<Test> tests = testRepository.find(userId);
        return tests.stream()
                .map(test -> modelMapper.map(test, TestDTO.class))
                .collect(Collectors.toList());
    }*/

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