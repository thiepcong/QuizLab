package com.example.backend.service.impl;

import com.example.backend.dto.QuestionDTO;
import com.example.backend.entity.Answer;
import com.example.backend.entity.Question;
import com.example.backend.entity.User;
import com.example.backend.repo.AnswerRepo;
import com.example.backend.repo.QuestionRepo;
import com.example.backend.repo.UserRepo;
import com.example.backend.service.QuestionService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class QuestionServiceImpl implements QuestionService {

    private final QuestionRepo questionRepository;
    private final UserRepo userRepository;
    private final AnswerRepo answerRepository;
    private final ModelMapper modelMapper;

    @Autowired
    public QuestionServiceImpl(QuestionRepo questionRepository, UserRepo userRepository, AnswerRepo answerRepository, ModelMapper modelMapper) {
        this.questionRepository = questionRepository;
        this.userRepository = userRepository;
        this.answerRepository = answerRepository;
        this.modelMapper = modelMapper;
    }

    @Override
    public List<Question> getAllQuestions() {
        return questionRepository.findAll();
    }

    @Override
    public QuestionDTO getQuestionById(int id) {
        Question question = questionRepository.findById(id).orElse(null);
        return modelMapper.map(question, QuestionDTO.class);
    }

    @Override
    public QuestionDTO createQuestion(QuestionDTO questionDTO) {
        int userId = questionDTO.getUserId();
        User user = userRepository.findById(userId).orElseThrow(() ->
                new IllegalArgumentException("User not found with ID: " + userId));
        Question question = modelMapper.map(questionDTO, Question.class);
        question.setUserId(userId);
        question = questionRepository.save(question);
        return modelMapper.map(question, QuestionDTO.class);
    }

    @Override
    public QuestionDTO updateQuestion(QuestionDTO questionDTO) {
        Question question = modelMapper.map(questionDTO, Question.class);
        question = questionRepository.save(question);
        return modelMapper.map(question, QuestionDTO.class);
    }

    @Override
    public void deleteQuestion(int id) {
        questionRepository.deleteById(id);
    }

    @Override
    public Optional<Answer> getAnswerById(int id) {
        return answerRepository.findById(id);
    }

    @Override
    public Answer updateAnswer(Answer answer) {
        return answerRepository.save(answer);
    }

    @Override
    public List<QuestionDTO> getAllQuestionsByUserId(int userId) {
        List<Question> questions = questionRepository.findAllByUserId(userId);
        return questions.stream()
                .map(question -> modelMapper.map(question, QuestionDTO.class))
                .collect(Collectors.toList());
    }
}
