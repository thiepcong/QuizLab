package com.example.backend.userController;

import com.example.backend.dto.QuestionDTO;
import com.example.backend.entity.Answer;
import com.example.backend.entity.Question;
import com.example.backend.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("api/questions")
public class QuestionController {

    private final QuestionService questionService;

    @Autowired
    public QuestionController(QuestionService questionService) {
        this.questionService = questionService;
    }

    @GetMapping("/all")
    public List<QuestionDTO> getAllQuestions() {
        List<Question> questions = questionService.getAllQuestions();
        List<QuestionDTO> questionDTOS = new ArrayList<QuestionDTO>();
       for (Question question : questions){
           questionDTOS.add(question.toDTO());
       }
        return questionDTOS;
    }

    @GetMapping("/{questionId}")
    public QuestionDTO getQuestionById(@PathVariable("questionId") int questionId) {
        Question question = questionService.getQuestionById(questionId);
        return question.toDTO();
    }

    @PostMapping("/add")
    public QuestionDTO createQuestion(@RequestBody QuestionDTO questionDTO) {
        Question createdQuestion = questionService.createQuestion(questionDTO);

        return questionService.getQuestionById(createdQuestion.getId()).toDTO();
    }

    @PutMapping("/update/{questionId}")
    public ResponseEntity<Question> updateQuestion(@PathVariable("questionId") int questionId, @RequestBody QuestionDTO questionDTO) {
        Optional<Question> existingQuestion = Optional.ofNullable(questionService.getQuestionById(questionId));
        if (existingQuestion.isPresent()) {
            questionDTO.setQuestionId(questionId);
            Question updatedQuestion = questionService.updateQuestion(questionDTO);
            return ResponseEntity.ok(updatedQuestion);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("{questionId}")
    public ResponseEntity<Void> deleteQuestion(@PathVariable("questionId") int questionId) {
        Optional<Question> existingQuestion = Optional.ofNullable(questionService.getQuestionById(questionId));
        if (existingQuestion.isPresent()) {
            questionService.deleteQuestion(questionId);
            return ResponseEntity.noContent().build();
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    @PutMapping("/update/{questionId}/answers/{answerId}")
    public ResponseEntity<Answer> updateAnswer(@PathVariable("questionId") int questionId, @PathVariable("answerId") int answerId, @RequestBody Answer answer) {
        Optional<Question> question = Optional.ofNullable(questionService.getQuestionById(questionId));
        if (question.isPresent()) {
            Optional<Answer> existingAnswer = questionService.getAnswerById(answerId);
            if (existingAnswer.isPresent()) {
                answer.setId(answerId);
                Answer updatedAnswer = questionService.updateAnswer(answer);
                return ResponseEntity.ok(updatedAnswer);
            } else {
                return ResponseEntity.notFound().build();
            }
        } else {
            return ResponseEntity.notFound().build();
        }
    }

}