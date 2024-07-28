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
        <style>
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }

                to {
                    opacity: 1;
                }
            }

            @keyframes slideIn {
                from {
                    transform: translateY(-20px);
                    opacity: 0;
                }

                to {
                    transform: translateY(0);
                    opacity: 1;
                }
            }

            #lib_name {
                animation: fadeIn 1s ease-in-out;
            }

            #user_img {
                animation: slideIn 1s ease-in-out;
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
                        <button type="button" class="btn btn-danger" id="delete_ok_btn">OK</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal"
                            id="modal_close">Close</button>
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
            <div class="row" style="background-color: #ccc;">
                <div class="col-md">
                    <img src="logo.do?path=${user.profilePic}" width="80" class="border border-rounded mb-2"
                        id="user_img">
                </div>
                <div class="col-md text-center fs-1" id="lib_name">
                    <Strong>${user.name}</Strong>
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
                        <div class="col-md">
                            <input type="text" name="title" class="form-control mt-2"
                                placeholder="Search New books by title..." id="title_value">
                        </div>
                        <div class="col-md">
                            <button type="button" class="btn btn-outline-success mt-2"
                                id="search_title_btn">Search</button>
                        </div>


                        <div class="row mt-4">
                            <div class="row">
                                <div class="col-md">
                                    <img id="book_img" width="180">
                                </div>
                                <div class="col-md">
                                    <h3>Title:<h1 id="title"></h1>
                                    </h3>
                                </div>
                            </div>

                            <div class="row mt-4">
                                <div class="col-md">
                                    <a href="" id="all_editions">
                                        <button type="button" class="btn btn-primary" style="display: none;"
                                            id="edition_btn">Editions</button>
                                    </a>
                                </div>
                            </div>

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
                            <input type="hidden" name="book_issued" id="book_issued">

                            <div class="form-group">
                                <div class="row mt-4">
                                    <div class="col-md">
                                        <input type="text" class="form-control" id="Member"
                                            placeholder="enter the member ID" name="membership_id" required>
                                    </div>
                                    <div class="col-md mt-2">
                                        <button class="btn btn-primary" id="find_img">Find</button>
                                    </div>
                                </div>
                                <div class="row mt-4">
                                    <div class="col-md-3 text-center">
                                        <img src="static/media/images/student.gif" width="140" id="member_photo"
                                            class="shadow p-3 bg-body-tertiary rounded">
                                    </div>
                                    <div class="col-md ">
                                        Name:<h5 id="member_name"></h5>
                                    </div>
                                </div>
                            </div>
                            <div class="form-button">
                                <button type="submit" class="btn btn-primary" id="issue_btn">Issue Book</button>
                                <button type="submit" class="btn btn-primary" id="return_btn">return Book</button>
                            </div>
                        </div>
                        <div class="row mt-4">
                            <div class="col-12">
                                <table border="1px solid red" width="100%" style="border: 1px solid red;">
                                    <thead style="border:1px solid rgb(161, 150, 150);">
                                        <tr>
                                            <th colspan="1">Sr No.</th>
                                            <th colspan="1">Stuent Name</th>
                                            <th colspan="1">Book Name</th>
                                            <th colspan="1">Issue Date</th>
                                            <th colspan="1">Return Date</th>
                                            <th colspan="">Member Id</th>
                                        </tr>
                                    </thead>

                                    <tbody id="history_table">

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- ============================================================================================================ -->
                <div class="tab-pane fade" id="add_candidate">
                    <div class="row justify-content-around">
                        <div class="col-md text-center">
                            <h3>ADD new Member</h3>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="row mt-4">
                                <div class="col-md">
                                    <input type="text" id="email_input" name="member_email" class="form-control"
                                        placeholder="enter the email to search member....">
                                </div>
                                <div class="col-md">
                                    <button type="button" class="btn btn-primary" id="email_search_btn">Search</button>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col-md">
                                    <input type="hidden" class="form-control" placeholder="enter" id="user_id"
                                        name="user_id">

                                    <input type="text" class="form-control" placeholder="name of the member is........"
                                        id="input_name" name="name" readonly>
                                </div>
                                <div class="col-md">
                                    <button type="button" class="btn btn-primary" id="add_candidate_btn">&plus;
                                        Add</button>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col">
                                    <input type="number" placeholder="enter the member ID........"
                                        search="enter the member Id" name="delete_member" id="delete_member_input"
                                        class="form-control">
                                </div>
                                <div class="col">
                                    <button type="button" class="btn btn-danger" id="delete_member_btn">Remove</button>
                                </div>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <div class="col">
                                    <div class="alert alert-danger" id="not_registered_msg" style="display:none;">
                                        Not Registered</div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md">
                                    <div class="alert alert-success"
                                        style="display: none;font-family: Georgia, 'Times New Roman', Times, serif;"
                                        id="candidate_success_msg">
                                    </div>

                                    <div class="alert alert-success"
                                        style="display: none;font-family: Georgia, 'Times New Roman', Times, serif;"
                                        id="member_id_msg">Your Member ID is&nbsp;<span id="member_id"></span>
                                    </div>
                                    <div class="alert alert-success"
                                        style="display: none;font-family: Georgia, 'Times New Roman', Times, serif;"
                                        id="member_removed_success">Member Removed SuccessFully
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md">
                                    <img id="img_show" src="static/media/images/student.gif" width="180">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col">
                            <table border="1px solid red" width="100%" style="border: 1px solid red;">
                                <thead style="border:1px solid rgb(161, 150, 150);">
                                    <tr>
                                        <th colspan="1">Sr No.</th>
                                        <th colspan="1">Joined On</th>
                                        <th colspan="1">Dues</th>
                                        <th colspan="1">Member ID</th>
                                        <th colspan="1">Name</th>
                                        <th colspan="">contact</th>
                                        <th colspan="2">left On</th>
                                    </tr>
                                </thead>

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


        </div>

        </div>

        <script>
            let search_title_btn = document.querySelector("#search_title_btn");
            let title_value = document.querySelector("#title_value");
            let book_img = document.querySelector('#book_img');
            let title = document.querySelector("#title");
            let published_on = document.querySelector("#published_on");
            let price = document.querySelector("#price");
            let all_editions = document.querySelector("#all_editions");
            let edition_btn = document.querySelector("#edition_btn");

            search_title_btn.addEventListener('click', () => {

                let req = new XMLHttpRequest();

                let param = 'title=' + title_value.value;

                req.open('GET', 'search_title.do?' + param, true);

                req.addEventListener('readystatechange', () => {
                    if (req.readyState == 4 && req.status == 200) {
                        let arr = JSON.parse(req.responseText);

                        for (let obj of arr) {
                            for (let prop in obj) {
                                book_img.src = 'show_book_img.do?img_path=' + obj.bookPic;
                                title.innerText = obj.title;
                                all_editions.href = 'book_edition.do?book_id=' + obj.bookId + '&num=2&title=' + obj.title;
                                edition_btn.style.display = 'block';
                            }
                        }
                    }
                });
                req.send();
            });
        </script>

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
            let book_issued = document.querySelector("#book_issued");


            search_isbn.addEventListener('click', () => {
                let req = new XMLHttpRequest();


                let param = 'isbn_no=' + isbn_no.value;


                req.open('GET', 'search_isbn_no.do?' + param, true);

                req.addEventListener('readystatechange', () => {

                    if (req.readyState == 4 && req.status == 200) {
                        card_div.style.display = 'block';
                        let arr = JSON.parse(req.responseText);

                        for (let obj in arr) {
                            h1.innerText = arr.bookEdition.book.title;
                            img_path.src = 'show_edition_img.do?path=' + arr.bookEdition.bookEditionPic;
                            edition.innerText = arr.bookEdition.edition;
                            details.innerText = arr.bookEdition.details;
                            copies.innerText = arr.copies;
                            input_edition.value = arr.bookEdition.bookEditionId;
                            library_book_id.value = arr.libraryBookId;
                            book_issued.value = arr.bookIssued;

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

                let param = "edition_id=" + input_edition.value + "&member_id=" + member.value + "&library_book_id=" + library_book_id.value + "&book_issued=" + book_issued.value;

                req.open('GET', 'issue_book.do?' + param, true);

                req.addEventListener('readystatechange', () => {
                    if (req.readyState == 4 && req.status == 200) {

                        let json = JSON.parse(req.responseText);

                        if (json == true) {
                            card_div.style.display = 'none';
                            isbn_no.value = isbn_no.defaultValue;
                            member.value = member.defaultValue;
                            success_msg.innerText = 'Book Issued Success Fully';
                            success_msg.style.display = 'block';

                            setTimeout(function () {
                                success_msg.style.display = 'none';
                            }, 3000);
                        }

                        book_issued_history();
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
                            console.log(arr);
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

                img_show.src = "static/media/images/student.gif";

                let req = new XMLHttpRequest();

                let param = "user_id=" + user_id.value;

                req.open('GET', 'add_candidate.do?' + param, true);

                req.addEventListener('readystatechange', () => {

                    if (req.readyState == 4 && req.status == 200) {
                        let json = JSON.parse(req.responseText);
                        console.log(json.member);
                        if(json.flag){
                            candidate_success_msg.innerText = 'Candidate Become a Member';
                            candidate_success_msg.style.display = 'block';
                            input_name.value = input_name.defaultValue;
                            setTimeout(() => {
                                candidate_success_msg.style.display = 'none';
                                member_id.innerText = json.member.memberId;
                                member_id_msg.style.display = 'block';
                                setTimeout(() => {
                                    member_id_msg.style.display = 'none';
                                }, 10000);
                                
                            }, 3000);
                            show_candidate();
                        }else{
                            candidate_success_msg.innerHTML = "Candiate already is a Library member Member ID : <h1>"+json.member.memberId+"</h1>";
                            candidate_success_msg.style.display = 'block';
                            setTimeout(() => {
                                candidate_success_msg.style.display = 'none';
                            },10000);
                            
                            show_candidate();

                        }


                    }
                });

                req.send();
            })
        </script>
        <script>
            let delete_member_input = document.querySelector("#delete_member_input");
            let delete_member_btn = document.querySelector("#delete_member_btn");
            let delete_modal = document.querySelector("#delete_modal");
            let modal_close = document.querySelector("#modal_close");
            let delete_ok = document.querySelector("#delete_ok");
            let member_removed_success = document.querySelector("#member_removed_success");

            delete_member_btn.addEventListener('click', () => {
                delete_modal.style.display = 'block';
                img_show.src = 'static/media/images/student.gif';
                input_name.value = input_name.defaultValue;
                email_input.value = email_input.defaultValue;

            });
            modal_close.addEventListener('click', () => {
                delete_modal.style.display = 'none';
            });

            delete_ok_btn.addEventListener('click', () => {
                delete_member_input.value = delete_member_input.defaultValue;
                let req = new XMLHttpRequest();

                let param = '?member_id=' + delete_member_input.value;

                req.open('GET', 'remove_member.do' + param, true);

                req.addEventListener('readystatechange', () => {
                    let json = JSON.parse(req.responseText);
                    delete_modal.style.display = 'none';
                    member_removed_success.style.display = 'block';
                    if (json == 0) {
                        member_removed_success.innerText = 'Member Removed SuccessFully';
                        setTimeout(() => {
                            member_removed_success.style.display = 'none';
                        }, 5000);
                    } else {
                        member_removed_success.innerHTML = '<strong>Member Have<h3>' + json + '</h3>books</strong>';
                        setTimeout(() => {
                            member_removed_success.style.display = 'none';
                        }, 10000);

                    }
                });

                req.send();
            });



        </script>
        <script>
            let show_member = document.querySelector("#show_member");
            let table = document.querySelector("#table");

            let show_candidate = function () {
                let req = new XMLHttpRequest();

                req.open('GET', 'collect_all_member.do', true);
                req.addEventListener('readystatechange', () => {
                    if (req.readyState == 4 && req.status == 200) {
                        let arr = JSON.parse(req.responseText);
                        let i = 0;

                        table.innerHTML = '';
                        for (let obj of arr) {

                            let row = table.insertRow(i++);
                            let j = 0;
                            row.innerText = i;
                            for (let prop in obj) {
                                let cell = row.insertCell(j++);
                                cell.innerText = obj[prop];
                                if (prop == 'city' || prop == 'email' || prop == 'profilePic' || prop == 'address') {
                                    cell.style.display = 'none';
                                }
                            }
                        }
                    }
                });

                req.send();
            };
        </script>
        <script>
            let find_img = document.querySelector("#find_img");
            let member_photo = document.querySelector('#member_photo');
            let member_name = document.querySelector('#member_name');

            find_img.addEventListener('click', () => {
                let req = new XMLHttpRequest();

                let param = 'member_id=' + member.value;

                req.open('GET', 'member_photo_find.do?' + param, true);

                req.addEventListener('readystatechange', () => {
                    if (req.readyState == 4 && req.status == 200) {
                        let obj = JSON.parse(req.responseText);
                        member_photo.src = "logo.do?path=" + obj.profilePic;
                        member_name.innerText = obj.name;
                    }
                });
                req.send();
            });

            issue_btn.addEventListener('click', () => {
                member_photo.src = "static/media/images/student.gif";
                member_name.innerText = ' ';
            });



        </script>
        <script>
            let return_btn = document.querySelector('#return_btn');

            return_btn.addEventListener('click', () => {
                let req = new XMLHttpRequest();

                let param = 'member_id=' + member.value + "&book_edition_id=" + input_edition.value + "&book_issued=" + book_issued.value;

                console.log(param);
                req.open('GET', 'return_book.do?' + param, true);

                req.addEventListener('readystatechange', () => {
                    if (req.readystate == 4 && req.status == 200) {

                        console.log(req.responseText);


                    }
                });

                req.send();
            });

            return_btn.addEventListener('click', () => {
                member.value = member.defaultValue;
                member_photo.src = "static/media/images/student.gif";
                member_name.innerText = '';
                card_div.style.display = 'none';
                isbn_no.value = isbn_no.defaultValue;
                success_msg.innerText = 'Book Returned SuccessFully';
                success_msg.style.display = 'block';
                setTimeout(function () {
                    success_msg.style.display = 'none';
                }, 3000);
            });
        </script>
        <script>
            let history_table = document.querySelector("#history_table");

            let book_issued_history = function () {
                let req = new XMLHttpRequest();

                req.open('GET', 'history_of_issued_books.do', true);

                req.addEventListener('readystatechnage', () => {
                    if (req.readyState == 4 && req.status == 200) {
                        console.log(req.responseText);
                    }
                });
            }
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>

    </html>