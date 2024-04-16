package com.example.backend.userController;

import com.example.backend.dto.QuizDTO;
import com.example.backend.service.QuizService;
import com.example.backend.service.UserService;
import org.modelmapper.ModelMapper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/quizzes")
public class QuizController {
    private final QuizService quizService;
    private final UserService userService;
    private final ModelMapper modelMapper;

    public QuizController(QuizService quizService, UserService userService, ModelMapper modelMapper) {
        this.quizService = quizService;
        this.userService = userService;
        this.modelMapper = modelMapper;
    }

    @PostMapping("/add")
    public ResponseEntity<QuizDTO> createQuiz(@RequestBody QuizDTO quizDTO, @RequestHeader("userId") int userId) {
        quizDTO.setUserId(userId);
        QuizDTO createdQuizDTO = quizService.createQuiz(quizDTO);
        return new ResponseEntity<>(createdQuizDTO, HttpStatus.CREATED);
    }

    @PostMapping("/create-from-excel")
    public ResponseEntity<QuizDTO> createQuizFromExcel(
            @RequestHeader("userId") int userId,
            @RequestHeader("filePath") String filePath,
            @RequestBody QuizDTO quizDTO) {

        quizDTO.setUserId(userId);

        try {
            QuizDTO createdQuiz = quizService.createQuizFromExcel(quizDTO, filePath);
            return ResponseEntity.ok(createdQuiz);
        } catch (Exception e) {
            System.out.println(e);
            // Handle any exceptions that occur during the creation of the quiz
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    @GetMapping("/{quizId}")
    public ResponseEntity<QuizDTO> getQuizById(@PathVariable int quizId,
                                               @RequestHeader("userId") int userId) {
        QuizDTO quizDTO = quizService.getQuizById(quizId);

        if (quizDTO == null) {
            return ResponseEntity.notFound().build();
        }

        if (quizDTO.getUserId() != userId) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        return ResponseEntity.ok(quizDTO);
    }

    @GetMapping("/all")
    public ResponseEntity<List<QuizDTO>> getAllQuizzes(@RequestHeader("userId") int userId) {
        String userRole = userService.findById(userId).get().getRole();

        if (!"admin".equals(userRole)) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        List<QuizDTO> quizDTOs = quizService.getAllQuizzes();
        return new ResponseEntity<>(quizDTOs, HttpStatus.OK);
    }

    @GetMapping("/users")
    public ResponseEntity<List<QuizDTO>> getAllQuizzesByUserId(@RequestHeader("userId") int userId) {
        List<QuizDTO> quizDTOS = quizService.getAllQuizzesByUserId(userId);
        return ResponseEntity.ok(quizDTOS);
    }


    @PutMapping("/{quizId}")
    public ResponseEntity<QuizDTO> updateQuiz(@PathVariable int quizId,
                                              @RequestHeader("userId") int userId,
                                              @RequestBody QuizDTO quizDTO) {
        QuizDTO existingQuizDTO = quizService.getQuizById(quizId);

        if (existingQuizDTO == null) {
            return ResponseEntity.notFound().build();
        }

        if (existingQuizDTO.getUserId() != userId) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        quizDTO.setId(quizId);
        QuizDTO updatedQuizDTO = quizService.updateQuiz(quizId, quizDTO);

        return ResponseEntity.ok(updatedQuizDTO);
    }

    @DeleteMapping("/{quizId}")
    public ResponseEntity<Void> deleteQuiz(@PathVariable int quizId,
                                           @RequestHeader("userId") int userId) {
        QuizDTO existingQuizDTO = quizService.getQuizById(quizId);

        if (existingQuizDTO == null) {
            return ResponseEntity.notFound().build();
        }

        if (existingQuizDTO.getUserId() != userId) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build();
        }

        quizService.deleteQuiz(quizId);

        return ResponseEntity.noContent().build();
    }
}
