/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.quizvine.webapp.consumer;

import db.User;
import db.Wine;
import db.WineDAO;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author xrist
 */
public class RecommendedWinesServlet extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            try {
                User user = (User) request.getSession().getAttribute("user");
                WineDAO wineDao = new WineDAO(); 
                ArrayList<Wine> wines = wineDao.getRecommendedUserWines(user);
                request.setAttribute("wines", wines);
                request.getRequestDispatcher("/WEB-INF/consumer/recommend.jsp").forward(request, response);
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
    }
}
