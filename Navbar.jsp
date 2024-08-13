<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>



  <nav class="navbar  navbar-expand-lg bg-body-lg my-1">
    <div class="container-fluid" style="background-color: rgb(36, 35, 35);" id="con">
      <abbr title="Library Management System" id="abbr"><a href="index.jsp" class="navbar-brand"
          class="text-decoration-none fs-5 margin-auto" style="color:white"><strong>LMS</strong></a></abbr>
          
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li><img src="" alt=""></li>
        </ul>

        <!-- -------------------------------- -->
        <div class="btn-group">
          <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown"></button>
          <ul class="dropdown-menu dropdown-menu-end">
            <li>------------------</li>
            <c:choose>
              <c:when test="${empty user}">
                <li class="dropdown-item" type="button"><a href="index.jsp" class="btn btn-primary">SignIn</a></li>
                <li class="dropdown-item" type="button"><a href="index.jsp" class="btn btn-primary">SignUp</a></li>
              </c:when>
              <c:otherwise>
                <li class="p-2"><span>${user.email}</span></li>
                <li class="text-center mt-4 ">
                  <c:choose>
                    <c:when test="${empty user.profilePic}">
                      <img src="static/media/images/profile.jpg" style="width:100px">
                    </c:when>
                    <c:otherwise>
                      <img src="logo.do?path=${user.profilePic}" width="100px">

                    </c:otherwise>
                  </c:choose>
                </li>
                <li class="text-center"><span
                    class="fs-1 py-1 fw-semibold bg-light px-3 d-inline-block">${user.name}</span></li>
                <li class="text-center">
                  <a href="logout.do" class="btn btn-outline-danger">Logout</a>
                </li>
              </c:otherwise>
            </c:choose>
            <li class="dropdown-item" type="button"></li>
          </ul>
        </div>
      </div>
    </div>
  </nav>