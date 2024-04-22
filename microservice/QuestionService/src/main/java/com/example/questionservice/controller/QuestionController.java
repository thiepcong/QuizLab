package com.example.questionservice.controller;


import com.example.questionservice.dto.QuestionDTO;
import com.example.questionservice.entity.Answer;
import com.example.questionservice.entity.Question;
import com.example.questionservice.service.QuestionService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@CrossOrigin
@RestController
@RequestMapping("api/questions")
public class QuestionController {

    private final QuestionService questionService;
    private final ModelMapper modelMapper;

    private final RestTemplate restTemplate;

    @Autowired
    public QuestionController(QuestionService questionService, ModelMapper modelMapper, RestTemplate restTemplate) {
        this.questionService = questionService;
        this.modelMapper = modelMapper;
        this.restTemplate = restTemplate;
    }

    @GetMapping("/all")
    public ResponseEntity<List<QuestionDTO>> getAllQuestions(@RequestHeader("userId") int userId) {
        // Retrieve the user role based on the user ID
        HttpHeaders headers = new HttpHeaders();
        headers.set("userId", String.valueOf(userId));
        ResponseEntity<String> responseEntity = restTemplate
                .exchange("http://localhost:8081/api/user/role",
                        HttpMethod.GET,new HttpEntity<>(headers), String.class);


        String userRole = responseEntity.getBody();

        if (!"admin".equals(userRole)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        List<Question> questions = questionService.getAllQuestions();
        List<QuestionDTO> questionDTOs = questions.stream()
                .map(question -> modelMapper.map(question, QuestionDTO.class))
                .collect(Collectors.toList());
        return ResponseEntity.ok(questionDTOs);
    }
    @GetMapping("/users")
    public ResponseEntity<List<QuestionDTO>> getAllQuestionsByUserId(@RequestHeader("userId") int userId) {
        List<QuestionDTO> questions = questionService.getAllQuestionsByUserId(userId);
        return ResponseEntity.ok(questions);
    }

    @GetMapping("/quiz")
    public ResponseEntity<List<QuestionDTO>> getAllQuestionsByQuizId(@RequestHeader("quizId") int quizId) {
        List<QuestionDTO> questions = questionService.getAllQuestionsByQuizId(quizId);
        return ResponseEntity.ok(questions);
    }

    @GetMapping("/{questionId}")
    public ResponseEntity<QuestionDTO> getQuestionById(@PathVariable("questionId") int questionId) {
        QuestionDTO questionDTO = questionService.getQuestionById(questionId);
        if (questionDTO == null) {
            return ResponseEntity.notFound().build();
        }
        return ResponseEntity.ok(questionDTO);
    }



    @PostMapping("/add")
    public ResponseEntity<QuestionDTO> createQuestion(@RequestHeader("userId") int userId,
                                                      @RequestBody QuestionDTO questionDTO) {
        questionDTO.setUserId(userId);
        QuestionDTO createdQuestion = questionService.createQuestion(questionDTO);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdQuestion);
    }

    @PutMapping("/update/{questionId}")
    public ResponseEntity<QuestionDTO> updateQuestion(@PathVariable("questionId") int questionId,
                                                      @RequestHeader("userId") int userId,
                                                      @RequestBody QuestionDTO questionDTO) {
        QuestionDTO existingQuestion = questionService.getQuestionById(questionId);
        if (existingQuestion == null) {
            return ResponseEntity.notFound().build();
        }

        if (existingQuestion.getUserId() != userId) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        questionDTO.setUserId(userId);
        questionDTO.setId(questionId);
        QuestionDTO updatedQuestion = questionService.updateQuestion(questionDTO);
        return ResponseEntity.ok(updatedQuestion);
    }

    @DeleteMapping("/delete/{questionId}")
    public ResponseEntity<Void> deleteQuestion(@PathVariable("questionId") int questionId,
                                               @RequestHeader("userId") int userId) {
        QuestionDTO existingQuestion = questionService.getQuestionById(questionId);
        if (existingQuestion == null) {
            return ResponseEntity.notFound().build();
        }

        if (existingQuestion.getUserId() != userId) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        questionService.deleteQuestion(questionId);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/delete/quiz/{quizId}")
    @Transactional
    public ResponseEntity<Void> deleteQuestionByQuizId(@PathVariable("quizId") int quizId) {

        questionService.deleteQuestionByQuizId(quizId);
        return ResponseEntity.noContent().build();
    }

    @PutMapping("/update/{questionId}/answers/{answerId}")
    public ResponseEntity<Void> updateAnswer(@PathVariable("questionId") int questionId,
                                             @PathVariable("answerId") int answerId,
                                             @RequestHeader("userId") int userId,
                                             @RequestBody Answer answer) {
        QuestionDTO question = questionService.getQuestionById(questionId);
        if (question == null) {
            return ResponseEntity.notFound().build();
        }

        Optional<Answer> existingAnswer = questionService.getAnswerById(answerId);
        if (!existingAnswer.isPresent()) {
            return ResponseEntity.notFound().build();
        }

        if (question.getUserId() != userId) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        answer.setId(answerId);
        questionService.updateAnswer(answer);
        return ResponseEntity.ok().build();
    }
}


