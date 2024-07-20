<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Library DashBoard</title>
        <style>
            #abbr {
                text-decoration: none;
                border: none;
            }

            #con {
                background-color: rgb(255, 255, 255);
            }

            #input_btn {
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

            #input_btn:hover,
            #input_btn:focus {
                border-color: #66afe9;
                /* Change border color on hover and focus */
            }

            /* Custom arrow icon for select */
            #input_btn::after {
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
            #input_btn option {
                background-color: #fff;
                color: #333;
            }

            /* Hover effect on options */
            #input_btn option:hover {
                background-color: #f0f0f0;
            }
        </style>
    </head>

    <body>
        <!-- --------------------------------------------------------------- -->
        <div class="container">
            <div class="row">
                <div class="col">
                    <%@ include file="Navbar.jsp" %>
                </div>
            </div>
            <div class="container">
              
                <div role="tabpanel">
                    <!-- List group -->
                    <div class="list-group" id="myList" role="tablist">
                        <div class="row">
                            <div class="col-md-1">
                                <a class="list-group-item list-group-item-action active" data-bs-toggle="list"
                                    href="#home" role="tab">Home</a>
                            </div>
                            <div class="col-md-1">
                                <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#Books"
                                    role="tab">Books</a>

                            </div>
                            <div class="col-md-1">

                                <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#Candidates"
                                    role="tab">Candidates</a>
                            </div>
                            <div class="col-md-1">
                                <a class="list-group-item list-group-item-action" data-bs-toggle="list" href="#librarian"
                                    role="tab">librarian</a>
                            </div>
                        </div>

                    </div>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" id="home" role="tabpanel">
                            <div class="row">
                                <!-- ---------------------------------------- -->
                                <div class="col-md mt-3 text-end" id="my_div">
                                    <form action="search_title.do">
                                        <input type="text" name="title" id="input_btn">
                                        <input type="submit" class="btn btn-outline-success" value="Search">
                                    </form>
                                </div>
                                <!-- ---------------------------------------- -->
            
                            </div>

                            ##################${books}
                            <div class="row">
                                <c:forEach var="book" items="${books}" varStatus="n">
                                    <c:if test="${(n.count-1)%4==0}">
                                        <div class="row justify-content-around mt-3">
                                    </c:if>
                                    <div class="col-md">
                                        <div class="card shadow p-3 mb-5 bg-body-tertiary rounded" style="width:15rem;">
                                            <img src="show_book_img.do?book_id=${book.bookId}&img_path=${book.bookPic}">

                                            <div class="card-body">
                                                <h3 class="card-title">${book.title}</h3>
                                            </div>
                                            <div class="card-footer">
                                                <a href="book_edition.do?book_id=${book.bookId}&num=2"
                                                    class="btn btn-primary" style="text-decoration:none;">Editions</a>
                                            </div>
                                        </div>
                                        <c:if test="${n.count%4==0}">
                                    </div>
                                    </c:if>

                            </div>
                            </c:forEach>
                        </div>
                        <div class="tab-pane" id="books" role="tabpanel">
                            <div class="row">
                                <c:forEach var="book" items="${Library_books}" varStatus="n">

                                    <c:if test="${(n.count-1)%4==0}">
                                        <div class="row justify-content-around mt-3">
                                    </c:if>
                                    <div class="col-md">
                                        <div class="card shadow p-3 mb-5 bg-body-tertiary rounded" style="width:15rem;">
                                            <img src="show_book_img.do?book_id=${book.bookId}&img_path=${book.bookPic}">

                                            <div class="card-body">
                                                <h3 class="card-title">${book.title}</h3>
                                            </div>
                                            <div class="card-footer">
                                                <a href="book_edition.do?book_id=${book.bookId}&num=2"
                                                    class="btn btn-primary" style="text-decoration:none;">Editions</a>
                                            </div>
                                        </div>
                                        <c:if test="${n.count%4==0}">
                                    </div>
                                    </c:if>

                            </div>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="tab-pane" id="messages" role="tabpanel">...</div>
                    <div class="tab-pane" id="settings" role="tabpanel">...</div>
                </div>
            </div>
        </div>
        </div>
    </body>

    </html>