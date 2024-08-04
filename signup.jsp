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

      .err_msg {
        color: red;
        display: none;
        font-size: 12px;
      }

      .server_err {
        color: red;
        font-size: 12px;
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
            <div class="row">
              <div class="col">
                <div class="mb-3">
                  <label for="name" class="form-label">Name</label>
                  <input type="text" class="form-control" id="name" name="name">
                  <small class="err_msg" id="err_name_msg">enter a valid name...</small>
                  <c:if test="${!empty name}">
                    <small class="server_err" id="err_name_msg">enter a valid name...</small>
                  </c:if>

                </div>
              </div>
            </div>
            <div class="row">
              <div class="col">
                <div class="mb-3">
                  <label for="email" class="form-label">Email</label>
                  <input type="email" class="form-control" id="email" name="email">
                  <small class="err_msg" id="err_email_msg">enter a valid email...</small>
                  <c:if test="${!empty email}">
                    <small class="server_err" id="err_email_msg">enter a valid email...</small>
                  </c:if>
                </div>
              </div>
            </div>


            <div class="row">
              <label for="password" class="form-label">Password</label>
              <div class="col-md">
                <div class="mb-3">
                  <input type="password" class="form-control" id="password" name="password">
                </div>
              </div>
              <div class="col-md-1">
                <img src="static/media/images/open.png" width="25px" align="bottom" id="eye"><br>
              </div>
              <small class="err_msg" id="err_password_msg">enter a valid password...</small>
              <c:if test="${!empty password}">
                <small class="server_err" id="err_password_msg">enter a valid password...</small>
              </c:if>
            </div>

            <div class="row">
              <div class="col">
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
              </div>
            </div>

            <div class="row">

              <div class="col-md mb-3">
                <label for="city" class="form-label">City</label>
                <input list="cities" class="form-control" id="city" name="city">
                <datalist id="cities">
                  <c:forEach var="ct" items="${cities}">
                    <option value="${ct.city}(${ct.state.state})"></option>
                  </c:forEach>
                </datalist>
              </div>

              <div class="col-md mb-3">
                <label for="contact" class="form-label">Contact</label>
                <input type="number" class="form-control" id="contact" name="contact" placeholder="Mobile">
                <small class="err_msg" id="err_contact_msg">enter a valid phone number...</small>
                <c:if test="${!empty contact}">
                  <small class="server_err" id="err_contact_msg">enter a valid phone number...</small>
                </c:if>
              </div>
            </div>
            <div class="row">
              <div class="col">
                <div class="mb-3">
                  <label for="address" class="form-label">Address</label>
                  <input type="text" class="form-control" id="address" name="address" placeholder="Street, Landmark">
                  <small class="err_msg" id="err_address_msg">enter a valid address...</small>
                  <c:if test="${!empty address}">
                    <small class="server_err" id="err_address_msg">enter a valid address...</small>
                  </c:if>
                </div>
              </div>
            </div>


            <div class="row justify-content-around">
              <div class="col-md">
                <label class="form-label">Gender:</label>
              </div>
              <div class="col-md">
                <div class="col-2 form-check">
                  <input class="form-check-input" type="radio" name="gender" id="male" value="1">
                  <label class="form-check-label" for="male">Male</label>
                </div>
              </div>
              <div class="col-md">
                <div class="col-2 form-check">
                  <input class="form-check-input" type="radio" name="gender" id="female" value="2">
                  <label class="form-check-label" for="female">Female</label>
                </div>
              </div>
              <div class="col-md">
                <div class="col-2 form-check">
                  <input class="form-check-input" type="radio" name="gender" id="other" value="3">
                  <label class="form-check-label" for="other">Others</label>
                </div>
              </div>

            </div>

            <div class="row mt-3">
              <div class="col text-center">
                <input type="submit" class="btn btn-primary" value="Sign Up">
              </div>
            </div>

          </form>
        </div>
      </div>
    </div>
  </body>
  <script>

    let form = document.forms[0];

    let name = document.querySelector('#name');
    let email = document.querySelector('#email');
    let password = document.querySelector('#password');
    let contact = document.querySelector('#contact');
    // let address = document.querySelector('#address');

    let err_name_msg = document.querySelector('#err_name_msg');
    let err_email_msg = document.querySelector('#err_email_msg');
    let err_password_msg = document.querySelector('#err_password_msg');
    let err_contact_msg = document.querySelector('#err_contact_msg');
    // let err_address_msg = document.querySelector('#err_address_msg');

    let namePattern = new RegExp(/^[A-Za-z0-9 ]{8,15}$/);
    let emailPattern = new RegExp(/^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$/);
    let passwordPattern = new RegExp(/^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*_])[0-9A-Za-z!@#$%^&*_]{8,16}$/);
    let contactPattern = new RegExp(/^[6-9][0-9]{9}$/);
    // let addressPattern = new RegExp(/^[a-zA-Z0-9-, ]$/);

    name.addEventListener('focus', () => {
      err_name_msg.style.display = 'none';
    });
    email.addEventListener('focus', () => {
      err_email_msg.style.display = 'none';
    });
    password.addEventListener('focus', () => {
      err_password_msg.style.display = 'none';
    });
    contact.addEventListener('focus', () => {
      err_contact_msg.style.display = 'none';
    });
    // address.addEventListener('focus', () => {
    //   err_address_msg.style.display = 'none';
    // });

    name.addEventListener('blur', () => {
      if (!namePattern.test(name.value)) {
        err_name_msg.style.display = 'inline';
        flag = false;
      }
    });
    email.addEventListener('blur', () => {

      if (!emailPattern.test(email.value)) {
        err_email_msg.style.display = 'inline';
        flag = false;
      }

    });
    // address.addEventListener('blur', () => {
    //   if (!addressPattern.test(address.value)) {
    //     err_address_msg.style.display = 'block';
    //     flag = false;
    //   }
    // });
    password.addEventListener('blur', () => {
      if (!passwordPattern.test(password.value)) {
        err_password_msg.style.display = 'inline';
        flag = false;
      }
    });
    contact.addEventListener('blur', () => {

      if (!contactPattern.test(contact.value)) {
        err_contact_msg.style.display = 'inline';
        flag = false;
      }
    });

    form.addEventListener('submit', (e) => {

      e.preventDefault();

      let flag = true;

      if (!namePattern.test(name.value)) {
        err_name_msg.style.display = 'inline';
        flag = false;
      }
      if (!emailPattern.test(email.value)) {
        err_email_msg.style.display = 'inline';
        flag = false;
      }
      if (!passwordPattern.test(password.value)) {
        err_password_msg.style.display = 'inline';
        flag = false;
      }
      if (!contactPattern.test(contact.value)) {
        err_contact_msg.style.display = 'inline';
        flag = false;
      }
      // if (!addressPattern.test(address.value)) {
      //   err_address_msg.style.display = 'inline';
      //   flag = false;
      // }

      if (flag) {
        form.submit();
      }


    });

    let eye = document.querySelector('#eye');

    let flag = true;

    eye.addEventListener('click', () => {
      if (flag) {
        eye.src = 'static/media/images/open.png';
        password.type = 'text';
        flag = false;
      } else {
        password.type = 'password';
        eye.src = 'static/media/images/close.png';
        flag = true;
      }
    });

  </script>

  </html>