<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav ms-auto mainLightColour">
        <li class="nav-item mainLightColour">
            <a class="nav-link mainLightColour" href="<%= request.getContextPath() %>/consumer/RecommendedWines" tabindex="-1" aria-disabled="true">Προτεινόμενα κρασία</a>
        </li>
        <li class="nav-item mainLightColour">
            <a class="nav-link mainLightColour" href="<%= request.getContextPath() %>/Register" tabindex="-1" aria-disabled="true"> Εγγραφή</a>
        </li>
        <li class="nav-item mainLightColour">
            <a class="nav-link mainLightColour" href="<%= request.getContextPath() %>/Login?target=<%= request.getAttribute("javax.servlet.forward.request_uri") %>" tabindex="-1" aria-disabled="true"><i class="fa-solid fa-right-to-bracket"></i> Σύνδεση</a>
        </li>
    </ul>
</div>
