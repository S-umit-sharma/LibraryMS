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
                <div class="row">
                    <!-- ---------------------------------------- -->
                    <div class="col-md mt-3 text-end" id="my_div">
                        <select name="category_id" id="input_btn">
                            <option>Search</option>
                        </select>
                        <a class="btn btn-outline-success" id="search">Search</a>
                    </div>
                    <!-- ---------------------------------------- -->

                </div>
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
                                    <a href="book_edition.do?book_id=${book.bookId}&num=2" class="btn btn-primary"
                                        style="text-decoration:none;">Editions</a>
                                </div>
                            </div>
                            <c:if test="${n.count%4==0}">
                        </div>
                        </c:if>

                </div>
                </c:forEach>
            </div>
        </div>
    </body>

    <script>
        let select = document.querySelector("#input_btn");
        let categories = document.querySelector("#categories");
        let option = document.querySelector("#option");

        let button = true;


        select.addEventListener('click', () => {
            if (button) {
                let req = new XMLHttpRequest();
                let tag = '';
                req.open('GET', 'show_category.do', true);

                req.addEventListener('readystatechange', () => {
                    if (req.readyState == 4 && req.status == 200) {
                        let arr = JSON.parse(req.responseText);
                        for (let obj of arr) {
                            let option = document.createElement('option');
                            for (let prop in obj) {
                                option.value = obj.categoryId;
                                option.innerText = obj.name;
                                select.appendChild(option);
                            }
                        }
                    }
                });
                button = false;

                req.send(null);
            }
        });
    </script>
    <script>
        let select2 = document.querySelector("#input_btn");
        let search = document.querySelector("#search");

        let valueOfOption ;
        select2.addEventListener('change', () => {
            let selectedIndex = select2.selectedIndex;
            let selectedOption = select2.options[selectedIndex];

             valueOfOption = selectedOption.value;

            search.href = "search_category.do?category_id="+valueOfOption;
            console.log(search.href);
        });
            



    </script>

    </html>