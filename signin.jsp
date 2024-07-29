<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>SignIn Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
            integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            #form {
                display: inline-block;
                padding: 20px;
                margin: 10px 3px;
                border-radius: 1px solid rgb(0, 0, 0);
                background-color: rgb(242, 235, 235);
            }
        </style>
    </head>

    <body>
        <div class="container mb-4 text-center my-4" id="div1">
            <div class="row">
                <div class="col">

                    <%@ include file="Navbar.jsp" %>
                </div>
            </div>
                <div class="row d-inline-block">
                    <h2 class="fs-1 mb-4 my-4 p-2 shadow-lg p-3 m-5 bg-body-tertiary rounded"
                        style="border: 1px solid rgb(0, 0, 0);background-color: rgb(245, 247, 246);border-radius: 10px;">
                        <c:choose>
                            <c:when test="${param.user_type_id==1}">
                                Library
                            </c:when>
                            <c:when test="${param.user_type_id==2}">
                                Publisher
                            </c:when>
                            <c:when test="${param.user_type_id==3}">
                                Candidate
                            </c:when>
                            <c:otherwise>
                                Librarian
                            </c:otherwise>
                        </c:choose>Login
                    </h2>

                    <form action="signin.do" class="form-check fs-1 border border-radius shadow-lg p-3 m-5 bg-body-tertiary rounded" id="form" >
                        <input type="hidden" name="user_type_id" value="${param.user_type_id}">
                        <div class="col-md text-start">
                            <label for="iemail" class="form-label fs-5 fw-semibold text-primary">Email</label>
                            <input class="form-control" type="email" id="iemail" name="email">
                            
                            <div class="text-danger fs-5" id="err_email" style="display: none;">${err_email_message}</div>
                                
                        </div>

                        <div class="col-md text-start">
                            <label class="form-label fs-5 fw-semibold text-primary" for="ipassword">Password</label>
                            <input class="form-control fs-5" type="password" id="ipassword" name="password">
                            <c:if test="${not empty err_password_message}">
                                <div class="text-danger fs-5" id="pass_err">${err_password_message}</div>
                            </c:if>
                        </div>
                        <div class="col my-4">
                            <button class="btn btn-primary btn-lg" id="signin_btn">Login</button>
                            <a class="fs-5 mx-3  text-danger" id="forgot_password">Forgot Password</a>
                        </div>


                        <div class="col">
                            <button class="btn btn-outline-primary mx-2">SignUp</button>
                        </div>
                    </form>
                </div>

            </div>

            <script>
                const form = document.querySelector("#form");
                const signin_btn = document.querySelector("#signin_btn");

                signin_btn.addEventListener('click', () => {
                    form.submit;
                })

                let email_msg = document.querySelector('#err_email');
                let pass_msg = document.querySelector('#pass_err');

                setTimeout(function(){
                    email_msg.style.display = 'none';
                },3000);
                setTimeout(function(){
                    pass_msg.style.display ='none';

                },3000);
            </script>
            </script>
    </body>

    </html>