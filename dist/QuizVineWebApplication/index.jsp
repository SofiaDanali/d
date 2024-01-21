<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GrapeVin | Αρχική Σελίδα</title>        
        <jsp:include page="./WEB-INF/fragments/stylesheets.jsp" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/static/css/index.css">
    </head>
    <body>
        <jsp:include page="./WEB-INF/fragments/navbar.jsp" />
        <div>
            <div class="row w-100">
                <div class="col-4">
                    <img class="vh-95 wine-cover" src="<%=request.getContextPath()%>/static/images/wine_cover.jpg">
                </div>
                <div class="col-8">
                    <div class="vh-95">
                        <h1 class="mt-5 text-center">Καλώς Ήλθατε στη σελίδα μας!</h1>
                        <h3 class="mt-5">Εδώ στην GrapeVin, βρίσκουμε το κατάλληλο κρασί για εσάς!</h3>
                        <h3>Δείτε γιατί μας προτιμούν:</h3>
                        <hr>
                        <div class="card-group">
                                <div class="card text-white bg-dark me-2">
                                    <i class="card-img-top fa-solid fa-brain fa-5x m-2"></i>
                                    <div class="card-body">
                                        <h5 class="card-title text-center">Πρωτοποριακή Τεχνολογία AI</h5>
                                        <hr>
                                        <p class="card-text">Χρησιμοποιώντας την τελευταία λέξη της τεχνολογίας στην τεχνητή νοημοσύνη (GPT-3.5), δεν υπάρχει περίπτωση να μην σας ικανοποιήσουν οι προτάσεις μας.</p>
                                    </div>
                                </div>
                                <div class="card text-white bg-dark me-2">
                                    <i class="card-img-top fa-regular fa-credit-card fa-5x m-2"></i>
                                    <div class="card-body">
                                        <h5 class="card-title text-center">Καμία Πληρωμή!</h5>
                                        <hr>
                                        <p class="card-text">Σωστά διαβάσατε! Οι υπηρεσίες μας παρέχονται εντελώς δωρεάν! Είμαστε λάτρεις του κρασιού και θεωρούμε πως η απόλαυσή του ανήκει σε όλους!</p>
                                    </div>
                                </div>
                                <div class="card text-white bg-dark">
                                    <i class="card-img-top fa-solid fa-shield-halved fa-5x m-2"></i>
                                    <div class="card-body">
                                        <h5 class="card-title text-center">Ασφάλεια Προσωπικών Δεδομένων!</h5>
                                        <hr>
                                        <p class="card-text">Η σελίδα μας θα σας ζητήσει ελάχιστα προσωπικά δεδομένα, τα οποία θα χρησιμοποιήσει για να βρει το κατάλληλο κρασί για εσάς. Αυτά τα δεδομένα αποθηκεύονται σε συστήματα τελευταίας τεχνολογίας, συμβατά με τα υψηλότερα πρότυπα ασφαλείας.</p>
                                    </div>
                                </div>
                        </div>
                    </div>
                 </div>
            </div>
        </div>
        
        
        <jsp:include page="./WEB-INF/fragments/scripts.jsp" />
    </body>
</html>
