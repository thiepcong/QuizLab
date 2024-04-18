package com.example.quizservice.repo;


import com.example.quizservice.entity.Quiz;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;

import java.util.List;

@EnableJpaRepositories
@Repository
public interface QuizRepo extends JpaRepository<Quiz, Integer> {
    List<Quiz> findAllByUserId(int userId);
    // Custom query methods or additional repository operations can be defined here if needed
}
