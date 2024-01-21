/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class QuestionDAO {
    
    public String getQuestionPrompt(int id) throws Exception {
        String prompt = null; 
        DB db = new DB();
        Connection conn = db.getConnection(); 
        try {
            String sql = "SELECT GPT_Prompt FROM questions WHERE ID = ?";
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
    
    public ArrayList<Question> getQuestions() throws Exception {
        ArrayList<Question> questions = new ArrayList<Question>();
        DB db = new DB();
        Connection conn = db.getConnection(); 
        try {
            String sql 
                    = "SELECT q.ID, q.Question, q.GPT_Prompt, a.ID AS AnswerID, a.Answer, a.GPT_Prompt AS AnswerGPTPrompt FROM questions q JOIN answers a ON a.QuestionID = q.ID ORDER BY q.ID ASC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet res = stmt.executeQuery(); 
            Question currentQuestion = null;
            while(res.next()) {
               Answer answer = 
                       new Answer(res.getInt("AnswerID"), res.getInt("ID"), res.getString("Answer"), res.getString("AnswerGPTPrompt"));
               
               if (currentQuestion != null && currentQuestion.getId() == res.getInt("ID")) {
                   currentQuestion.addAnswer(answer);
               } else {
                   if (currentQuestion != null) {
                       questions.add(currentQuestion);
                   }
                   ArrayList<Answer> answers = new ArrayList<Answer>();
                   answers.add(answer);
                   currentQuestion =
                            new Question(res.getInt("ID"), res.getString("Question"), res.getString("GPT_Prompt"), answers);
               }
            }
            questions.add(currentQuestion);
        } catch (Exception e) {
            throw e;
        } finally {
            conn.close();
        }
        return questions;
    }
}
