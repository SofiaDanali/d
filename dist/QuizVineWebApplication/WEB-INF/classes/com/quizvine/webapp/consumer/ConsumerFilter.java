/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package com.quizvine.webapp.consumer;

import db.User;
import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ConsumerFilter implements Filter {
    
    public ConsumerFilter() {
    }    
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        
        User currentUser = (User) ((HttpServletRequest) request).getSession().getAttribute("user");
        if (currentUser != null) {
            chain.doFilter(request, response);
            return; 
        }
        String originalUrl = ((HttpServletRequest) request).getRequestURI();
        ((HttpServletResponse) response).sendRedirect(((HttpServletRequest) request).getContextPath() + "/Login?target=" + originalUrl + "&needsLogin=1");
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
       
    }

    @Override
    public void destroy() {
    }
    
}
