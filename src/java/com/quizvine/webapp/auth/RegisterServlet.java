/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.quizvine.webapp.auth;

import db.User;
import db.UserDAO;
import exceptions.ExistingUserException;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.StringUtilities;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/auth/register.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setCharacterEncoding("UTF-8");
            String firstName = request.getParameter("FirstName");
            String lastName = request.getParameter("LastName");
            String username = request.getParameter("Username");
            String password = request.getParameter("password");
            String passwordConfirmation = request.getParameter("passwordConf");
            
            boolean missingFields = 
                    StringUtilities.isNullOrWhiteSpace(firstName) ||
                    StringUtilities.isNullOrWhiteSpace(lastName) || 
                    StringUtilities.isNullOrWhiteSpace(username) || 
                    StringUtilities.isNullOrWhiteSpace(password) || 
                    StringUtilities.isNullOrWhiteSpace(passwordConfirmation);
            
            if (missingFields) {
                request.setAttribute("missing-fields", true); 
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST); 
                request.getRequestDispatcher("/WEB-INF/auth/register.jsp").forward(request, response); 
                return;
            }
            
            if (!password.equals(passwordConfirmation)) {
                request.setAttribute("invalid-confirmation", true); 
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST); 
                request.getRequestDispatcher("/WEB-INF/auth/register.jsp").forward(request, response); 
                return;
            }
            
            User newUser = new User(firstName, lastName, username, password);   
            
            UserDAO userDao = new UserDAO(); 
            userDao.insertUser(newUser);
            
            request.setAttribute("success", true);
            request.getRequestDispatcher("/WEB-INF/auth/register.jsp").forward(request, response); 
            
        } catch (ExistingUserException e) {
            request.setAttribute("existing-user", e.getUsername());
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.getRequestDispatcher("/WEB-INF/auth/register.jsp").forward(request, response); 
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
