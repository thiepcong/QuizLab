package com.example.userservice.controller;


import com.example.userservice.dto.LoginDTO;
import com.example.userservice.dto.UserDTO;
import com.example.userservice.entity.User;
import com.example.userservice.repo.UserRepo;
import com.example.userservice.response.LoginResponse;
import com.example.userservice.response.RegisterResponse;
import com.example.userservice.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@CrossOrigin
@RequestMapping("api/user")

public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepo userRepo;

    @PostMapping(path = "/save")
    public ResponseEntity<?> saveUser(@RequestBody UserDTO userDTO) {
        RegisterResponse registerResponse =userService.addUser(userDTO);
        if (registerResponse.getStatus()) {
            return ResponseEntity.ok(registerResponse);
        }
        return ResponseEntity.badRequest().body(registerResponse);
    }

    @PostMapping(path = "/login")
    public ResponseEntity<?> loginUser(@RequestBody LoginDTO loginDTO) {
        LoginResponse loginResponse = userService.loginUser(loginDTO);
        return ResponseEntity.ok(loginResponse);
    }

    @GetMapping(path = "/role")
    public String roleUser(@RequestHeader int userId) {
        Optional<User> user = userRepo.findById(userId);
        return user.get().getRole();
    }


}
