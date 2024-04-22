package com.example.resultservice.repo;

import com.example.resultservice.entity.Candidate;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;

import java.util.List;

@EnableJpaRepositories
@Repository
public interface CandidateRepo extends JpaRepository<Candidate, Integer> {
    List<Candidate> findAllByTestId(int testId);
}
