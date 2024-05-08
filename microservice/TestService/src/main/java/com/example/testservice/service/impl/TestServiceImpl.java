package com.example.testservice.service.impl;


import com.example.testservice.controller.WebSocketServer;
import com.example.testservice.dto.CandidateDTO;
import com.example.testservice.dto.QuizDTO;
import com.example.testservice.dto.TestDTO;
import com.example.testservice.entity.Candidate;
import com.example.testservice.entity.Test;
import com.example.testservice.repo.CandidateRepo;
import com.example.testservice.repo.TestRepo;
import com.example.testservice.service.CandidateService;
import com.example.testservice.service.TestService;
import org.modelmapper.ModelMapper;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;


import javax.websocket.DeploymentException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class TestServiceImpl implements TestService {
    private final TestRepo testRepository;

    private final CandidateRepo candidateRepo;
    private final CandidateService candidateService;

    private final RestTemplate restTemplate;
    private final ModelMapper modelMapper;
    private final WebSocketServer webSocketServer = new WebSocketServer();

    public TestServiceImpl(TestRepo testRepository, CandidateRepo candidateRepo, CandidateService candidateService, RestTemplate restTemplate, ModelMapper modelMapper) {
        this.testRepository = testRepository;
        this.candidateRepo = candidateRepo;
        this.candidateService = candidateService;
        this.restTemplate = restTemplate;
        this.modelMapper = modelMapper;
    }

    @Override
    public TestDTO createTest(int quizId, int userId, TestDTO testDTO, String timeStart, String timeEnd) throws ParseException, DeploymentException {

        HttpHeaders headers = new HttpHeaders();
        headers.set("userId", String.valueOf(userId));
        String url = "http://localhost:8083/api/quizzes/" + quizId;
        webSocketServer.sendMessageToAllSessions("TestService call QuizService to create quiz " + getCurrentTimeFormatted());
        ResponseEntity<QuizDTO> responseEntity = restTemplate
                .exchange(url, HttpMethod.GET,new HttpEntity<>(headers), QuizDTO.class);
        QuizDTO quizDTO = responseEntity.getBody();


        Test test = modelMapper.map(testDTO, Test.class);
        test.setQuizId(quizId);

        SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm dd-MM-yyyy");
        Date parsedDate = dateFormat.parse(timeStart);
        Timestamp timestamp = new Timestamp(parsedDate.getTime());
        test.setTimeStart(timestamp);
        testDTO.setTimeCreated(Calendar.getInstance().getTime());
        Date parsedTimeEnd = dateFormat.parse(timeEnd);
        Timestamp timeEnd1 = new Timestamp(parsedTimeEnd.getTime());
        test.setTimeEnd(timeEnd1);
        test.setQuizCode(TestDTO.generateRandomString(6));


        Test createdTest = testRepository.save(test);
        TestDTO createdTestDTO = modelMapper.map(createdTest, TestDTO.class);
        createdTestDTO.setQuiz(quizDTO);


        List<CandidateDTO> candidateList = testDTO.getCandidates();

        for(CandidateDTO x:candidateList) {
            Candidate candidate = modelMapper.map(x, Candidate.class);
            candidate.setTestId(createdTest.getId());
            candidateRepo.save(candidate);
        }
        createdTestDTO.setCandidates(candidateService.getCandidatesByTestId(createdTestDTO.getId()));


        return createdTestDTO;
    }

    @Override
    public TestDTO createTestFromExcel(int quizId,int userId, TestDTO testDTO, String filePath, String timeStart, String timeEnd) throws ParseException, DeploymentException {
        HttpHeaders headers = new HttpHeaders();
        headers.set("userId", String.valueOf(userId));
        String url = "http://localhost:8083/api/quizzes/" + quizId;
        webSocketServer.sendMessageToAllSessions("TestService call QuizService to create quiz from excel " + getCurrentTimeFormatted());
        ResponseEntity<QuizDTO> responseEntity = restTemplate
                .exchange(url, HttpMethod.GET,new HttpEntity<>(headers), QuizDTO.class);


        QuizDTO quizDTO = responseEntity.getBody();

        testDTO.setQuizCode(TestDTO.generateRandomString(6));
        testDTO.setTimeCreated(Calendar.getInstance().getTime());
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
        createdTestDTO.setCandidates(candidateService.getCandidatesByTestId(createdTestDTO.getId()));




        return createdTestDTO;
    }

    @Override
    public TestDTO getTestByQuizCode(String quizCode, int userId) throws DeploymentException {
        Test test = testRepository.findByQuizCode(quizCode);

        HttpHeaders headers = new HttpHeaders();
        headers.set("userId", String.valueOf(userId));
        webSocketServer.sendMessageToAllSessions("TestService call QuizService to get quiz by quizid " + getCurrentTimeFormatted());
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

    public static String getCurrentTimeFormatted() {
        Date currentTime = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss dd-MM-yyyy");
        String formattedTime = formatter.format(currentTime);
        return formattedTime;
    }
}