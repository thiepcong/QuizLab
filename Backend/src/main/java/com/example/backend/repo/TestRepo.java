package com.example.backend.repo;

import com.example.backend.entity.Test;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;
import java.util.Set;

@EnableJpaRepositories
@Repository
public interface TestRepo extends JpaRepository<Test, Integer> {
    Test findByQuizCode(String quizCode);

    List<Test> findByQuizId(int id);
}
