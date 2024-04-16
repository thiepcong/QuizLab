package com.example.backend.service;

import com.example.backend.dto.LoginDTO;
import com.example.backend.dto.UserDTO;
import com.example.backend.entity.User;
import com.example.backend.response.LoginResponse;
import com.example.backend.response.RegisterResponse;

import java.util.Optional;


public interface UserService {
    RegisterResponse addUser(UserDTO userDTO);

    LoginResponse loginUser(LoginDTO loginDTO);
    Optional<User> findById(int userId);
}
