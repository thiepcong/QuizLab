package com.example.testservice.repo;


import com.example.testservice.entity.Test;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;

import java.util.List;

@EnableJpaRepositories
@Repository
public interface TestRepo extends JpaRepository<Test, Integer> {
    Test findByQuizCode(String quizCode);

    List<Test> findByQuizId(int id);

}
