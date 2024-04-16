package com.example.backend.userController;

import com.example.backend.dto.QuestionDTO;
import com.example.backend.entity.Answer;
import com.example.backend.entity.Question;
import com.example.backend.service.QuestionService;
import com.example.backend.service.UserService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@CrossOrigin
@RestController
@RequestMapping("api/questions")
public class QuestionController {

    private final QuestionService questionService;
    private final UserService userService;
    private final ModelMapper modelMapper;

    @Autowired
    public QuestionController(QuestionService questionService, UserService userService, ModelMapper modelMapper) {
        this.questionService = questionService;
        this.userService = userService;
        this.modelMapper = modelMapper;
    }

    @GetMapping("/all")
    public ResponseEntity<List<QuestionDTO>> getAllQuestions(@RequestHeader("userId") int userId) {
        // Retrieve the user role based on the user ID
        String userRole = userService.findById(userId).get().getRole();

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
        questionDTO.setQuestionId(questionId);
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


