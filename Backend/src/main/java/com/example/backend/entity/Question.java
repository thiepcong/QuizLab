package com.example.backend.entity;

import com.example.backend.dto.QuestionDTO;
import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "question")
public class Question {

    @Id
    @Column(name = "id", length = 10)
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Column(name = "content", length = 255)
    private String content;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "question_id")
    private List<Answer> answers;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    public Question() {
    }

    public Question(String content, List<Answer> answers) {
        this.content = content;
        this.answers = answers;
    }

    public Question(int id, String content, List<Answer> answers, User user) {
        this.id = id;
        this.content = content;
        this.answers = answers;
        this.user = user;
    }

    public QuestionDTO toDTO() {
        QuestionDTO questionDTO = new QuestionDTO();
        questionDTO.setQuestionId(id);
        questionDTO.setUserId(user.getId());
        questionDTO.setContent(content);
        questionDTO.setAnswers(answers);
        return questionDTO;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public List<Answer> getAnswers(List<Answer> answers) {
        return this.answers;
    }

    public void setAnswers(List<Answer> answers) {
        this.answers = answers;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "Question{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", answers=" + answers +
                '}';
    }
}