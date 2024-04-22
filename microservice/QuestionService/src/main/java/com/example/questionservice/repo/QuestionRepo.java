package com.example.questionservice.repo;

import com.example.questionservice.entity.Question;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;

import java.util.List;

@EnableJpaRepositories
@Repository
public interface QuestionRepo extends JpaRepository<Question, Integer> {
    List<Question> findAllByUserId(int userId);
    List<Question> findAllByQuizId(int quizId);
    void deleteQuestionByQuizId(int quizId);
    // Add custom query methods if needed
}