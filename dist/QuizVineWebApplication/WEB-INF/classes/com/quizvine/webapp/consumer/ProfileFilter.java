/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package com.quizvine.webapp.consumer;

import db.Question;
import db.QuestionDAO;
import db.User;
import db.UserChoice;
import db.UserChoiceDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//There are lots of ways to end up in the profile page, so gather all its data from a single point
public class ProfileFilter implements Filter {
    
        @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        try {        
            QuestionDAO questionDao = new QuestionDAO();
            UserChoiceDAO userChoiceDao = new UserChoiceDAO();
            
            ArrayList<Question> questions = questionDao.getQuestions();
            ArrayList<UserChoice> userChoices 
                    = userChoiceDao.getUserChoices(((User) ((HttpServletRequest) request).getSession().getAttribute("user")));
            
            ((HttpServletRequest) request).setAttribute("questions", questions);
            ((HttpServletRequest) request).setAttribute("choices", userChoices);
            
            
            chain.doFilter(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ProfileFilter.class.getName()).log(Level.SEVERE, ex.toString(), ex);

            ((HttpServletResponse) response).sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
       
    }

    @Override
    public void destroy() {
    }
    
}
