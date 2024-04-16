package com.example.backend.service;

import com.example.backend.dto.LoginDTO;
import com.example.backend.dto.UserDTO;
import com.example.backend.entity.User;
import com.example.backend.response.LoginResponse;

import java.util.Optional;


public interface UserService {
    User addUser(UserDTO userDTO);

    LoginResponse loginUser(LoginDTO loginDTO);
    Optional<User> findById(int userId);
}
