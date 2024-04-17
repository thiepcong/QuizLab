package com.example.userservice.service;



import com.example.userservice.dto.LoginDTO;
import com.example.userservice.dto.UserDTO;
import com.example.userservice.entity.User;
import com.example.userservice.response.LoginResponse;
import com.example.userservice.response.RegisterResponse;

import java.util.Optional;


public interface UserService {
    RegisterResponse addUser(UserDTO userDTO);

    LoginResponse loginUser(LoginDTO loginDTO);
    Optional<User> findById(int userId);
}
