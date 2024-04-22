package com.example.testservice.service.impl;


import com.example.testservice.dto.CandidateDTO;
import com.example.testservice.dto.QuizDTO;
import com.example.testservice.dto.TestDTO;
import com.example.testservice.entity.Candidate;
import com.example.testservice.entity.Test;
import com.example.testservice.repo.CandidateRepo;
import com.example.testservice.repo.TestRepo;
import com.example.testservice.service.TestService;
import org.modelmapper.ModelMapper;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;


import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class TestServiceImpl implements TestService {
    private final TestRepo testRepository;

    private final CandidateRepo candidateRepo;

    private final RestTemplate restTemplate;
    private final ModelMapper modelMapper;

    public TestServiceImpl(TestRepo testRepository, CandidateRepo candidateRepo, RestTemplate restTemplate, ModelMapper modelMapper) {
        this.testRepository = testRepository;
        this.candidateRepo = candidateRepo;
        this.restTemplate = restTemplate;
        this.modelMapper = modelMapper;
    }

    @Override
    public TestDTO createTest(int quizId, int userId, TestDTO testDTO, String timeStart, String timeEnd) throws ParseException {

        HttpHeaders headers = new HttpHeaders();
        headers.set("userId", String.valueOf(userId));
        String url = "http://localhost:8083/api/quizzes/" + quizId;
        ResponseEntity<QuizDTO> responseEntity = restTemplate
                .exchange(url, HttpMethod.GET,new HttpEntity<>(headers), QuizDTO.class);
        QuizDTO quizDTO = responseEntity.getBody();


        Test test = modelMapper.map(testDTO, Test.class);
        test.setQuizId(quizId);

        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm dd-MM-yyyy");
        Date parsedDate = dateFormat.parse(timeStart);
        Timestamp timestamp = new Timestamp(parsedDate.getTime());
        test.setTimeStart(timestamp);


        Test createdTest = testRepository.save(test);
        TestDTO createdTestDTO = modelMapper.map(createdTest, TestDTO.class);
        createdTestDTO.setQuiz(quizDTO);

        List<CandidateDTO> candidateList = testDTO.getCandidates();

        for(CandidateDTO x:candidateList) {
            Candidate candidate = modelMapper.map(x, Candidate.class);
            candidate.setTestId(createdTest.getId());
            candidateRepo.save(candidate);
        }
        createdTestDTO.setCandidates(candidateList);


        return createdTestDTO;
    }

    @Override
    public TestDTO createTestFromExcel(int quizId,int userId, TestDTO testDTO, String filePath, String timeStart, String timeEnd) throws ParseException {
        HttpHeaders headers = new HttpHeaders();
        headers.set("userId", String.valueOf(userId));
        String url = "http://localhost:8083/api/quizzes/" + quizId;
        ResponseEntity<QuizDTO> responseEntity = restTemplate
                .exchange(url, HttpMethod.GET,new HttpEntity<>(headers), QuizDTO.class);


        QuizDTO quizDTO = responseEntity.getBody();

        Test test = modelMapper.map(testDTO, Test.class);
        test.setQuizId(quizId);

        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm dd-MM-yyyy");
        Date parsedTimeStart = dateFormat.parse(timeStart);
        Timestamp timeStart1 = new Timestamp(parsedTimeStart.getTime());
        test.setTimeStart(timeStart1);


        Date parsedTimeEnd = dateFormat.parse(timeEnd);
        Timestamp timeEnd1 = new Timestamp(parsedTimeEnd.getTime());
        test.setTimeEnd(timeEnd1);

        Test createdTest = testRepository.save(test);
        TestDTO createdTestDTO = modelMapper.map(createdTest, TestDTO.class);
        createdTestDTO.setQuiz(quizDTO);
        List<CandidateDTO> candidateList = createdTestDTO.addCandidatsFromExcel(filePath);

        for(CandidateDTO x:candidateList) {
            Candidate candidate = modelMapper.map(x, Candidate.class);
            candidate.setTestId(createdTest.getId());
            candidateRepo.save(candidate);
        }
        createdTestDTO.setCandidates(candidateList);




        return createdTestDTO;
    }

    @Override
    public TestDTO getTestByQuizCode(String quizCode, int userId) {
        Test test = testRepository.findByQuizCode(quizCode);

        HttpHeaders headers = new HttpHeaders();
        headers.set("userId", String.valueOf(userId));
        String url = "http://localhost:8083/api/quizzes/" + test.getQuizId();
        ResponseEntity<QuizDTO> responseEntity = restTemplate
                .exchange(url, HttpMethod.GET,new HttpEntity<>(headers), QuizDTO.class);


        QuizDTO quizDTO = responseEntity.getBody();
        TestDTO testDTO = modelMapper.map(test, TestDTO.class);
        testDTO.setQuiz(quizDTO);

        List<Candidate> candidateList = candidateRepo.findAllByTestId(test.getId());

        List<CandidateDTO> candidateDTOList = new ArrayList<>();
        for (Candidate candidate : candidateList) {
            CandidateDTO candidateDTO = modelMapper.map(candidate, CandidateDTO.class);
            candidateDTOList.add(candidateDTO);
        }
        testDTO.setCandidates(candidateDTOList);


        return testDTO;
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