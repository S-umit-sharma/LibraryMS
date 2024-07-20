<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
    </head>

    <body>
        <div class="container">
            <div class="row">
                <div class="col">
                    <%@ include file="Navbar.jsp" %>
                </div>
            </div>
            <div class="row text-center">
                <div class="col-6 m-auto">
                    <h1 class="alert ${param.color} fs-3 fw-bold ">
                        ${param.message}
                    </h1>
                </div>
            </div>
            <c:if test="${param.status_id == 1}">
                <div class="row">
                    <div class="mb-4 text-center">
                        <a href="signin.do" class="btn btn-primary fs-3 ">Login</a>
                        <input type="hidden" name="user_type_id" value="${param.user_type_id}">
                    </div>
                </div>
            </c:if>

        </div>
    </body>

    </html>