package com.example.backend.userController;



import com.example.backend.dto.LoginDTO;
import com.example.backend.dto.UserDTO;
import com.example.backend.entity.User;
import com.example.backend.response.LoginResponse;
import com.example.backend.response.RegisterResponse;
import com.example.backend.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
@RequestMapping("api/user")

public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping(path = "/save")
    public RegisterResponse saveUser(@RequestBody UserDTO userDTO) {
        RegisterResponse registerResponse =userService.addUser(userDTO);
        return registerResponse;
    }

    @PostMapping(path = "/login")
    public ResponseEntity<?> loginUser(@RequestBody LoginDTO loginDTO) {
        LoginResponse loginResponse = userService.loginUser(loginDTO);
        return ResponseEntity.ok(loginResponse);
    }


}
