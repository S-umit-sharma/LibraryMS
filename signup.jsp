<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LMS SignUp Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
      /* Custom styles */
      .container {
        margin-top: 50px;
      }

      .form-label {
        font-size: large;
        font-weight: 500;
      }

      #form {
        background-color: rgb(203, 238, 241);
        padding: 20px;
        border-radius: 10px;

      }

      #form label {
        color: rgb(0, 0, 0);
      }

      #form input[type="text"],
      #form input[type="email"],
      #form input[type="password"],
      #form input[type="number"],
      #form input[type="date"] {
        margin-bottom: 10px;
      }

      #form button[type="submit"] {
        margin-top: 20px;
      }
    </style>
  </head>

  <body>
    <div class="container">
      <div class="row">
        <div class="col">
          <%@ include file="Navbar.jsp" %>
        </div>
      </div>

      <div class="row">
        <div class="row">

          <div class="col">
            <header class="text-center">
              <h1 class="fw-4">SignUp Page</h1>
            </header>
          </div>
        </div>
        <div class="col-md-6 m-auto shadow-lg p-3 bg-body-tertiary rounded">
          <form action="signup.do" method="post" id="form">
            <input type="hidden" name="user_type_id" value="${param.user_type_id}">

            <div class="mb-3">
              <label for="name" class="form-label">Name</label>
              <input type="text" class="form-control" id="name" name="name">
            </div>

            <div class="mb-3">
              <label for="email" class="form-label">Email</label>
              <input type="email" class="form-control" id="email" name="email">
            </div>

            <div class="mb-3">
              <label for="password" class="form-label">Password</label>
              <input type="password" class="form-control" id="password" name="password">
            </div>

            <div class="mb-3">
              <c:choose>
                <c:when test="${param.user_type_id==1 || param.user_type_id==2}">
                  <label for="dob" class="form-label">Registration Date:</label>
                  <input type="date" class="form-control" id="dob" name="dob">
                </c:when>

                <c:otherwise>
                  <label for="dob" class="form-label">Date of Birth</label>
                  <input type="date" class="form-control" id="dob" name="dob">
                </c:otherwise>

              </c:choose>
            </div>
            <div class="row">

              <div class="col mb-3">
                <label for="city" class="form-label">City</label>
                <input list="cities" class="form-control" id="city" name="city">
                <datalist id="cities">
                  <c:forEach var="ct" items="${cities}">
                    <option value="${ct.city}(${ct.state.state})"></option>
                  </c:forEach>
                </datalist>
              </div>

              <div class="col mb-3">
                <label for="contact" class="form-label">Contact</label>
                <input type="number" class="form-control" id="contact" name="contact" placeholder="Mobile">
              </div>
            </div>

            <div class="mb-3">
              <label for="address" class="form-label">Address</label>
              <input type="text" class="form-control" id="address" name="address" placeholder="Street, Landmark">
            </div>

            <div class="row mb-2">
              <label class="form-label">Gender</label>
              <div class="col-2 form-check">
                <input class="form-check-input" type="radio" name="gender" id="male" value="1">
                <label class="form-check-label" for="male">Male</label>
              </div>
              <div class="col-2 form-check">
                <input class="form-check-input" type="radio" name="gender" id="female" value="2">
                <label class="form-check-label" for="female">Female</label>
              </div>
              <div class="col-2 form-check">
                <input class="form-check-input" type="radio" name="gender" id="other" value="3">
                <label class="form-check-label" for="other">Others</label>
              </div>
            </div>

            <button type="submit" class="btn btn-primary">Sign Up</button>
          </form>
        </div>
      </div>
    </div>
  </body>

  </html>