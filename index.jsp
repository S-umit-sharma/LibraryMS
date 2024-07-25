<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>LMS</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <style>
    #abbr {
      text-decoration: none;
    }

    .img-thumbnail {
      width: 100%;
      height: auto;
    }
  </style>
  <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
  <!-- ----------------------------------NAVBAR-------------------------------------------------- -->
  <!-- ----------------------------------Log IN------------------------------ -->
  <div class="container text-center mt-4 my-4  bg-light">
    <div class="row">
      <div class="col-12">
        <%@ include file="Navbar.jsp" %>
      </div>

      <div class="col fs-1">
        <strong>LogIn/Register</strong>
      </div>
    </div>

    <!-- Modal -->
    <!-- ----------------------------------modal for form------------------------------ -->
    <div class="modal fade text-start" id="login_form_box" tabindex="-1" aria-labelledby="exampleModalLabel"
      aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-3" id="login_form_title">User Login</h1>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <form id="index_form1" >
              <input type="hidden" name="user_type_id" id="signup_input">
            </form>
            <form id="index_form2" method="post">
              <input type="hidden" name="user_type_id" id="signin_input">
            </form>
              
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-success me-auto" id="signup_btn">SignUp</button>
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <button type="button" class="btn btn-primary" id="signin_btn">SignIn</button>
          </div>
        </div>
      </div>
    </div>
    <!-- ----------------------------------modal form------------------------------ -->
    <div class="row mt-5 pt-5">    
        <div class="col-md shadow p-3 mb-5 bg-body-tretiary rounded" style="text-align: center;">
          <div class="A" id="a2" data-bs-toggle="modal" data-bs-target="#login_form_box">
            <img src="static/media/images/library2.jpg" class="mx-auto">
            <hr>
            <div>
              <h3>Library</h3>
            </div>
          </div>
        </div>
        <div class="col-md text-center shadow p-3 mb-5 bg-body-tertiary rounded">
          <div class="A" id="a3" data-bs-toggle="modal" data-bs-target="#login_form_box">
            <img src="static/media/images/publisher2.jpg" class=" mx-auto">
            <hr>
            <div>
              <h3>Publisher</h3>
            </div>
          </div>
        </div>
        <div class="col-md text-center shadow p-3 mb-5 bg-body-tertiary rounded">
          <div class="A" id="a1" data-bs-toggle="modal" data-bs-target="#login_form_box">
            <img src="static/media/images/user.jpg" class="mx-auto" >
            <hr>
            <div>
              <h3>Candidate</h3>
            </div>
          </div>
        </div>
        <div class="col-md text-center shadow p-3 mb-5 bg-body-tertiary rounded">
          <div class="A text" id="a4" data-bs-toggle="modal" data-bs-target="#login_form_box">
            <img src="static/media/images/librarian.jpg" class="mx-auto">
            <hr>
            <div>
              <h3>Librarian</h3>
            </div>
          </div>
        </div>
    </div>

    <!-- Button trigger modal -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"></script>
    <script>
      let login_form_title = document.querySelector('#login_form_title');
      let signup_btn = document.querySelector('#signup_btn');
      let signin_btn = document.querySelector('#signin_btn');
      let index_form1 = document.querySelector('#index_form1');
      let index_form2 = document.querySelector('#index_form2');
      let cards = document.querySelectorAll('.A');
      let in_input = document.querySelector("#signin_input");
      let up_input = document.querySelector("#signup_input");

      cards.forEach((card, index) => {
        card.user_type_id = index + 1;
        card.addEventListener('click', (event) => {
          let h3 = card.querySelector('h3');
          login_form_title.innerText = h3.innerText + ' Login';
          index_form1.setAttribute('action','signup.do?user_type_id=' + card.user_type_id);
          index_form2.setAttribute('action','signin.do?user_type_id=' + card.user_type_id);
          in_input.value=card.user_type_id;
          up_input.value=card.user_type_id;
          
        });
      });

      signin_btn.addEventListener('click',()=>{
          index_form2.submit();
      });
      signup_btn.addEventListener('click',()=>{
          index_form1.submit();
      });


    </script>
    </script>
</body>

</html>