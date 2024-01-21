<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GrapeVin | Σύνδεση</title>
        <jsp:include page="../fragments/stylesheets.jsp" />
    </head>
    <body>
        <jsp:include page="../fragments/navbar.jsp" />
        <% 
            if (request.getAttribute("invalid_uname_pwd") != null) {
                %> 
                    <div class="alert alert-danger d-flex align-items-center my-3 container w-100" role="alert">
                        <i class="fa-solid fa-circle-info fa-2x"></i>
                        <div class="w-100 px-2">
                            <span>Τα στοιχεία που δώσατε δεν ήταν δυνατό να επαληθευτούν!</span>
                        </div>
                    </div>
                <%
            } else if (request.getAttribute("invalid_input") != null) {
                %> 
                    <div class="alert alert-danger d-flex align-items-center my-3 container w-100" role="alert">
                        <i class="fa-solid fa-circle-info fa-2x"></i>
                        <div class="w-100 px-2">
                            <span>Πρέπει να συμπληρώστε το username και τον κωδικό σας!</span>
                        </div>
                    </div>
                <%
            } else if (request.getAttribute("internal_error") != null) {
                %>
                    <div class="alert alert-danger d-flex align-items-center my-3 container w-100" role="alert">
                        <i class="fa-solid fa-circle-info fa-2x"></i>
                        <div class="w-100 px-2">
                            <span>Εσωτερικό Σφάλμα Συστήματος!</span>
                        </div>
                    </div>
                <%
            } else if (request.getParameter("needsLogin") != null) {
                %>
                    <div class="alert alert-info d-flex align-items-center my-3 container w-100" role="alert">
                        <i class="fa-solid fa-circle-info fa-2x"></i>
                        <div class="w-100 px-2">
                            <span>Χρειάζεται πρώτα να συνδεθείτε στον λογαριασμό σας!</span>
                        </div>
                    </div>
                <%
            }
        %>
            <%
                String target = 
                    request.getParameter("target") != null && !request.getParameter("target").equals("null")
                        ? "?target=" + request.getParameter("target")
                        : "";
                String action = request.getContextPath() + "/Login" + target;
            %>
            <div class="container-sm mw-50 my-5 p-5 wrap-with-border">
                <form method="POST" action="<%= action %>" id="LoginForm" novalidate>
                    <!-- Email input -->
                    <div class="form-outline mb-4">
                        <label class="form-label required" for="unameTxt"><i class="fa-solid fa-user"></i> Όνομα Χρήστη (username)</label>
                        <input type="text" id="unameTxt" name="username" class="form-control" required/>
                        <div class="invalid-feedback">Παρακαλούμε εισάγετε το όνομα χρήστη του λογαριασμού σας</div>
                    </div>

                    <!-- Password input -->
                    <div class="form-outline mb-4">
                        <label class="form-label required" for="passwordTxt"><i class="fa-solid fa-key"></i> Κωδ. Πρόσβασης</label>
                        <input type="password" id="passwordTxt" name="password" class="form-control" required />
                        <div class="invalid-feedback">Παρακαλούμε εισάγετε τον κωδικό πρόσβασής σας</div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <button type="submit" id="loginBtn" class="btn btn-success btn-block mb-4 float-end"><i class="fa-solid fa-right-to-bracket"></i> Σύνδεση</button>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col text-center">
                            <span>Δεν έχετε λογαριασμό; <a class="link link-light" href="<%=request.getContextPath()%>/Register">Εγγραφείτε Τώρα!</a></span>
                        </div>
                    </div>
                </form>
            </div>        
        <jsp:include page="../fragments/scripts.jsp" />
        <script type="module" src="<%= request.getContextPath()%>/static/js/login.js"></script>
    </body>
</html>
