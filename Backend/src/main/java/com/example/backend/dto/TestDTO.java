package com.example.backend.dto;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

public class TestDTO {
    private int id;
    private String title;
    private Date timeCreated;
    private String quizCode;
    private String note;
    private QuizDTO quiz;
    private List<CandidateDTO> candidates;

    // Constructors, getters, and setters
    // ...

    public TestDTO() {
        this.quizCode = generateRandomString(6);
        this.timeCreated = new java.sql.Date(Calendar.getInstance().getTimeInMillis());
    }

    public TestDTO(int id, String title, Date timeCreated, String quizCode, String note, QuizDTO quiz, List<CandidateDTO> candidates) {
        this.id = id;
        this.title = title;
        this.timeCreated = timeCreated;
        this.quizCode = quizCode;
        this.note = note;
        this.quiz = quiz;
        this.candidates = candidates;
    }

    public List<CandidateDTO> addCandidatsFromExcel(String filePath) {
        List<CandidateDTO> candidateDTOList = new ArrayList<>();

        try (Workbook workbook = new XSSFWorkbook(new FileInputStream(new File(filePath)))) {
            Sheet sheet = workbook.getSheetAt(0); // Assuming the candidates are in the first sheet

            for (Row row : sheet) {
                String name = row.getCell(0).getStringCellValue();

                CandidateDTO candidateDTO = new CandidateDTO();
                candidateDTO.setName(name);
                candidateDTO.setTestId(this.id);
                candidateDTOList.add(candidateDTO);
            }

        } catch (IOException e) {
            // Handle the exception appropriately
        }
        return candidateDTOList;
    }

    public static String generateRandomString(int length) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder(length);
        Random random = new Random();

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(characters.length());
            char randomChar = characters.charAt(index);
            sb.append(randomChar);
        }

        return sb.toString();
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getTimeCreated() {
        return timeCreated;
    }

    public void setTimeCreated(Date timeCreated) {
        this.timeCreated = timeCreated;
    }

    public String getQuizCode() {
        return quizCode;
    }

    public void setQuizCode(String quizCode) {
        this.quizCode = quizCode;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public QuizDTO getQuiz() {
        return quiz;
    }

    public void setQuiz(QuizDTO quiz) {
        this.quiz = quiz;
    }

    public List<CandidateDTO> getCandidates() {
        return candidates;
    }

    public void setCandidates(List<CandidateDTO> candidates) {
        this.candidates = candidates;
    }
}
