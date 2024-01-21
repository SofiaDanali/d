<%@page import="db.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav ms-auto mainLightColour">
        <li class="nav-item mainLightColour">
            <a class="nav-link mainLightColour" href="<%= request.getContextPath() %>/consumer/RecommendedWines" tabindex="-1" aria-disabled="true">Προτεινόμενα Κρασία</a>
        </li>
        <li class="nav-item mainLightColour">
            <a class="nav-link mainLightColour" href="<%= request.getContextPath() %>/consumer/Profile" tabindex="-1" aria-disabled="true">Προφίλ</a>
        </li>
        <li class="nav-item mainLightColour">
            <a class="nav-link mainLightColour" href="<%= request.getContextPath() %>/Logout" tabindex="-1" aria-disabled="true">ΑΠΟΣΥΝΔΕΣΗ ( <i class="fa-solid fa-user"></i> <%= ((User) session.getAttribute("user")).getUsername() %> )</a>
        </li>
    </ul>
</div>