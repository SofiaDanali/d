/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import java.util.ArrayList;

public class Question {
    private final int id; 
    private final String question;
    private final String gptPrompt;
    private ArrayList<Answer> answers;

    public Question(int id, String question, String gptPrompt, ArrayList<Answer> answers) {
        this.id = id;
        this.question = question;
        this.gptPrompt = gptPrompt;
        this.answers = answers;
    }

    public Question(int id, String question, String gptPrompt) {
        this.id = id;
        this.question = question;
        this.gptPrompt = gptPrompt;
    }
    
    public int getId() {
        return id;
    }

    public String getQuestion() {
        return question;
    }

    public ArrayList<Answer> getAnswers() {
        return answers;
    }

    public void setAnswers(ArrayList<Answer> answers) {
        this.answers = answers;
    }

    @Override
    public String toString() {
        return "Question{" + "id=" + id + ", question=" + question + ", answers=" + answers + '}';
    }

    public void addAnswer(Answer answer) {
        answers.add(answer);
    }

    public String getGptPrompt() {
        return gptPrompt;
    }
    
    
    
}
