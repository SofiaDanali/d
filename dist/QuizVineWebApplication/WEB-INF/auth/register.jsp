<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GrapeVin | Εγγραφή</title>
        <jsp:include page="../fragments/stylesheets.jsp" />
    </head>
    <body>
        <jsp:include page="../fragments/navbar.jsp" />
        <div class="container mt-5">
            <h2>Καλώς Ήλθατε στον κόσμο του GrapeVin!</h2> 
            <hr>
            <h4 class="mt-3">Μένουν λίγα μόνο βήματα για να βρείτε το ιδανικό σας κρασί! Φτιάξτε τώρα, εύκολα και γρήγορα τον προσωπικό σας λογαριασμό GrapeVin!</h4>
        </div>
        <%
            if (request.getAttribute("success") != null) {
                %> 
                    <div class="alert alert-success d-flex align-items-center my-3 container w-100" role="alert">
                        <i class="fa-solid fa-circle-info fa-2x"></i>
                        <div class="w-100 px-2">
                            <span>Η εγγραφή σας ολοκληρώθηκε με επιτυχία! Μπορείτε πλέον να <a href="<%=request.getContextPath()%>/Login" class="link link-primary">Συνδεθείτε στον λογαριασμό σας!</a></span>
                        </div>
                    </div>
                <%
            }
        %>
        <%
            if (request.getAttribute("missing-fields") != null) {
                %> 
                    <div class="alert alert-danger d-flex align-items-center my-3 container w-100" role="alert">
                        <i class="fa-solid fa-circle-info fa-2x"></i>
                        <div class="w-100 px-2">
                            <span>Η εγγραφή σας δεν μπόρεσε να ολοκληρωθεί! Παρακαλούμε συμπληρώστε <b>όλα τα απαιτούμενα πεδία</b>.</span>
                        </div>
                    </div>
                <%
            }
        %>
        <%
            if (request.getAttribute("invalid-confirmation") != null) {
                %> 
                    <div class="alert alert-danger d-flex align-items-center my-3 container w-100" role="alert">
                        <i class="fa-solid fa-circle-info fa-2x"></i>
                        <div class="w-100 px-2">
                            <span>Η εγγραφή σας δεν μπόρεσε να ολοκληρωθεί! Ο <b>κωδικός πρόσβασης</b> πρέπει να ταιριάζει με την <b>επιβεβαίωση</b>!</span>
                        </div>
                    </div>
                <%
            }
        %>
        <div class="container-sm mw-50 my-5 p-5 wrap-with-border">
            <form method="POST" action="<%=request.getContextPath()%>/Register" id="RegisterForm" novalidate>

                <div class="form-outline mb-4">
                    <label class="form-label required" for="FirstName">Όνομα</label>
                    <input type="text" id="FirstName" name="FirstName" class="form-control" required/>
                    <div class="invalid-feedback">Παρακαλούμε εισάγετε το Όνομα σας</div>
                </div>

                <div class="form-outline mb-4">
                    <label class="form-label required" for="LastName">Επώνυμο</label>
                    <input type="text" id="LastName" name="LastName" class="form-control" required/>
                    <div class="invalid-feedback">Παρακαλούμε εισάγετε το επώνυμο σας</div>
                </div>

                <div class="form-outline mb-4">
                    <label class="form-label required" for="Username">Όνομα Χρήστη (Username)</label>
                    <input type="text" id="Username" name="Username" class="form-control" required/>
                    <div class="invalid-feedback">Παρακαλούμε εισάγετε το Username σας</div>
                </div>

                <div class="form-outline mb-4">
                    <label class="form-label required" for="password">Κωδ. Πρόσβασης</label>
                    <input type="password" id="password" name="password" class="form-control" required />
                    <div class="invalid-feedback">Παρακαλούμε εισάγετε τον κωδικό πρόσβασής σας</div>
                </div>

                <div class="form-outline mb-4">
                    <label class="form-label required" for="passwordConf">Επιβεβαιώση Κωδ. Πρόσβασης</label>
                    <input type="password" id="passwordConf" name="passwordConf" class="form-control" />
                    <div class="invalid-feedback">Ο κωδικός δεν ταιριάζει με την επιβεβαίωση</div>
                </div>

                <div class="row">
                    <div class="col">
                        <button type="submit" class="btn btn-primary btn-block mb-4 float-end"><i class="fa-solid fa-right-to-bracket"></i> Εγγραφή</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col text-center">
                        <span>Έχετε ήδη λογαριασμό; <a class="link link-light" href="<%=request.getContextPath()%>/Login">Συνδεθείτε Τώρα!</a></span>
                    </div>
                </div>
            </form>
        </div>            
        <jsp:include page="../fragments/scripts.jsp" />
        <script type="module" src="<%= request.getContextPath()%>/static/js/register.js"></script>
    </body>
</html>