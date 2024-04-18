package com.example.userservice.repo;



import com.example.userservice.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@EnableJpaRepositories
@Repository
public interface UserRepo extends JpaRepository<User, Integer> {
    Optional<User> findUserByUsernameAndPassword(String username, String password);
    User findUserByUsername(String username);
}
