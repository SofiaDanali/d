/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.quizvine.webapp.consumer;

import db.User;
import db.UserDAO;
import exceptions.InvalidCredentialsException;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.StringUtilities;

public class UpdatePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String oldPassword = request.getParameter("oldPassword");
        String password = request.getParameter("password"); 
        String passwordConf = request.getParameter("passwordConf");
        
        boolean missingValues =
                StringUtilities.isNullOrWhiteSpace(oldPassword) ||
                StringUtilities.isNullOrWhiteSpace(password) ||
                StringUtilities.isNullOrWhiteSpace(passwordConf);
        
        if (missingValues) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); 
            request.setAttribute("missing-fields", true); 
            request.getRequestDispatcher("/WEB-INF/consumer/profile.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(passwordConf)) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); 
            request.setAttribute("invalid-confirmation", true);
            request.getRequestDispatcher("/WEB-INF/consumer/profile.jsp").forward(request, response);
            return;
        }
        
        try {            
            UserDAO userDao = new UserDAO(); 
            HttpSession session = request.getSession();
            User user = ((User) session.getAttribute("user"));
           
            userDao.updateUserPassword(user, oldPassword, password);
        
            request.setAttribute("success", true);
            request.getRequestDispatcher("/WEB-INF/consumer/profile.jsp").forward(request, response);
            
        } catch(InvalidCredentialsException e) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); 
            request.setAttribute("wrong-password", true);
            request.getRequestDispatcher("/WEB-INF/consumer/profile.jsp").forward(request, response);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); 
            request.setAttribute("internal-error", true);
            request.getRequestDispatcher("/WEB-INF/consumer/profile.jsp").forward(request, response);
        }
        
        
    }
}
