<%@page import="db.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/navbar.css">
<nav class="navbar navbar-expand-lg navbar-dark bg-mainDark px-5">
    <div class="container-fluid">
        
        <div class="d-flex flex-row justify-content-between w-100">
             
            <div class="logoContainer mw-15">
                <a class="w-100" href="<%= request.getContextPath() %>">
                    <img src="<%= request.getContextPath() %>/static/images/logo.png" class="logo w-100" alt="GrapeVin">
                </a>
            </div>
            <div class="logoCenter">
                <div class="d-flex justify-content-center w-100">
                    <h2 id="companyTitle">GrapeVin - Το κρασί που σου αξίζει!</h2>
                </div>
            </div>
            <div class="navbar-toggler collapseButtonWrapper">
                <button class="navbar-toggler mainLightColour ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
            </div>
            
            <%
                User user = (User) session.getAttribute("user"); 
                if (user == null) {
                    %>
                        <jsp:include page="./navbar_options/logged_out.jsp" />
                    <%
                } else {
                    %>
                        <jsp:include page="./navbar_options/logged_in.jsp" />
                    <%
                }
            %>
        </div>
        
        
    </div>
</nav>