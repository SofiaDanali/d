/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;


public class UserChoice {
    private final int questionId;
    private final int answerId; 
    private final int userId; 

    public UserChoice(int questionId, int answerId, int userId) {
        this.questionId = questionId;
        this.answerId = answerId;
        this.userId = userId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public int getAnswerId() {
        return answerId;
    }

    public int getUserId() {
        return userId;
    }
    
    
}
