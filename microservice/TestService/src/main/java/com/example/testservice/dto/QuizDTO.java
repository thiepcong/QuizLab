package com.example.testservice.dto;


import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class QuizDTO {
    private int id;
    private String subject;
    private String title;
    private Timestamp time;
    private int userId;
    private List<QuestionDTO> questions;
    // Constructors, getters, and setters

    // Default constructor
    public QuizDTO() {
    }

    // Getters and setters
    public List<QuestionDTO> addQuestionsFromExcel(String filePath) {
        List<QuestionDTO> questionDTOList = new ArrayList<>();

        try (Workbook workbook = new XSSFWorkbook(new FileInputStream(new File(filePath)))) {
            Sheet sheet = workbook.getSheetAt(0); // Assuming the questions are in the first sheet

            for (Row row : sheet) {
                String questionContent = row.getCell(0).getStringCellValue();
                System.out.println(questionContent);

                QuestionDTO questionDTO = new QuestionDTO();
                questionDTO.setContent(questionContent);
                questionDTO.setUserId(this.getUserId());
                List<AnswerDTO> answers = new ArrayList<>();

                // Read the answers and correct answers from the respective columns
                for (int i = 1; i <= 4; i++) {
                    Cell answerCell = row.getCell(i);
                    Cell correctAnswerCell = row.getCell(i + 4);

                    String answerContent = answerCell.getStringCellValue();
                    boolean isCorrectAnswer = correctAnswerCell.getBooleanCellValue();

                    AnswerDTO answer = new AnswerDTO();
                    answer.setContent(answerContent);
                    answer.setStatus(isCorrectAnswer);

                    answers.add(answer);
                }

                questionDTO.setAnswers(answers);
                questionDTOList.add(questionDTO);
            }

        } catch (IOException e) {
            // Handle the exception appropriately
        }
        return questionDTOList;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Timestamp getTime() {
        return time;
    }

    public void setTime(Timestamp time) {
        this.time = time;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public List<QuestionDTO> getQuestions() {
        return questions;
    }

    public void setQuestions(List<QuestionDTO> questions) {
        this.questions = questions;
    }

}
