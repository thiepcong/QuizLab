package com.example.backend.repo;

import com.example.backend.entity.Answer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;

@EnableJpaRepositories
@Repository
public interface AnswerRepo extends JpaRepository<Answer, Integer> {
    // Add custom query methods if needed
}
