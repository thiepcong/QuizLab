package com.example.backend.dto;

import com.example.backend.entity.Answer;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class QuizDTO {
    private int id;
    private String subject;
    private String title;
    private int time;
    private int userId;
    private List<QuestionDTO> questions;
    private List<TestDTO> tests;

    // Constructors, getters, and setters

    // Default constructor
    public QuizDTO() {
    }

    // Parameterized constructor

    public QuizDTO(int id, String subject, String title, int time, int userId, List<QuestionDTO> questions, List<TestDTO> tests) {
        this.id = id;
        this.subject = subject;
        this.title = title;
        this.time = time;
        this.userId = userId;
        this.questions = questions;
        this.tests = tests;
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
                List<Answer> answers = new ArrayList<>();

                // Read the answers and correct answers from the respective columns
                for (int i = 1; i <= 4; i++) {
                    Cell answerCell = row.getCell(i);
                    Cell correctAnswerCell = row.getCell(i + 4);

                    String answerContent = answerCell.getStringCellValue();
                    boolean isCorrectAnswer = correctAnswerCell.getBooleanCellValue();

                    Answer answer = new Answer();
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

    public int getTime() {
        return time;
    }

    public void setTime(int time) {
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

    public List<TestDTO> getTests() {
        return tests;
    }

    public void setTests(List<TestDTO> tests) {
        this.tests = tests;
    }
}
