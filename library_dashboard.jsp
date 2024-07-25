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
        <style>
            /* Hide the spinner arrows */
            input[type=number]::-webkit-outer-spin-button,
            input[type=number]::-webkit-inner-spin-button,
            input[type=number]::-webkit-contacts-auto-fill-button {
                -webkit-appearance: none;
                margin: 0;
                /* Optional: Adjust spacing as needed */
            }
        </style>


        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    </head>

    <body>

        <!-- ----------------------------delete member modal----------------------------------- -->
        <div class="modal" id="delete_modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1>Press ok to remove Member</h1>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger">OK</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="modal_close">Close</button>
                    </div>
                </div>
            </div>
        </div>



        <!-- ----------------------------Issue library books modal----------------------------------- -->


        <!-- --------------------------------------------------------------- -->
        <div class="container">
            <div class="row">
                <div class="col">
                    <%@ include file="Navbar.jsp" %>
                </div>
            </div>

            <ul class="nav nav-tabs">
                <li class="nav-item ">
                    <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#home">Home</button>
                </li>
                <li class="nav-item">
                    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#book_issue">Issue
                        Book</button>
                </li>
                <li class="nav-item">
                    <button class="nav-link" data-bs-toggle="tab" data-bs-target="#add_candidate">
                        Candidate</button>
                </li>
                <!-- Add more tab buttons as needed -->
            </ul>

            <!-- ============================================================================================================ -->

            <div class="tab-content">

                <!-- ============================================================================================================ -->
                <div class="tab-pane fade show active" id="home">
                    <div class="row">
                        <div class="col">
                            <form action="search_title.do">
                                <input type="text" name="title" class="form-control"
                                    placeholder="Search New books by title...">
                                <input type="submit" class="btn btn-outline-success mt-2" value="Search">
                            </form>
                        </div>
                        <div class="row">
                            <!-- ------------------------------------------------------------------ -->
                            <div class="col">
                                <!-- ------------------------------------------------------------------ -->
                                <c:forEach var="book" items="${book_by_titile}" varStatus="n">
                                    <c:if test="${(recs.count-1)%4==0}">
                                        <div class="row justify-content-around mt-1">
                                    </c:if>
                                    <div class="col-md mt-4">
                                        <a href="book_edition.do?book_id=${book.bookId}&num=2&title=${book.title}">
                                            <div class="card shadow p-3 mb-2 bg-body-tertiary rounded"
                                                id="${book.bookId}" style="width:15rem;">
                                                <c:choose>
                                                    <c:when test="${empty book.bookPic}">
                                                        <img src="static/media/images/book.png"
                                                            class="rounded-start img-fluid x">

                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="show_book_img.do?img_path=${book.bookPic}" width="100"
                                                            height="250" class="card-img-top">
                                                    </c:otherwise>
                                                </c:choose>
                                        </a>
                                        <div class="card-body">
                                            <div class="row fs-1">
                                                <span class="fs-1">
                                                    <h3 class="card-title">${book.title}</h3>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <c:if test="${(recs.count%4-1)==0}">

                                    </c:if>
                                </c:forEach>
                            </div>
                            <!-- ------------------------------------------------------------------ -->
                        </div>

                    </div>
                </div>
                <!-- ============================================================================================================ -->

                <div class="tab-pane fade" id="book_issue">
                    <div class="row">
                        <div class="col">
                            <div class="row justify-content-end">
                                <div class="col-md-auto">
                                    <input type="number" name="isbn_no" class="form-control mt-2"
                                        placeholder="Enter book isbn no......" id="isbn_no">
                                </div>
                                <div class="col-md-auto">
                                    <button type="button" class="Search btn btn-outline-success mt-2 "
                                        id="search_isbn">Search</button>
                                </div>
                            </div>
                            <div class="alert alert-success" id="success_msg" style="display: none;">
                                <p>book Issued Successfully</p>
                            </div>
                            <div class="row mt-4" id="card_div" style="display: none;">
                                <div class="col-md">
                                    <div class="card mb-3 shadow mr-3 p-1 bg-body-tertiary rounded"
                                        style="max-width: 540px;">
                                        <div class="row g-0">
                                            <div class="col-md-4">
                                                <img src="" class="img-fluid rounded-start p-1 rounded" id="img_path"
                                                    alt="Book Cover">
                                            </div>
                                            <div class="col-md">
                                                <div class="card-body">
                                                    <h5 class="card-title" id="title">Title</h5>
                                                    <p class="card-text">
                                                        <strong>Edition:</strong> <span id="edition"></span><br>
                                                        <strong>Total copies:</strong> <span id="copies"></span><br>
                                                        <strong>Available:</strong> <span id="copies_left"></span>
                                                    </p>

                                                    Details:<p class="card-text" id="details"></p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="col">

                            <input type="hidden" name="edition_id" id="input_edition">
                            <input type="hidden" name="library_book_id" id="library_book_id">

                            <div class="form-group">
                                <div class="row mt-4">
                                    <div class="col-md">
                                        <input type="text" class="form-control" id="Member"
                                            placeholder="enter the member ID" name="membership_id" required>
                                    </div>
                                    <div class="col-md ">
                                        <button class="btn btn-primary" id="find_img">Find</button>
                                    </div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col-md-3 text-center border border-primary">
                                        <img src="static/media/images/profile.jpg" width=140>
                                    </div>
                                </div>
                            </div>
                            <div class="form-button">
                                <button type="submit" class="btn btn-primary" id="issue_btn">Issue Book</button>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- ============================================================================================================ -->
                <div class="tab-pane fade" id="add_candidate">
                    <div class="row mt-3">
                        <div class="col">

                            <div class="row">
                                <div class="col-md">
                                    <input type="text" id="email_input" name="member_email" class="form-control"
                                        placeholder="enter the email....">
                                </div>
                                <div class="col-md">
                                    <button type="button" class="btn btn-primary" id="email_search_btn">Search</button>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="alert alert-danger" id="not_registered_msg" style="display:none;">Not
                                        Registered</div>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col">
                                    <img src="static/media/images/profile.jpg" id="img_show" width="321" height="409">
                                </div>
                            </div>
                        </div>
                        <div class="col-md">
                            <div class="row mt-4">
                                <div class="col-md text-center">
                                    <h3
                                        style="font-family: 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;">
                                        Member Form</h3>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md">
                                    <input type="text" class="form-control" placeholder="name of the member........" id="input_name" name="name">
                                    <input type="hidden" class="form-control" placeholder="enter" id="user_id"
                                        name="user_id">
                                </div>
                                <div class="col-md">
                                    <button type="button" class="btn btn-primary" id="add_candidate_btn">&plus;
                                        Add</button>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col">
                                    <div class="alert alert-success"
                                        style="display: none;font-family: Georgia, 'Times New Roman', Times, serif;"
                                        id="candidate_success_msg">Candidate Become a Member
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="alert alert-success"
                                        style="display: none;font-family: Georgia, 'Times New Roman', Times, serif;"
                                        id="member_id_msg">Your Member ID is&nbsp;<span id="member_id"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <input type="number" placeholder="enter the member ID........" search="enter the member Id" name="delete_member" id="delete_member" class="form-control">
                                </div>
                                <div class="col">
                                    <button type="button" class="btn btn-danger" id="delete_member_btn">delete</button>
                                </div>
                            </div>



                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md">
                            <button class="btn btn-primary" id="show_member">Show members</button>
                        </div>

                        <div class="col-12">
                            <table  border="1px solid red">
                                <thead style = "border:1px solid red;">
                                    <tr >
                                        <th colspan="1">Sr No.</th>
                                        <th colspan="2">Joined On</th>
                                        <th colspan="2">Member ID</th>
                                        <th colspan="4">Name</th>
                                        <th colspan="2">left On</th>
                                        <th colspan="3">Dues</th>
                                    </tr>
                                </thead >

                                <tbody id="table">
                                    
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>


                <!-- ============================================================================================================ -->
            </div>
            <!-- ============================================================================================================ -->


        </div>

        </div>


        <script>
            const isbn_no = document.querySelector('#isbn_no');
            const search_isbn = document.querySelector('#search_isbn');
            const h1 = document.querySelector('#title');
            const img_path = document.querySelector('#img_path');
            const card_div = document.querySelector('#card_div');
            const edition = document.querySelector('#edition');
            const details = document.querySelector('#details');
            const copies = document.querySelector('#copies');
            const input_edition = document.querySelector('#input_edition');
            const library_book_id = document.querySelector('#library_book_id');
            const copies_left = document.querySelector('#copies_left');
            let book_issued;


            search_isbn.addEventListener('click', () => {
                let req = new XMLHttpRequest();


                let param = 'isbn_no=' + isbn_no.value;


                req.open('GET', 'search_isbn_no.do?' + param, true);

                req.addEventListener('readystatechange', () => {

                    if (req.readyState == 4 && req.status == 200) {
                        card_div.style.display = 'block';
                        let arr = JSON.parse(req.responseText);
                        console.log(arr);
                        for (let obj in arr) {
                            h1.innerText = arr.bookEdition.book.title;
                            img_path.src = 'show_edition_img.do?path=' + arr.bookEdition.bookEditionPic;
                            edition.innerText = arr.bookEdition.edition;
                            details.innerText = arr.bookEdition.details;
                            copies.innerText = arr.copies;
                            input_edition.value = arr.bookEdition.bookEditionId;
                            library_book_id.value = arr.libraryBookId;
                            book_issued = arr.bookIssued;
                            if (arr.copies - arr.bookIssued > 0) {
                                copies_left.innerText = arr.copies - arr.bookIssued;
                            } else {
                                copies_left.innerText = "out of stock";
                                copies_left.style.color = 'red';
                            }

                        }
                    }

                });

                req.send();
            });


        </script>
        <script>
            const issue_btn = document.querySelector("#issue_btn");
            const member = document.querySelector("#Member");
            const success_msg = document.querySelector("#success_msg");
            const close_btn = document.querySelector("#close_btn");
            issue_btn.addEventListener('click', () => {
                let req = new XMLHttpRequest();

                let param = "edition_id=" + input_edition.value + "&member_id=" + member.value + "&library_book_id=" + library_book_id.value + "&book_issued=" + book_issued;
                console.log(param);
                req.open('GET', 'issue_book.do?' + param, true);

                req.addEventListener('readystatechange', () => {
                    if (req.readyState == 4 && req.status == 200) {
                        // console.log(req.readyState);
                        let json = JSON.parse(req.responseText);

                        if (json == true) {
                            card_div.style.display = 'none';
                            isbn_no.value = isbn_no.defaultValue;
                            member.value = member.defaultValue;
                            success_msg.style.display = 'block';

                            setTimeout(function () {
                                success_msg.style.display = 'none';
                            }, 3000);
                        }
                    }
                });

                req.send(null);
            });

        </script>
        <script>
            let email_input = document.querySelector("#email_input");
            let email_search_btn = document.querySelector("#email_search_btn");
            let img_show = document.querySelector("#img_show");
            let not_registered_msg = document.querySelector("#not_registered_msg");
            let input_name = document.querySelector("#input_name");
            let user_id = document.querySelector("#user_id");



            email_search_btn.addEventListener('click', () => {
                let req = new XMLHttpRequest();

                let param = 'email=' + email_input.value;


                req.open('GET', 'search_email.do?' + param, true);

                req.addEventListener('readystatechange', () => {

                    if (req.readyState == 4 && req.status == 200) {
                        let arr = JSON.parse(req.responseText);
                        if (arr == true) {
                            not_registered_msg.style.display = 'block';
                            setTimeout(() => {
                                not_registered_msg.style.display = 'none';
                            }, 3000);
                        } else {
                            input_name.value = arr.name;
                            user_id.value = arr.userId;
                            img_show.src = "logo.do?path=" + arr.profilePic;
                        }


                    }
                });

                req.send();
            });
        </script>
        <script>
            let add_candidate_btn = document.querySelector("#add_candidate_btn");
            let candidate_success_msg = document.querySelector("#candidate_success_msg");
            let member_id_msg = document.querySelector("#member_id_msg");
            let member_id = document.querySelector("#member_id");

            add_candidate_btn.addEventListener('click', () => {
                let req = new XMLHttpRequest();

                let param = "user_id=" + user_id.value;

                req.open('GET', 'add_candidate.do?' + param, true);

                req.addEventListener('readystatechange', () => {

                    if (req.readyState == 4 && req.status == 200) {
                        let json = JSON.parse(req.responseText);

                        candidate_success_msg.style.display = 'block';
                        input_name.value = input_name.defaultValue;
                        setTimeout(() => {
                            candidate_success_msg.style.display = 'none';
                            member_id.innerText = json.memberId; 
                            member_id_msg.style.display = 'block';
                            setTimeout( () => {
                                member_id_msg.style.display = 'none';
                            },10000);

                        }, 3000);


                    }
                });

                req.send();
            })
        </script>
        <script>
            let delete_member = document.querySelector("#delete_member");
            let delete_member_btn = document.querySelector("#delete_member_btn");
            let delete_modal = document.querySelector("#delete_modal");
            let modal_close = document.querySelector("#modal_close");

            delete_member_btn.addEventListener('click', () => {
                delete_modal.style.display = 'block';
            });
            modal_close.addEventListener('click', () => {
                delete_modal.style.display = 'none';
            });


        </script>
        <script>
            let show_member = document.querySelector("#show_member");
            let table = document.querySelector("#table");

            show_member.addEventListener('click', () => {
                let req = new XMLHttpRequest();

                req.open('GET','collect_all_member.do',true);
                req.addEventListener('readystatechange', () => {
                    if(req.readyState == 4 && req.status == 200){
                        let arr = JSON.parse(req.responseText);
                        let i = 0;
                        // console.log(arr);

                        for(let obj of arr){
                            console.log(obj);
                            let row = table.insertRow(i++);
                            let j = 0;
                            row.innerText = i;
                            for(let prop in obj){
                                let cell = row.insertCell(j++);
                                cell.innerText = obj[prop];
                            }
                        }
                    }
                });

                req.send();
            });
        </script>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>

    </html>