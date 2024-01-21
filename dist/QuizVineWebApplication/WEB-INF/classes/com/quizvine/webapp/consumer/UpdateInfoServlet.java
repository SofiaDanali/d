/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.quizvine.webapp.consumer;

import db.User;
import db.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import util.StringUtilities;


public class UpdateInfoServlet extends HttpServlet {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String firstName = request.getParameter("FirstName");
        String lastName = request.getParameter("LastName");
        if (StringUtilities.isNullOrWhiteSpace(firstName) || StringUtilities.isNullOrWhiteSpace(lastName)) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); 
            request.setAttribute("missing-fields", true); 
            request.getRequestDispatcher("/WEB-INF/consumer/profile.jsp").forward(request, response);
            return;
        }
        try {            
            UserDAO userDao = new UserDAO(); 
            HttpSession session = request.getSession();
            User user = ((User) session.getAttribute("user"));
           
            userDao.updateUserName(user, firstName, lastName);
            
            //renew the user info for the session and thus, the page
            
            session.setAttribute("user", userDao.getUser(user.getId()));
           
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); 
            request.setAttribute("internal-error", true);
            request.getRequestDispatcher("/WEB-INF/consumer/profile.jsp").forward(request, response);
        }
        
        request.setAttribute("success", true);
        request.getRequestDispatcher("/WEB-INF/consumer/profile.jsp").forward(request, response);
    }
}
