package com.example.backend.service.impl;

import com.example.backend.dto.QuestionDTO;
import com.example.backend.entity.Answer;
import com.example.backend.entity.Question;
import com.example.backend.entity.User;
import com.example.backend.repo.QuestionRepo;
import com.example.backend.repo.UserRepo;
import com.example.backend.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class QuestionServiceImpl implements QuestionService {

    private final QuestionRepo questionRepository;
    private final UserRepo userRepository;


    @Autowired
    public QuestionServiceImpl(QuestionRepo questionRepository, UserRepo userRepository) {
        this.questionRepository = questionRepository;
        this.userRepository = userRepository;
    }

    @Override
    public List<Question> getAllQuestions() {
        return questionRepository.findAll();
    }

    @Override
    public Question getQuestionById(int id) {
        return questionRepository.findById(id).orElse(null);
    }

    @Override
    public Question createQuestion(QuestionDTO questionDTO) {
        int userId = questionDTO.getUserId();
        User user = userRepository.findById(userId).orElseThrow(() ->
                new IllegalArgumentException("User not found with ID: " + userId));
        Question question = new Question();
        question.setContent(questionDTO.getContent());
        question.setUser(user);
        question.setAnswers(questionDTO.getAnswers());

        return questionRepository.save(question);
    }

    @Override
    public Question updateQuestion(QuestionDTO questionDTO) {
        return questionRepository.save(entityFromDTO(questionDTO));
    }

    @Override
    public void deleteQuestion(int id) {
        questionRepository.deleteById(id);
    }

    @Override
    public Optional<Answer> getAnswerById(int id) {
        return Optional.empty();
    }

    @Override
    public Answer updateAnswer(Answer answer) {
        return null;
    }

    public Question entityFromDTO(QuestionDTO questionDTO){
        Question question = new Question();
        question.setId(questionDTO.getQuestionId());
        question.setContent(questionDTO.getContent());
        question.setAnswers(questionDTO.getAnswers());
        question.setUser(userRepository.findById(questionDTO.getUserId()).get());
        return question;
    }
}