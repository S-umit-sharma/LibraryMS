<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <style>
    #abbr {
      text-decoration: none;
      border: none;
    }

    #con {
      background-color: rgb(255, 255, 255);
    }

    #category-select {
      padding: 8px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 5px;
      background-color: #f9f9f9;
      color: #333;
      appearance: none;
      /* Remove default arrow icon in some browsers */
      -webkit-appearance: none;
      /* Remove default arrow icon in Safari */
      -moz-appearance: none;
      /* Remove default arrow icon in Firefox */
    }

    #category-select:hover,
    #category-select:focus {
      border-color: #66afe9;
      /* Change border color on hover and focus */
    }

    /* Custom arrow icon for select */
    #category-select::after {
      content: '\25BC';
      /* Unicode for down arrow */
      position: absolute;
      top: 12px;
      right: 10px;
      font-size: 14px;
      pointer-events: none;
      /* Ensure arrow does not interfere with select click */
      color: #666;
    }

    /* Style options within the select */
    #category-select option {
      background-color: #fff;
      color: #333;
    }

    /* Hover effect on options */
    #category-select option:hover {
      background-color: #f0f0f0;
    }
  </style>


  <nav class="navbar  navbar-expand-lg bg-body-lg ">
    <div class="container-fluid" style="background-color: rgb(232, 238, 234);" id="con">
      <a class="navbar-brand" href="#"><abbr title="Library Management System" id="abbr"><a href="index.jsp"
            class="text-decoration-none fs-5 text-dark margin-auto"><strong>LMS</strong></a></abbr></a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="#">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#">Books</a>
          </li>
          <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
              Dropdown
            </a>
            <ul class="dropdown-menu">
              <li><a class="dropdown-item" href="#">Action</a></li>
              <li><a class="dropdown-item" href="#">Another action</a></li>
              <li>
                <hr class="dropdown-divider">
              </li>
              <li><a class="dropdown-item" href="#">Something else here</a></li>
            </ul>
          </li>
          <li class="nav-item">
            <a class="nav-link" aria-disabled="true">About</a>
          </li>
        </ul>

        <!-- -------------------------------- -->
        <div class="btn-group">
          <button type="button" class="btn-secondary dropdown-toggle" data-bs-toggle="dropdown"
            aria-expanded="false"></button>
          <ul class="dropdown-menu dropdown-menu-end">
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