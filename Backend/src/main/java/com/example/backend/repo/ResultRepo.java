package com.example.backend.repo;

import com.example.backend.entity.Result;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@EnableJpaRepositories
@Repository
public interface ResultRepo extends JpaRepository<Result, Integer> {
    @Query("SELECT r.chosenAnswers FROM Result r WHERE r.id = :resultId")
    List<String> findChosenAnswersByResultId(@Param("resultId") int resultId);

    List<Result> findAllByCandidateId(int candidateId);
}
