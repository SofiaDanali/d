/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.quizvine.webapp.auth;

import db.User;
import db.UserDAO;
import exceptions.InvalidCredentialsException;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    private String filterTarget(String target, String contextPath) {
        return (target == null || target.trim().length() == 0 || target.equals("null"))
                ? contextPath : target.trim();
    }
    
   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String target = request.getParameter("target"); 
        target = filterTarget(target, request.getContextPath());
        HttpSession session = request.getSession(); 
        if (session != null && session.getAttribute("user") != null) {
            response.sendRedirect(target);
            return;
        }
        request.getRequestDispatcher("/WEB-INF/auth/login.jsp").forward(request, response);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String target = request.getParameter("target"); 
        target = filterTarget(target, request.getContextPath());
        if (username == null || password == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            request.setAttribute("invalid_input", true);
            request.getRequestDispatcher("/WEB-INF/auth/login.jsp").forward(request, response);
            return;
        }
        //authenticate user
        try {            
            UserDAO userDao = new UserDAO(); 
            User user = userDao.authenticate(username, password); 
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect(target);
        } catch (InvalidCredentialsException e) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            request.setAttribute("invalid_uname_pwd", true);
            request.getRequestDispatcher("/WEB-INF/auth/login.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
