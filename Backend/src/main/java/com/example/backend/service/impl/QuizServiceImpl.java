package com.example.backend.service.impl;

import com.example.backend.dto.QuizDTO;
import com.example.backend.entity.Quiz;
import com.example.backend.repo.QuizRepo;
import com.example.backend.service.QuizService;
import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class QuizServiceImpl implements QuizService {
    private final QuizRepo quizRepo;
    private final ModelMapper modelMapper;

    public QuizServiceImpl(QuizRepo quizRepo, ModelMapper modelMapper) {
        this.quizRepo = quizRepo;
        this.modelMapper = modelMapper;
    }

    @Override
    public QuizDTO createQuiz(QuizDTO quizDTO) {
        Quiz quiz = modelMapper.map(quizDTO, Quiz.class);
        Quiz createdQuiz = quizRepo.save(quiz);
        return modelMapper.map(createdQuiz, QuizDTO.class);
    }

    @Override
    public QuizDTO getQuizById(int quizId) {
        Optional<Quiz> quizOptional = quizRepo.findById(quizId);
        if (quizOptional.isPresent()) {
            Quiz quiz = quizOptional.get();
            return modelMapper.map(quiz, QuizDTO.class);
        }
        return null;
    }

    @Override
    public List<QuizDTO> getAllQuizzes() {
        List<Quiz> quizzes = quizRepo.findAll();
        return quizzes.stream()
                .map(quiz -> modelMapper.map(quiz, QuizDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public List<QuizDTO> getAllQuizzesByUserId(int userId) {
        List<Quiz> quizzes = quizRepo.findAllByUserId(userId);
        return quizzes.stream()
                .map(quiz -> modelMapper.map(quiz, QuizDTO.class))
                .collect(Collectors.toList());
    }

    @Override
    public QuizDTO updateQuiz(int quizId, QuizDTO quizDTO) {
        Optional<Quiz> quizOptional = quizRepo.findById(quizId);
        if (quizOptional.isPresent()) {
            Quiz quiz = quizOptional.get();
            quiz.setTitle(quizDTO.getTitle());
            quiz.setSubject(quizDTO.getSubject());
            quiz.setTime(quizDTO.getTime());
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
        quizDTO.setQuestions(quizDTO.addQuestionsFromExcel(filePath));;
        Quiz quiz = modelMapper.map(quizDTO, Quiz.class);
        Quiz createdQuiz = quizRepo.save(quiz);
        return modelMapper.map(createdQuiz, QuizDTO.class);
    }
}