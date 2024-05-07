package com.example.quizservice.service.impl;


import com.example.quizservice.dto.QuestionDTO;
import com.example.quizservice.dto.QuizDTO;
import com.example.quizservice.entity.Quiz;
import com.example.quizservice.repo.QuizRepo;
import com.example.quizservice.service.QuizService;
import org.modelmapper.ModelMapper;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;


import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class QuizServiceImpl implements QuizService {
    private final QuizRepo quizRepo;
    private final ModelMapper modelMapper;

    private final RestTemplate restTemplate;

    public QuizServiceImpl(QuizRepo quizRepo, ModelMapper modelMapper, RestTemplate restTemplate) {
        this.quizRepo = quizRepo;
        this.modelMapper = modelMapper;
        this.restTemplate = restTemplate;
    }

    @Override
    public QuizDTO createQuiz(QuizDTO quizDTO) {
        System.out.println(quizDTO.getSubject());
        System.out.println(quizDTO.getQuestions().size());
        System.out.println(quizDTO.getQuestions().get(0).getContent());
        for(QuestionDTO questionDTO : quizDTO.getQuestions()){
            questionDTO.setUserId(quizDTO.getUserId());
        }
        Quiz quiz = modelMapper.map(quizDTO, Quiz.class);


        Quiz createdQuiz = quizRepo.save(quiz);

        for(QuestionDTO questionDTO: quizDTO.getQuestions()) {
            saveQuestion(questionDTO, createdQuiz.getId(), quizDTO.getUserId());
        }
        QuizDTO quizDTO1 = modelMapper.map(createdQuiz, QuizDTO.class);
        List<QuestionDTO> questionDTOList = getQuestion(quizDTO1.getId());
        quizDTO1.setQuestions(questionDTOList);

        return quizDTO1;
    }

    @Override
    public QuizDTO getQuizById(int quizId) {
        Optional<Quiz> quizOptional = quizRepo.findById(quizId);
        if (quizOptional.isPresent()) {

            Quiz quiz = quizOptional.get();
            QuizDTO quizDTO = modelMapper.map(quiz, QuizDTO.class);

            HttpHeaders headers = new HttpHeaders();
            headers.set("quizId", String.valueOf(quizId));
            HttpEntity<?> requestEntity = new HttpEntity<>(headers);
            String url = "http://localhost:8082/api/questions/quiz";

            ResponseEntity<List> responseEntity = restTemplate.exchange(
                    url,
                    HttpMethod.GET,
                    requestEntity,
                    List.class
            );

            List<QuestionDTO> questionDTOList = responseEntity.getBody();
            quizDTO.setQuestions(questionDTOList);
            return quizDTO;
        }
        return null;
    }

    @Override
    public List<QuizDTO> getAllQuizzes() {
        List<Quiz> quizzes = quizRepo.findAll();
        List<QuizDTO> quizDTOList = new ArrayList<>();
        for(Quiz quiz: quizzes) {
            System.out.println(quiz);
            HttpHeaders headers = new HttpHeaders();
            headers.set("quizId", String.valueOf(quiz.getId()));
            HttpEntity<?> requestEntity = new HttpEntity<>(headers);
            String url = "http://localhost:8082/api/questions/quiz";

            ResponseEntity<List> responseEntity = restTemplate.exchange(
                    url,
                    HttpMethod.GET,
                    requestEntity,
                    List.class
            );

            List<QuestionDTO> questionDTOList = responseEntity.getBody();
            QuizDTO quizDTO = modelMapper.map(quiz, QuizDTO.class);
            quizDTO.setQuestions(questionDTOList);
            quizDTOList.add(quizDTO);
        }
        return quizDTOList;
    }

    @Override
    public List<QuizDTO> getAllQuizzesByUserId(int userId) {
        List<Quiz> quizzes = quizRepo.findAllByUserId(userId);
        List<QuizDTO> quizDTOList = new ArrayList<>();
        for(Quiz quiz: quizzes) {
            System.out.println(quiz);
            HttpHeaders headers = new HttpHeaders();
            headers.set("quizId", String.valueOf(quiz.getId()));
            HttpEntity<?> requestEntity = new HttpEntity<>(headers);
            String url = "http://localhost:8082/api/questions/quiz";

            ResponseEntity<List> responseEntity = restTemplate.exchange(
                    url,
                    HttpMethod.GET,
                    requestEntity,
                    List.class
            );

            List<QuestionDTO> questionDTOList = responseEntity.getBody();
            QuizDTO quizDTO = modelMapper.map(quiz, QuizDTO.class);
            quizDTO.setQuestions(questionDTOList);

            quizDTOList.add(quizDTO);
        }
        return quizDTOList;
    }

    @Override
    public QuizDTO updateQuiz(QuizDTO quizDTO) {
        Optional<Quiz> quizOptional = quizRepo.findById(quizDTO.getId());
        if (quizOptional.isPresent()) {
            Quiz quiz = quizOptional.get();
            quiz.setTitle(quizDTO.getTitle());
            quiz.setSubject(quizDTO.getSubject());
            quiz.setTime(quizDTO.getTime());
            List<QuestionDTO> questionDTOList = quizDTO.getQuestions();
            for(QuestionDTO questionDTO: questionDTOList) {
                questionDTO.setQuizId(quizDTO.getId());

                HttpHeaders headers = new HttpHeaders();
                headers.set("userId", String.valueOf(quizDTO.getUserId()));

                HttpEntity<QuestionDTO> requestEntity = new HttpEntity<>(questionDTO, headers);
                ResponseEntity<QuestionDTO> responseEntity = restTemplate
                        .exchange("http://localhost:8082/api/questions/update/{questionId}",
                                HttpMethod.PUT,
                                requestEntity,
                                QuestionDTO.class,
                                questionDTO.getQuestionId());


            }
            // Update other attributes as needed
            Quiz updatedQuiz = quizRepo.save(quiz);
            return modelMapper.map(updatedQuiz, QuizDTO.class);
        }
        return null;
    }



    @Override
    public int deleteQuiz(int quizId) {
        if (quizRepo.existsById(quizId)) {
            quizRepo.deleteById(quizId);
            return 1;
        }
        return 0;
    }

    @Override
    public QuizDTO createQuizFromExcel(QuizDTO quizDTO, String filePath) {
        quizDTO.setQuestions(quizDTO.addQuestionsFromExcel(filePath));

        Quiz quiz = modelMapper.map(quizDTO, Quiz.class);
        Quiz createdQuiz = quizRepo.save(quiz);
        for(QuestionDTO questionDTO: quizDTO.getQuestions()) {
            saveQuestion(questionDTO, createdQuiz.getId(), quizDTO.getUserId());
        }
        QuizDTO quizDTO1 = modelMapper.map(createdQuiz, QuizDTO.class);
        List<QuestionDTO> questionDTOList = getQuestion(quizDTO1.getId());
        quizDTO1.setQuestions(questionDTOList);
        return quizDTO1;
    }

    private void saveQuestion(QuestionDTO questionDTO, int quizId, int userId) {
        questionDTO.setQuizId(quizId);

        HttpHeaders headers = new HttpHeaders();
        headers.set("userId", String.valueOf(userId));

        HttpEntity<QuestionDTO> requestEntity = new HttpEntity<>(questionDTO, headers);
        ResponseEntity<QuestionDTO> responseEntity = restTemplate
                .exchange("http://localhost:8082/api/questions/add",
                        HttpMethod.POST,
                        requestEntity,
                        QuestionDTO.class);


    }

    private List<QuestionDTO> getQuestion(int quizId) {
        HttpHeaders headers = new HttpHeaders();
        headers.set("quizId", String.valueOf(quizId));
        HttpEntity<List<QuestionDTO>> requestEntity = new HttpEntity<>(headers);
        ResponseEntity<List> responseEntity = restTemplate.exchange(
                "http://localhost:8082/api/questions/quiz",
                HttpMethod.GET,
                requestEntity,
                List.class);

        // Get the response body
        List<QuestionDTO> questions = responseEntity.getBody();
        return  questions;
    }
}