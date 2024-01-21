/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class UserChoiceDAO {
    public void insertChoice(UserChoice userChoice) throws Exception {
        DB db = new DB(); 
        Connection conn = db.getConnection();
        try {
 
            String sql 
                    = "INSERT INTO USER_CHOICES (QuestionID, AnswerID, UserID) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE QuestionID = ?, AnswerID = ?, UserID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql); 
            stmt.setInt(1, userChoice.getQuestionId());
            stmt.setInt(2, userChoice.getAnswerId());
            stmt.setInt(3, userChoice.getUserId());
            stmt.setInt(4, userChoice.getQuestionId());
            stmt.setInt(5, userChoice.getAnswerId());
            stmt.setInt(6, userChoice.getUserId());
           
            stmt.execute();
         
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, e.toString(), e);
            throw e;
        } finally {
            conn.close();
        }
    }
    
    public ArrayList<UserChoice> getUserChoices(User user) throws Exception {
        ArrayList<UserChoice> choices = new ArrayList<UserChoice>();
        DB db = new DB();
        Connection conn = db.getConnection(); 
        try {
            String sql 
                    = "SELECT QuestionID, AnswerID, UserID FROM USER_CHOICES WHERE UserID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, user.getId());
            ResultSet res = stmt.executeQuery(); 
            while(res.next()) {
               UserChoice choice 
                       = new UserChoice(res.getInt("QuestionID"), res.getInt("AnswerID"), res.getInt("UserID"));
                choices.add(choice);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            conn.close();
        }
        return choices;
    }
}
