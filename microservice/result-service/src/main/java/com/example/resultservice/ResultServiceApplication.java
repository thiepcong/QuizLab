package com.example.resultservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.security.servlet.SecurityAutoConfiguration;

@SpringBootApplication(exclude = {SecurityAutoConfiguration.class})
public class ResultServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(ResultServiceApplication.class, args);
    }
}
