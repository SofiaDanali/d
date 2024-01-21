<%@page import="db.Wine"%>
<%@page import="java.util.HashMap"%>
<%@page import="db.UserChoice"%>
<%@page import="db.User"%>
<%@page import="db.Answer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="db.Question"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<Wine> wines = (ArrayList<Wine>) request.getAttribute("wines");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GrapeVin | Κατάλληλο Κρασί</title>
        <jsp:include page="../fragments/stylesheets.jsp" />
    </head>
    <body>
        <jsp:include page="../fragments/navbar.jsp" />
            <div class="container mt-5 mb-5">
                <%
                    if (wines.size() == 0) {
                        %>
                        <h3>Δεν έχετε ακόμη συμπληρώσει το προφίλ σας!</h3>
                        <h4>Για να μπορέσουμε να σας προτείνουμε μια λίστα από τις επιλεγμένες ετικέτες κρασιών μας, παρακαλούμε <a class="link link-light" href="<%= request.getContextPath()%>/consumer/Profile">Συμπληρώστε το προφίλ σας</a> </h4>
                        <%
                    } else {
                        %>
                        <h3>Έχουμε ετοιμάσει μια λίστα κρασιών μόνο για εσάς!</h3>
                        <hr>
                        <div id="winesCarousel" class="carousel slide">
                            <div class="carousel-indicators">
                              <%
                                  for (int i = 0; i < wines.size(); i++) {
                                    if (i == 0) {
                                        %>
                                        <button type="button" data-bs-target="#winesCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                                        <%
                                    } else {
                                        %>
                                        <button type="button" data-bs-target="#winesCarousel" data-bs-slide-to="<%= i %>" aria-label="Slide <%= i %>"></button>
                                        <%
                                    }
                                  }
                              %>
                            </div>
                            <div class="carousel-inner">
                              <%
                                  for (int i = 0; i < wines.size(); i++) {
                                    Wine wine = wines.get(i);
                                    String imagePath = request.getContextPath() + wine.getImagePath();
                                    if (i == 0) {
                                        %>
                                          <div class="carousel-item active">
                                              <div class="container">
                                                  <div class="row">
                                                      <div class="col-4">
                                                            <img src="<%= imagePath %>" class="d-block mh-50vh">
                                                      </div>
                                                      <div class="col-8">
                                                          <h4>#<%= (i+1) %>. <%= wine.getName() %></h4>
                                                          <p><i><%= wine.getDescription() %></i></p>
                                                      </div>
                                                  </div>
                                              </div>
                                          </div>
                                        <%
                                    } else {
                                        %>
                                            <div class="carousel-item">
                                              <div class="container">
                                                  <div class="row">
                                                      <div class="col-4">
                                                            <img src="<%= imagePath %>" class="d-block mh-50vh">
                                                      </div>
                                                      <div class="col-8">
                                                          <h4>#<%= (i+1) %>. <%= wine.getName() %></h4>
                                                          <p><i><%= wine.getDescription() %></i></p>
                                                      </div>
                                                  </div>
                                              </div>
                                            </div>
                                        <%
                                    }
                                  }
                              %>
                            <button class="carousel-control-prev" type="button" data-bs-target="#winesCarousel" data-bs-slide="prev">
                              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                              <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#winesCarousel" data-bs-slide="next">
                              <span class="carousel-control-next-icon" aria-hidden="true"></span>
                              <span class="visually-hidden">Next</span>
                            </button>
                          </div>
                        
                        <%
                    }
                %>
            </div>
        <jsp:include page="../fragments/scripts.jsp" />
        <script type="module" src="<%=request.getContextPath()%>/static/js/profile.js"></script>
    </body>
</html>