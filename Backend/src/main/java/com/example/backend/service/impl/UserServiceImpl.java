package com.example.backend.service.impl;


import com.example.backend.dto.LoginDTO;
import com.example.backend.dto.UserDTO;
import com.example.backend.entity.User;
import com.example.backend.repo.UserRepo;
import com.example.backend.response.LoginResponse;
import com.example.backend.response.RegisterResponse;
import com.example.backend.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepo userRepo;

    @Autowired
    private PasswordEncoder passwordEncoder;
    @Override
    public RegisterResponse addUser(UserDTO userDTO) {

        User user = userRepo.findUserByUsername(userDTO.getUsername());
        if(user == null) {
            User user1 = new User(
                    userDTO.getId(),
                    userDTO.getName(),
                    userDTO.getUsername(),
                    this.passwordEncoder.encode(userDTO.getPassword()),
                    userDTO.getRole()
            );
            userRepo.save(user1);
            return new RegisterResponse("Dang ki thanh cong", true, user1);
        }

        return new RegisterResponse("Dang ki khong thanh cong", false, null);

    }

    @Override
    public LoginResponse loginUser(LoginDTO loginDTO) {

        User user1 = userRepo.findUserByUsername(loginDTO.getUsername());
        if(user1 != null) {
            String password = loginDTO.getPassword();
            String encodedPassword = user1.getPassword();
            boolean check = passwordEncoder.matches(password, encodedPassword);
            if(check) {
                Optional<User> user = userRepo.findUserByUsernameAndPassword(
                        loginDTO.getUsername(), encodedPassword);
                if(user.isPresent()) {
                    return new LoginResponse("Login Success", true, user1);
                } else {
                    return new LoginResponse("Login Failed", false, null);
                }
            } else {
                return new LoginResponse("Password not match", false, null);
            }
        } else {
            return new LoginResponse("Username not exits", false, null);
        }
    }

    @Override
    public Optional<User> findById(int userId) {
        return userRepo.findById(userId);
    }
}
