/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

public class Answer {
    private final int id; 
    private final int questionId; 
    private final String answer;
    private final String gptPrompt;

    public Answer(int id, int questionId, String answer, String gptPrompt) {
        this.id = id;
        this.questionId = questionId;
        this.answer = answer;
        this.gptPrompt = gptPrompt;
    }

    public int getId() {
        return id;
    }

    public int getQuestionId() {
        return questionId;
    }

    public String getAnswer() {
        return answer;
    }

    @Override
    public String toString() {
        return "Answer{" + "id=" + id + ", questionId=" + questionId + ", answer=" + answer + '}';
    }

    public String getGptPrompt() {
        return gptPrompt;
    }
    
    
}
