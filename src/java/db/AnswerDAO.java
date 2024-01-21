/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class AnswerDAO {
    public String getAnswerPrompt(int id) throws Exception {
        String prompt = null; 
        DB db = new DB();
        Connection conn = db.getConnection(); 
        try {
            String sql = "SELECT GPT_Prompt FROM Answers WHERE ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet res = stmt.executeQuery(); 
            if (res.next()) {
                prompt = res.getString("GPT_Prompt");
            }
        } catch (Exception e) {
            throw e;
        } finally {
            conn.close();
        }
        return prompt;
    }
    
    public String getOtherAnswersPrompt(int id, int questionId) throws Exception {
        ArrayList<String> segments = new ArrayList<String>();
        DB db = new DB();
        Connection conn = db.getConnection(); 
        try {
            String sql = "SELECT GPT_Prompt FROM Answers WHERE ID <> ? AND QuestionID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            stmt.setInt(2, questionId);
            ResultSet res = stmt.executeQuery(); 
            while (res.next()) {
                segments.add(res.getString("GPT_Prompt"));
            }
        } catch (Exception e) {
            throw e;
        } finally {
            conn.close();
        }
        return String.join(" or ", segments);
    }
}
