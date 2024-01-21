<%@page import="java.util.HashMap"%>
<%@page import="db.UserChoice"%>
<%@page import="db.User"%>
<%@page import="db.Answer"%>
<%@page import="java.util.ArrayList"%>
<%@page import="db.Question"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = ((User) (request.getSession().getAttribute("user")));
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GrapeVin | Προφίλ</title>
        <jsp:include page="../fragments/stylesheets.jsp" />
    </head>
    <body>
        <jsp:include page="../fragments/navbar.jsp" />
            <div class="container mt-5 mb-5">
                <%
                    if (request.getAttribute("bad-questionnaire-format") != null) {
                        %> 
                            <div class="alert alert-danger d-flex align-items-center my-3 container w-100" role="alert">
                                <i class="fa-solid fa-circle-info fa-2x"></i>
                                <div class="w-100 px-2">
                                    <span>Η αλλαγή δεν μπόρεσε να ολοκληρωθεί! Παρακαλούμε επιλέξτε τα σωστά πεδία στο ερωτηματολόγιο.</span>
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
                                    <span>Η αλλαγή δεν μπόρεσε να ολοκληρωθεί! Παρακαλούμε συμπληρώστε <b>όλα τα απαιτούμενα πεδία</b>.</span>
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
                                    <span>Η αλλαγή δεν μπόρεσε να ολοκληρωθεί! Ο <b>κωδικός πρόσβασης</b> πρέπει να ταιριάζει με την <b>επιβεβαίωση</b>!</span>
                                </div>
                            </div>
                        <%
                    }
                %>
                <%
                    if (request.getAttribute("wrong-password") != null) {
                        %> 
                            <div class="alert alert-danger d-flex align-items-center my-3 container w-100" role="alert">
                                <i class="fa-solid fa-circle-info fa-2x"></i>
                                <div class="w-100 px-2">
                                    <span>Η αλλαγή δεν μπόρεσε να ολοκληρωθεί! Ο τρέχων κωδικός πρόσβασης σας δεν είναι σωστός!</span>
                                </div>
                            </div>
                        <%
                    }
                %>
                <%
                    if (request.getAttribute("internal-error") != null) {
                        %> 
                            <div class="alert alert-danger d-flex align-items-center my-3 container w-100" role="alert">
                                <i class="fa-solid fa-circle-info fa-2x"></i>
                                <div class="w-100 px-2">
                                    <span>Η αλλαγή δεν μπόρεσε να ολοκληρωθεί! Προέκυψε εσωτερικό σφάλμα συστήματος!</span>
                                </div>
                            </div>
                        <%
                    }
                %>
                <%
                    if (request.getAttribute("success") != null) {
                        %> 
                            <div class="alert alert-success d-flex align-items-center my-3 container w-100" role="alert">
                                <i class="fa-solid fa-circle-info fa-2x"></i>
                                <div class="w-100 px-2">
                                    <span>Οι αλλαγές σας καταχωρήθηκαν με επιτυχία!</span>
                                </div>
                            </div>
                        <%
                    }
                %>
                <h3>Το προφίλ μου</h3>
                <hr>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="row">
                                <form method="POST" action="<%= request.getContextPath() %>/consumer/Profile/UpdateInfo">
                                    <h4>Πληροφορίες</h4>
                                    <p class="float-end"><i>Μπορείτε να τροποποιήσετε κάθε προσωπικό στοιχείο που βρίσκεται στη σελίδα μας.</i></p>

                                    <div class="form-outline mb-4">
                                        <label class="form-label required" for="FirstName">Όνομα</label>
                                        <input type="text" id="FirstName" name="FirstName" class="form-control" value="<%= user.getFirstname() %>" required/>
                                        <div class="invalid-feedback">Παρακαλούμε εισάγετε το Όνομα σας</div>
                                    </div>
                                    <div class="form-outline mb-4">
                                        <label class="form-label required" for="LastName">Επώνυμο</label>
                                        <input type="text" id="LastName" name="LastName" class="form-control" value="<%= user.getLastname() %>" required/>
                                        <div class="invalid-feedback">Παρακαλούμε εισάγετε το επώνυμο σας</div>
                                    </div>
                                    <button class="btn btn-primary float-end" type="submit"><i class="fa-solid fa-check text-success"></i> Ενημέρωση</button>
                                </form>
                            </div>
                            <hr>
                            <div class="row">
                                <form id="UpdatePasswordForm" method="POST" action="<%= request.getContextPath() %>/consumer/Profile/UpdatePassword" novalidate>
                                    <h4>Αλλαγή Κωδ. Πρόσβασης</h4>
                                    <p class="float-end"><i>Μπορείτε να αλλάξετε τον κωδικό σας ανά πάσα στιγμή.</i></p>

                                    <div class="form-outline mb-4">
                                        <label class="form-label required" for="oldPassword">Τρέχων Κωδ. Πρόσβασης</label>
                                        <input type="password" id="oldPassword" name="oldPassword" class="form-control" required />
                                        <div class="invalid-feedback">Παρακαλούμε εισάγετε τον τρέχοντα κωδικό πρόσβασής σας</div>
                                    </div>


                                    <div class="form-outline mb-4">
                                        <label class="form-label required" for="password">Κωδ. Πρόσβασης</label>
                                        <input type="password" id="password" name="password" class="form-control" required />
                                        <div class="invalid-feedback">Παρακαλούμε εισάγετε τον νέο κωδικό πρόσβασής σας</div>
                                    </div>

                                    <div class="form-outline mb-4">
                                        <label class="form-label required" for="passwordConf">Επιβεβαιώση Κωδ. Πρόσβασης</label>
                                        <input type="password" id="passwordConf" name="passwordConf" class="form-control" />
                                        <div class="invalid-feedback">Ο νέος κωδικός δεν ταιριάζει με την επιβεβαίωση</div>
                                    </div>
                                    
                                    <button class="btn btn-primary float-end" type="submit"><i class="fa-solid fa-key"></i> Αλλαγή</button>
                                </form>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <div class="wrap-with-border h-100">
                                <h4>Ερωτηματολόγιο</h4>
                                <form method="POST" action="<%= request.getContextPath() %>/consumer/Profile/Questionnaire" novalidate>
                                    <p class="float-end"><i>Η συμπλήρωση του ερωτηματολογίου, μας επιτρέπει να διαλέξουμε το καλύτερο κρασί για εσάς</i></p>
                                    <ol class="list-group list-group-numbered w-100">
                                        <%
                                            ArrayList<Question> questions = ((ArrayList<Question>) request.getAttribute("questions"));
                                            ArrayList<UserChoice> choices = ((ArrayList<UserChoice>) request.getAttribute("choices"));
                                            HashMap<Integer, Integer> questionChoiceMap = new HashMap<Integer, Integer>(); 
                                            for (UserChoice choice: choices) {
                                                questionChoiceMap.put(choice.getQuestionId(), choice.getAnswerId());
                                            }
                                            for (Question question: questions) {
                                                %>
                                                    <li class="list-group-item">
                                                        <div class="ms-2 me-auto">
                                                            <input type="hidden" name="question[]" value="<%= question.getId() %>">
                                                            <div class="fw-bold"><label class="label required"><%= question.getQuestion() %></label></div>
                                                            <div class="d-flex flex-row justify-content-between mt-2">
                                                                <%
                                                                    ArrayList<Answer> answers = question.getAnswers(); 
                                                                    for (Answer answer: answers) {
                                                                        String radioButtonId = "qa" + question.getId() + "_" + answer.getId();
                                                                        Integer chosenAnswer = questionChoiceMap.get(question.getId());
                                                                        boolean isChosen = chosenAnswer != null && chosenAnswer == answer.getId();
                                                                        %>
                                                                            <div class="form-check form-check-inline">
                                                                                <input class="form-check-input" type="radio" name="answer_<%= question.getId() %>" id="<%= radioButtonId %>" value="<%= answer.getId() %>" <%= isChosen ? "checked" : "" %>>
                                                                                <label class="form-check-label" for="<%= radioButtonId %>"><%= answer.getAnswer() %></label>
                                                                            </div>
                                                                        <%
                                                                    }
                                                                %>
                                                            </div>
                                                        </div>
                                                    </li>
                                                <%
                                            }
                                        %>
                                    </ol>
                                    <button class="btn btn-primary mt-3 float-end" type="submit">
                                        <div class="d-flex justify-content-center flex-row">
                                            <i class="fa-solid fa-wine-glass text-danger fa-2x me-2"></i> 
                                            <span>Επικαιροποίηση</span>
                                        </div>
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
            </div>
        
        <jsp:include page="../fragments/scripts.jsp" />
        <script type="module" src="<%=request.getContextPath()%>/static/js/profile.js"></script>
    </body>
</html>