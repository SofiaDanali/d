/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.quizvine.webapp.consumer;

import db.User;
import db.UserChoice;
import db.UserChoiceDAO;
import exceptions.GPTException;
import gpt.GPTCommunication;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class QuestionnaireServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        try {
            UserChoiceDAO userChoiceDAO = new UserChoiceDAO(); 

            String[] questions = request.getParameterValues("question[]");
            for (String questionId: questions) {
                int id = Integer.parseInt(questionId);
                int answer = Integer.parseInt(request.getParameter("answer_" + questionId)); 
                int userId = ((User) request.getSession().getAttribute("user")).getId();
                
                userChoiceDAO.insertChoice(new UserChoice(id, answer, userId));
            }

            //use AI :)
            try {
                User user = ((User) request.getSession().getAttribute("user"));
                (new GPTCommunication()).generateUserPreferences(user);
            } catch (Exception e) {
                throw new GPTException(e.getMessage());
            }
            //update the choices on the page 
            ArrayList<UserChoice> userChoices 
                    = userChoiceDAO.getUserChoices(((User) ((HttpServletRequest) request).getSession().getAttribute("user")));
            
            ((HttpServletRequest) request).setAttribute("choices", userChoices);
            
            
            request.setAttribute("success", true);
            request.getRequestDispatcher("/WEB-INF/consumer/profile.jsp").forward(request, response);
        } catch(NumberFormatException ex) {
            request.setAttribute("bad-questionnaire-format", true);
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); 
            request.getRequestDispatcher("/WEB-INF/consumer/profile.jsp").forward(request, response);
        } catch (Exception ex) {
            Logger.getLogger(QuestionnaireServlet.class.getName()).log(Level.SEVERE, ex.toString(), ex);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); 
            request.setAttribute("internal-error", true);
            request.getRequestDispatcher("/WEB-INF/consumer/profile.jsp").forward(request, response);
        }
    }
}
