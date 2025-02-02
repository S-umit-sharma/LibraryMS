<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="i" uri="http://libraryMS/EditionImage" %>
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
                #payment_offcanvas {

                    margin: auto;
                }
            </style>
            <style>
                table {
                    width: 100%;
                    border-collapse: collapse;
                }

                td {
                    padding: 10px;
                    /* Adjust padding if necessary */
                    text-align: center;
                    /* Center the image if desired */
                }

                .candidate_img {
                    position: relative;
                    overflow: hidden;
                }



                img {
                    display: block;
                    transition: transform 0.3s ease;
                    /*Smooth transition*/
                    max-width: 100%;
                    /* Ensures the image doesn't exceed its container */
                }
            </style>

            <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

        </head>

        <body onload="requests()">
            <!-- -----------------------------offcanvas for payment------------------------------------ -->

            <div class="offcanvas offcanvas-top alert alert-info w-25" data-bs-backdrop="static" tabindex="-1"
                id="payment_offcanvas" aria-labelledby="offcanvasExampleLabel">
                <div class="offcanvas-header">
                    <h5 class="offcanvas-title fs-2 mt-4 fw-bold" id="offcanvasExampleLabel">${user.name}</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"
                        id="close"></button>
                </div>
                <div class="offcanvas-body">
                    <div>
                        <div class="row">
                            <div class="col">
                                <input type="number" class="form-control fw-bold" id="payment_amount"
                                    placeholder="enter the amount...">
                            </div>
                        </div>
                        <div class="row mt-4">
                            <div class="col">
                                <button type="button" class="btn btn-outline-warning fw-bold"
                                    id="pay">&#8377;&nbsp;PAY</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

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
                <%@ include file="nameHeader.html" %>
                    <div class="row">
                        <div class="col">
                            <nav style="--bs-breadcrumb-divider:'>';" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">Home</li>
                                </ol>
                            </nav>
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
                            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#book_return">Return
                                Book</button>
                        </li>
                        <li class="nav-item">
                            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#add_candidate">
                                &plus;Candidate</button>
                        </li>
                        <li class="nav-item">
                            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#add_new_book">&plus;New
                                Books</button>
                        </li>
                        <li>
                            <button class="nav-link" data-bs-toggle="tab" data-bs-target="#requests">Requests</button>
                        </li>
                        <!-- Add more tab buttons as needed -->
                    </ul>

                    <!-- ============================================================================================================ -->


                    <div class="tab-content">
                        <!-- ============================================================================================================ -->
                        <div class="tab-pane fade  show active" id="home">
                            <div class="row mt-4">
                                <div class="col-md">
                                    <input type="text" id="library_book_title" class="form-control"
                                        placeholder="search books ........">
                                </div>
                            </div>
                            <div class="row mt-4" id="book_title_row">

                            </div>
                        </div>
                        <!-- ============================================================================================================ -->
                        <div class="tab-pane fade" id="book_issue">
                            <div class="row">
                                <div class="col">
                                    <div class="row">
                                        <div class="col-md-auto">
                                            <input type="number" name="isbn_no" class="form-control mt-2"
                                                placeholder="Enter book isbn no......" id="isbn_no">
                                        </div>
                                        <div class="col-md-auto">
                                            <button type="button" class="Search btn btn-outline-success mt-2 "
                                                id="search_isbn">Search</button>
                                        </div>
                                    </div>
                                    <div class="alert alert-success mt-4" id="success_msg" style="display: none;">

                                    </div>
                                    <div class="row mt-4" id="card_div" style="display: none;">
                                        <div class="col-md">
                                            <div class="card mb-3 shadow mr-3 p-1 bg-body-tertiary rounded"
                                                style="max-width: 540px;">
                                                <div class="row g-0">
                                                    <div class="col-md-4">
                                                        <img src="" class="img-fluid rounded-start p-1 rounded"
                                                            id="img_path" alt="Book Cover">
                                                    </div>
                                                    <div class="col-md">
                                                        <div class="card-body">
                                                            <h5 class="card-title" id="title">Title</h5>
                                                            <p class="card-text">
                                                                <strong>Edition:</strong> <span id="edition"></span><br>
                                                                <strong>Total copies:</strong> <span
                                                                    id="copies"></span><br>
                                                                <strong>Available:</strong> <span
                                                                    id="copies_left"></span>
                                                            </p>

                                                            Details:<p class="card-text" id="details"></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="col" id="student_col">

                                    <input type="hidden" name="edition_id" id="input_edition">
                                    <input type="hidden" name="library_book_id" id="library_book_id">
                                    <input type="hidden" name="book_issued" id="book_issued">

                                    <div class="form-group" id="find_div" style="display:none;">
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
                                            <div class="col-md-3 text-center">
                                                <img src="static/media/images/profile.jpg" width="140" id="member_photo"
                                                    class="shadow p-3 bg-body-tertiary rounded">
                                            </div>
                                            <div class="col-md ">
                                                <div class="row">
                                                    <div class="col-md">
                                                        Name:<h5 id="member_name"></h5>
                                                    </div>
                                                    <div class="col-md">
                                                        <div class="row">
                                                            <div class="col">
                                                                current Dues: <h3 id="current_dues"></h3>
                                                            </div>
                                                            <div class="col-md">
                                                                <span class="btn btn-info" style="display: none;"
                                                                    id="pay_btn" data-bs-toggle="offcanvas"
                                                                    data-bs-target="#payment_offcanvas">Pay</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-button" style="display:none;" id="issue_btn">
                                        <button type="submit" class="btn btn-primary" id="issue_btn">Issue Book</button>
                                    </div>
                                    <div class="row mt-4">
                                        <div class="col-md">
                                            <span id="msg_for_dues"></span>
                                        </div>

                                    </div>
                                </div>
                            </div>

                        </div>
                        <!-- ============================================================================================================ -->
                        <div class="tab-pane fade" id="book_return">
                            <div class="row">
                                <div class="col">
                                    <div class="row">
                                        <!-- --------------------------------------------------------------- -->
                                        <div class="row mt-4">
                                            <div class="col-md">
                                                <input type="text" class="form-control" id="return_member"
                                                    placeholder="enter the member ID" name="membership_id" required>
                                            </div>
                                            <div class="col-md ">
                                                <button class="btn btn-primary" id="return_find_img">Find</button>
                                            </div>
                                        </div>
                                        <div class="form-group" id="return_find_div">
                                            <div class="row mt-4">
                                                <div class="col-md-3 text-center">
                                                    <img src="static/media/images/profile.jpg" width="140"
                                                        id="return_member_photo"
                                                        class="shadow p-3 bg-body-tertiary rounded">
                                                </div>
                                                <div class="col-md ">
                                                    <div class="row">
                                                        <div class="col-md">
                                                            Name:<h5 id="return_member_name"></h5>
                                                        </div>
                                                        <div class="col-md">
                                                            current Dues: <h3 id="return_current_dues"></h3>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- --------------------------------------------------------------- -->

                                    </div>
                                    <div class="alert alert-success mt-4" id="return_success_msg"
                                        style="display: none;">

                                    </div>
                                    <div class="row mt-4" id="return_card_div" style="display: none;">
                                        <div class="col-md">
                                            <div class="card mb-3 shadow mr-3 p-1 bg-body-tertiary rounded"
                                                style="max-width: 540px;">
                                                <div class="row g-0">
                                                    <div class="col-md-4">
                                                        <img src="" class="img-fluid rounded-start p-1 rounded"
                                                            id="return_img_path" alt="Book Cover">
                                                    </div>
                                                    <div class="col-md">
                                                        <div class="card-body">
                                                            <h5 class="card-title" id="return_title">Title</h5>
                                                            <p class="card-text">
                                                                <strong>Edition:</strong> <span
                                                                    id="return_edition"></span><br>
                                                                <strong>Total copies:</strong> <span
                                                                    id="return_copies"></span><br>
                                                                <strong>Available:</strong> <span
                                                                    id="return_copies_left"></span>
                                                            </p>

                                                            Details:<p class="card-text" id="return_details"></p>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="col" id="return_student_col">

                                    <input type="hidden" name="edition_id" id="return_input_edition">
                                    <input type="hidden" name="library_book_id" id="return_library_book_id">
                                    <input type="hidden" name="book_issued" id="return_book_issued">
                                    <div class="col-md-auto">
                                        <span id="return_isbn"></span>
                                    </div>
                                    <div class="form-button " style="display:none" id="return_btn_div">
                                        <button type="submit" class="btn btn-primary mt-4" id="return_btn">return
                                            Book</button>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <!-- ============================================================================================================ -->

                        <div class="tab-pane fade" id="add_candidate">
                            <div class="row justify-content-around mt-4">
                                <div class="col-md ">
                                    <h2>ADD new Member</h2>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <input type="hidden" id="user_id">
                                    <div class="row mt-4">
                                        <div class="col-md">
                                            <input type="text" id="email_input" name="member_email" class="form-control"
                                                placeholder="enter the email to search member....">

                                        </div>
                                        <div class="col-md">
                                            <button type="button" class="btn btn-primary"
                                                id="email_search_btn">Search</button>
                                        </div>
                                    </div>
                                    <div class="row mt-4">
                                        <div class="col-md">

                                            <input type="text" class="form-control"
                                                placeholder="name of the member is........" id="input_name" name="name"
                                                readonly>
                                        </div>
                                        <div class="col-md">
                                            <button type="button" class="btn btn-primary" id="add_candidate_btn">&plus;
                                                Add</button>
                                        </div>
                                    </div>
                                    <div class="row mt-4">
                                        <div class="col">
                                            <h2>Remove the member</h2>
                                        </div>
                                    </div>
                                    <div class="row mt-4">
                                        <div class="col">
                                            <input type="number" placeholder="enter the member ID........"
                                                id="delete_member_input" class="form-control">
                                        </div>
                                        <div class="col">
                                            <button type="button" class="btn btn-danger"
                                                id="delete_member_btn">Remove</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="row">
                                        <div class="col">
                                            <div class="alert alert-danger" id="not_registered_msg"
                                                style="display:none;">
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
                            <!-- ============================================================================================================ -->

                        </div>
                        <!-- ============================================================================================================ -->
                        <div class="tab-pane fade" id="add_new_book">
                            <div class="row">
                                <div class="col-md">
                                    <input type="text" name="title" class="form-control mt-2"
                                        placeholder="Search New books by title..." id="title_value">
                                </div>
                            </div>

                            <!-- -------------------------------------------------------------------------------------------------- -->
                            <div class="row" id="row_for_books">
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

                        <!-- ============================================================================================================ -->
                        <div class="tab-pane fade" id="requests">
                            <table border="3px solid green" width="80%" style="margin:30px auto;">
                                <thead class="text-center fw-bold">
                                    <td>Sr no.</td>
                                    <td>Name</td>
                                    <td>Profile Pic</td>
                                    <td>Status</td>
                                </thead>
                                <tbody id="tbl" class="text-center">

                                </tbody>
                            </table>
                        </div>
                        <!-- ============================================================================================================ -->
                    </div>
            </div>
            <!-- home page search bar -->
            <script>
                let debounce_search_title = function (func, delay) {
                    let timeout;
                    return function () {
                        if (timeout)
                            clearTimeout(timeout);
                        timeout = setTimeout(func, delay);
                    }
                }
                let library_book_title = document.querySelector('#library_book_title');
                let book_title_row = document.querySelector('#book_title_row');

                let allBookRequest = async () => {
                    book_title_row.innerHTML = '';
                    let param = 'title=' + library_book_title.value;
                    let response = await fetch('search_books_in_library.do?' + param);
                    let data = await response.json();
                    return data;
                };

                let imagesFunc = async (id) => {
                    let res = await fetch('getAllImages.do?edition_id=' + id);
                    let data = await res.json();
                    return data;
                }

                let libBookFunc = () => {
                    allBookRequest().then((data) => {

                        for (let obj of data) {
                            let col_1 = document.createElement('div');
                            col_1.className = 'col-md-6';
                            book_title_row.append(col_1);

                            let card = document.createElement('div');
                            card.className = 'card';
                            col_1.append(card);

                            let col_1_row_1 = document.createElement('div');
                            col_1_row_1.className = 'row';
                            card.append(col_1_row_1);

                            let col_1_row_1_col_1 = document.createElement('div');
                            col_1_row_1_col_1.className = 'col';
                            col_1_row_1.append(col_1_row_1_col_1);
                            // <!-- ---------------------------------------------------------------- -->
                            let ID = obj.bookEdition.bookEditionId;

                            let carousel = document.createElement('div');
                            carousel.className = "carousel slide carousel-fade";
                            carousel.setAttribute("data-bs-ride", "carousel");
                            carousel.id = ID;
                            col_1_row_1_col_1.append(carousel);

                            let carouselInner = document.createElement("div");
                            carouselInner.className = "carousel-inner";
                            carousel.append(carouselInner);

                            // < !-- --------------------------------------loop start-------------------------- -->

                            imagesFunc(ID).then((data) => {
                                for (let d of data) {
                                    let carousel_inner_div = document.createElement("div");
                                    if (data.indexOf(d) === 0) {
                                        carousel_inner_div.className = "carousel-item active";
                                    } else {
                                        carousel_inner_div.className = "carousel-item";
                                    }


                                    carouselInner.append(carousel_inner_div);

                                    let img = document.createElement("img");
                                    img.className = "d-block myimg";
                                    img.style.height = "300px";
                                    img.style.width = "250px";

                                    img.src = "show_edition_img.do?path=" + d.editionImgPath;
                                    carousel_inner_div.append(img);
                                }

                            }).catch((error) => {
                                console.log(error);
                            });

                            // // < !-- ------------------------------------- loop end--------------------------- -->
                            let carouselPrevButton = document.createElement("button");
                            carouselPrevButton.className = "carousel-control-prev";
                            carouselPrevButton.setAttribute("data-bs-target", "#" + ID);
                            carouselPrevButton.setAttribute("data-bs-slide", "prev");
                            carousel.append(carouselPrevButton);

                            let span1 = document.createElement("span");
                            span1.className = "carousel-control-prev-icon";
                            span1.setAttribute("aria-hidden", "true");

                            let span2 = document.createElement("span");
                            span2.className = "visually-hidden";
                            span2.innerText = "Previous";

                            carouselPrevButton.append(span1);
                            carouselPrevButton.append(span2);


                            // < !-- ---------------------------------------------------------------- -->
                            let carouselNextButton = document.createElement("button");
                            carouselNextButton.className = "carousel-control-next";
                            carouselNextButton.setAttribute("data-bs-target", "#" + ID);
                            carouselNextButton.setAttribute("data-bs-slide", "next");
                            carousel.append(carouselNextButton);

                            let span3 = document.createElement("span");
                            span3.className = "carousel-control-next-icon";
                            span3.setAttribute("aria-hidden", "true");

                            let span4 = document.createElement("span");
                            span4.className = "visually-hidden";
                            span4.innerText = "Next";

                            carouselNextButton.append(span3);
                            carouselNextButton.append(span4);
                            // < !-- ---------------------------------------------------------------- -->

                            let col_1_row_1_col_2 = document.createElement('div');
                            col_1_row_1_col_2.className = 'col-md';
                            col_1_row_1.append(col_1_row_1_col_2);


                            let card_body = document.createElement('div');
                            card_body.className = 'card-body';
                            col_1_row_1_col_2.append(card_body);

                            let card_body_row_1 = document.createElement('div');
                            card_body_row_1.className = 'row fs-1 fw-bolder';
                            card_body.append(card_body_row_1);
                            card_body_row_1.innerText = obj.bookEdition.book.title;


                            let card_body_row_2 = document.createElement('div');
                            card_body_row_2.className = 'row';
                            card_body.append(card_body_row_2);

                            let card_body_row_2_col_1 = document.createElement('div');
                            card_body_row_2_col_1.className = 'col-md fs-3 fw-bold';
                            card_body_row_2_col_1.innerText = 'ISBN:';
                            card_body_row_2.append(card_body_row_2_col_1);

                            let card_body_row_2_col_2 = document.createElement('div');
                            card_body_row_2_col_2.className = 'col-md fs-2 fw-bolder ';

                            let span = document.createElement('span');
                            card_body_row_2_col_2.append(span);
                            span.className = 'text-bg-dark p-1 m-auto';
                            span.innerText = obj.bookEdition.isbnNo;
                            card_body_row_2.append(card_body_row_2_col_2);

                            let card_body_row_3 = document.createElement('div');
                            card_body_row_3.className = 'row';
                            card_body.append(card_body_row_3);

                            let card_body_row_3_col_1 = document.createElement('div');
                            card_body_row_3_col_1.className = 'col-md fs-3 fw-bold';
                            card_body_row_3_col_1.innerText = 'Edition:';
                            card_body_row_3.append(card_body_row_3_col_1);

                            let card_body_row_3_col_2 = document.createElement('div');
                            card_body_row_3_col_2.className = 'col-md fs-2 fw-bolder';
                            card_body_row_3.append(card_body_row_3_col_2);

                            if (obj.bookEdition.edition === 1) {
                                card_body_row_3_col_2.innerHTML = '<span>' + obj.bookEdition.edition + '<sup>' + 'st' + '</sup>' + '</span>';
                            }
                            else if (obj.bookEdition.edition === 2) {
                                card_body_row_3_col_2.innerHTML = '<span>' + obj.bookEdition.edition + '<sup>' + 'nd' + '</sup>' + '</span>';
                            }
                            else if (obj.bookEdition.edition === 3) {
                                card_body_row_3_col_2.innerHTML = '<span>' + obj.bookEdition.edition + '<sup>' + 'rd' + '</sup>' + '</span>';
                            } else {
                                card_body_row_3_col_2.innerHTML = '<span>' + obj.bookEdition.edition + '<sup>' + 'th' + '</sup>' + '</span>';
                            }




                            let card_body_row_4 = document.createElement('div');
                            card_body_row_4.className = 'row';
                            card_body.append(card_body_row_4);

                            let card_body_row_4_col_1 = document.createElement('div');
                            card_body_row_4_col_1.className = 'col-md fs-3 fw-bold';
                            card_body_row_4_col_1.innerText = 'Total:';
                            card_body_row_4.append(card_body_row_4_col_1);

                            let card_body_row_4_col_2 = document.createElement('div');
                            card_body_row_4_col_2.className = 'col fs-2 fw-bolder';
                            card_body_row_4_col_2.innerText = obj.copies;
                            card_body_row_4.append(card_body_row_4_col_2);



                            let card_body_row_5 = document.createElement('div');
                            card_body_row_5.className = 'row';
                            card_body.append(card_body_row_5);

                            let card_body_row_5_col_1 = document.createElement('div');
                            card_body_row_5_col_1.className = 'col-md fs-3 fw-bold';
                            card_body_row_5_col_1.innerText = 'Available:';
                            card_body_row_5.append(card_body_row_5_col_1);

                            let card_body_row_5_col_2 = document.createElement('div');
                            card_body_row_5_col_2.className = 'col-md fs-3 fw-bolder';
                            if ((obj.copies - obj.bookIssued) === 0) {
                                card_body_row_5_col_2.className = 'col-md mt-2 fw-bolder';
                                card_body_row_5_col_2.innerText = 'out of stock';
                                card_body_row_5_col_2.style.color = 'red';
                            } else {
                                card_body_row_5_col_2.className = 'col-md fs-2 fw-bolder';
                                card_body_row_5_col_2.innerText = obj.copies - obj.bookIssued;
                            }
                            card_body_row_5.append(card_body_row_5_col_2);

                        }
                    }).catch((error) => {
                        console.log(error);
                    })

                }
                let regex = /[A-Za-z ]{3,}/;
                let optSearch = debounce_search_title(libBookFunc, 800);
                library_book_title.addEventListener('keyup', () => {
                    if (regex.test(library_book_title.value)) {
                        optSearch();
                    } else {
                        book_title_row.innerHTML = ' ';
                    }
                });
            </script>
            <!-- increasing size on mouse over on the images -->
            <script>
                window.addEventListener('mouseover', (e) => {
                    if (e.target.tagName === 'IMG') {
                        console.log(e.target.tagName === 'IMG')
                        e.target.style.transform = 'scale(1.2)';
                    }
                });
                window.addEventListener('mouseout', (e) => {
                    if (e.target.tagName === 'IMG') {
                        // console.log(e.target.tagName === 'IMG')
                        e.target.style.transform = 'scale(1)';
                    }
                });
            </script>
            <!-- search book by title -->
            <script>
                let title_value = document.querySelector("#title_value");
                let book_img = document.querySelector('#book_img');
                let title = document.querySelector("#title");
                let published_on = document.querySelector("#published_on");
                let price = document.querySelector("#price");
                let all_editions = document.querySelector("#all_editions");
                let edition_btn = document.querySelector("#edition_btn");
                let row_for_books = document.querySelector("#row_for_books");
                row_for_books.innerHTML = '';
                let num = 0;

                let search_func = () => {

                    row_for_books.innerHTML = '';
                    let req = new XMLHttpRequest();
                    let regex = /[A-Za-z]{3,}/;
                    if (regex.test(title_value.value)) {

                        let param = 'title=' + title_value.value;

                        req.open('GET', 'search_title.do?' + param, true);

                        req.addEventListener('readystatechange', () => {
                            if (req.readyState == 4 && req.status == 200) {
                                let arr = JSON.parse(req.responseText);


                                for (let obj of arr) {
                                    let a = document.createElement('a');

                                    a.href = 'book_edition.do?book_id=' + obj.bookId + "&num=2";
                                    let col = document.createElement('div');
                                    col.className = 'col-md-3 mt-4 ';
                                    row_for_books.append(col);

                                    let card = document.createElement('div');
                                    col.append(card);
                                    card.className = 'card shadow p-3 mb-2 bg-body-tertiary rounded'
                                    card.style.width = '15rem;';
                                    card.append(a);
                                    let img = document.createElement('img');
                                    a.append(img);
                                    img.src = 'show_book_img.do?img_path=' + obj.bookPic;
                                    img.height = '290';
                                    img.className = 'card-img-top';
                                    let card_body = document.createElement('div');
                                    card.append(card_body);
                                    card_body.className = 'card-body';
                                    let h3 = document.createElement('h3');
                                    card_body.append(h3);
                                    h3.innerText = obj.title;


                                }
                            }
                        });
                        req.send();
                    }
                }

                let optimizeSearch = debounce_search_title(search_func, 800);
                title_value.addEventListener('keyup', () => {

                    optimizeSearch();
                });

            </script>
            <!-- issue book tab for showing book -->
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
                let member_photo = document.querySelector('#member_photo');
                let student_col = document.querySelector('#student_col');

                let find_div = document.querySelector("#find_div");


                search_isbn.addEventListener('click', () => {
                    let req = new XMLHttpRequest();


                    let param = 'isbn_no=' + isbn_no.value;


                    req.open('GET', 'search_isbn_no.do?' + param, true);

                    req.addEventListener('readystatechange', () => {

                        if (req.readyState == 4 && req.status == 200) {
                            card_div.style.display = 'block';
                            let arr = JSON.parse(req.responseText);
                            console.log(arr);
                                
                                h1.innerText = arr.libBooks.bookEdition.book.title;
                                
                                img_path.src = 'show_edition_img.do?path=' + arr.path;
                                edition.innerText = arr.libBooks.bookEdition.edition;
                                details.innerText = arr.libBooks.bookEdition.details;
                                copies.innerText = arr.libBooks.copies;
                                input_edition.value = arr.libBooks.bookEdition.bookEditionId;
                                library_book_id.value = arr.libBooks.libraryBookId;
                                book_issued.value = arr.libBooks.bookIssued;

                                if (arr.libBooks.copies - arr.libBooks.bookIssued > 0) {
                                    student_col.style.display = 'inline';
                                    copies_left.innerText = arr.libBooks.copies - arr.libBooks.bookIssued;
                                    copies_left.style.color = 'black';
                                } else {
                                    student_col.style.display = 'none';
                                    copies_left.innerText = "out of stock";
                                    copies_left.style.color = 'red';
                                }

                        }
                    });

                    req.send();
                    member_photo.style.display = 'block';
                    find_div.style.display = 'block';
                });


            </script>
            <!-- issue button events -->
            <script>
                const issue_btn = document.querySelector("#issue_btn");
                const member = document.querySelector("#Member");
                const success_msg = document.querySelector("#success_msg");
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
                            } else {

                                card_div.style.display = 'none';
                                isbn_no.value = isbn_no.defaultValue;
                                member.value = member.defaultValue;
                                success_msg.innerHTML = '<span> Member is<Strong> Not Active </Strong>so cannot issue book </span>';
                                success_msg.style.color = 'red';
                                success_msg.classList.replace('alert-success', 'alert-danger');
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
            <!-- find image of the member for issue book  -->
            <script>
                let find_img = document.querySelector("#find_img");
                let member_name = document.querySelector('#member_name');
                let current_dues = document.querySelector('#current_dues');
                let msg_for_dues = document.querySelector('#msg_for_dues');
                let pay_btn = document.querySelector('#pay_btn');
                find_img.addEventListener('click', () => {
                    find();
                });
                let find = () => {
                    let req = new XMLHttpRequest();

                    let param = 'member_id=' + member.value;

                    req.open('GET', 'member_photo_for_issue.do?' + param, true);

                    req.addEventListener('readystatechange', () => {
                        if (req.readyState == 4 && req.status == 200) {
                            let obj = JSON.parse(req.responseText);
                            if (obj.flag) {
                                member_photo.src = "logo.do?path=" + obj.issued_book.memberShip.profilePic;
                                member_name.innerText = obj.issued_book.memberShip.name;
                                current_dues.innerText = obj.issued_book.memberShip.currentDues;
                                msg_for_dues.style.display = 'none';
                                if (obj.issued_book.memberShip.currentDues > 0) {
                                    msg_for_dues.style.display = 'inline';
                                    issue_btn.style.display = 'none';
                                    msg_for_dues.innerText = 'Please Pay the Dues';
                                    msg_for_dues.style.color = 'red';
                                    msg_for_dues.className = 'fw-bolder fs-1';
                                    pay_btn.style.display = 'inline';
                                }
                            } else {
                                member_name.innerText = 'No member found';
                            }
                        }
                    });
                    req.send();
                    issue_btn.style.display = 'block';
                };

                issue_btn.addEventListener('click', () => {
                    member_photo.src = 'static/media/images/profile.jpg';
                    member_photo.style.display = ' none';
                    member_name.innerText = ' ';
                    current_dues.innerText = '';
                    issue_btn.style.display = 'none';
                    find_div.style.display = 'none';
                });



            </script>
            <!-- return book tab for showing book -->
            <script>
                const return_isbn_no = document.querySelector('#return_isbn');
                const return_search_isbn = document.querySelector('#return_search_isbn');
                const return_h1 = document.querySelector('#return_title');
                const return_img_path = document.querySelector('#return_img_path');
                const return_card_div = document.querySelector('#return_card_div');
                const return_edition = document.querySelector('#return_edition');
                const return_details = document.querySelector('#return_details');
                const return_copies = document.querySelector('#return_copies');
                const return_input_edition = document.querySelector('#return_input_edition');
                const return_library_book_id = document.querySelector('#return_library_book_id');
                const return_copies_left = document.querySelector('#return_copies_left');
                let return_book_issued = document.querySelector("#return_book_issued");
                let return_member_photo = document.querySelector('#return_member_photo');
                let return_student_col = document.querySelector('#return_student_col');


                let return_find_div = document.querySelector("#return_find_div");


                let return_isbn_func = (isbnNo) => {

                    let req = new XMLHttpRequest();

                    let param = 'isbn_no=' + isbnNo;

                    req.open('GET', 'search_isbn_no.do?' + param, true);

                    req.addEventListener('readystatechange', () => {

                        if (req.readyState == 4 && req.status == 200) {
                            return_card_div.style.display = 'block';
                            let arr = JSON.parse(req.responseText);

                                return_find_div.style.display = 'inline';
                                return_h1.innerText = arr.libBooks.bookEdition.book.title;
                                return_img_path.src = "show_edition_img.do?path=" + arr.path;
                                return_edition.innerText = arr.libBooks.bookEdition.edition;
                                return_details.innerText = arr.libBooks.bookEdition.details;
                                return_copies.innerText = arr.libBooks.copies;
                                return_input_edition.value = arr.libBooks.bookEdition.bookEditionId;
                                return_library_book_id.value = arr.libBooks.libraryBookId;
                                return_book_issued.value = arr.libBooks.bookIssued;
                                return_btn.style.display = 'inline';

                                if (arr.libBooks.copies - arr.libBooks.bookIssued > 0) {
                                    return_copies_left.innerText = arr.libBooks.copies - arr.libBooks.bookIssued;
                                    return_copies_left.style.color = 'black';
                                } else {
                                    return_copies_left.innerText = "out of stock";
                                    return_copies_left.style.color = 'red';
                                }
                            }
                        }
                    );

                    req.send();
                }



            </script>
            <!-- find image of the member for return book  -->
            <script>
                let return_find_img = document.querySelector("#return_find_img");
                let return_member_name = document.querySelector('#return_member_name');
                let return_current_dues = document.querySelector('#return_current_dues');
                let return_member = document.querySelector('#return_member');
                let return_btn = document.querySelector('#return_btn');
                let return_btn_div = document.querySelector('#return_btn_div');
                let return_success_msg = document.querySelector('#return_success_msg');

                return_find_img.addEventListener('click', () => {
                    let req = new XMLHttpRequest();

                    let param = 'member_id=' + return_member.value;


                    req.open('GET', 'member_photo_find.do?' + param, true);

                    req.addEventListener('readystatechange', () => {

                        if (req.readyState == 4 && req.status == 200) {
                            let obj = JSON.parse(req.responseText);
                            if (obj.flag) {
                                return_member_photo.src = "logo.do?path=" + obj.issued_book.memberShip.profilePic;
                                return_member_name.innerText = obj.issued_book.memberShip.name;
                                return_current_dues.innerText = obj.issued_book.memberShip.currentDues;
                                return_btn_div.style.display = 'inline';
                                return_isbn_no.innerHTML = '<h2>ISBN No :&nbsp;<span class="fs-1">' + obj.issued_book.bookEdition.isbnNo + '</span></h2>';
                                return_isbn_no.style.display = 'inline';
                                return_isbn_func(obj.issued_book.bookEdition.isbnNo);
                            } else {
                                return_success_msg.style.display = 'inline';
                                return_success_msg.innerText = 'Member do not have book';
                                return_success_msg.classList.replace('succes', 'danger');
                                setTimeout(() => {
                                    return_success_msg.style.display = 'none';

                                }, 5000);
                            }

                        }
                    });
                    req.send();
                });
            </script>
            <!-- return button events -->
            <script>
                return_btn.addEventListener('click', () => {
                    let req = new XMLHttpRequest();

                    let param = 'member_id=' + return_member.value + "&book_edition_id=" + return_input_edition.value + "&book_issued=" + return_book_issued.value;


                    req.open('GET', 'return_book.do?' + param, true);

                    req.addEventListener('readystatechange', () => {
                        if (req.readystate == 4 && req.status == 200) {

                            console.log(req.responseText);


                        }
                    });

                    req.send();
                });

                return_btn.addEventListener('click', () => {

                    return_member_photo.src = 'static/media/images/profile.jpg';
                    return_member.value = return_member.defaultValue;
                    return_member_name.innerText = ' ';
                    return_btn.style.display = 'none'
                    return_find_div.style.display = 'none';
                    return_card_div.style.display = 'none';
                    return_isbn_no.style.display = 'none';
                    return_success_msg.innerText = 'Book Returned SuccessFully';
                    return_success_msg.style.display = 'block';
                    // return_isbn_no.innerHTML = '';
                    setTimeout(function () {
                        return_success_msg.style.display = 'none';
                    }, 3000);
                });
            </script>
            <!-- candidate search by email add candidate tab -->
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
            <!-- add candidate button events -->
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


                            if (json.flag) {
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
                            } else {

                                candidate_success_msg.innerHTML = "Candiate already is a Library member Member ID : <h1>" + json.member.memberId + "</h1>";
                                candidate_success_msg.style.display = 'block';
                                setTimeout(() => {
                                    candidate_success_msg.style.display = 'none';
                                }, 10000);

                                show_candidate();

                            }


                        }
                    });

                    req.send();
                })
            </script>
            <!-- delete member button events -->
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

                    let req = new XMLHttpRequest();

                    let param = 'member_id=' + delete_member_input.value;


                    req.open('GET', 'remove_member.do?' + param, true);

                    req.addEventListener('readystatechange', () => {
                        let json = JSON.parse(req.responseText);

                        delete_modal.style.display = 'none';
                        member_removed_success.style.display = 'block';
                        if (json == 0) {
                            member_removed_success.innerText = 'Member Removed SuccessFully';
                            setTimeout(() => {
                                member_removed_success.style.display = 'none';
                                delete_member_input.value = delete_member_input.defaultValue;

                            }, 5000);
                        } else {
                            member_removed_success.innerHTML = '<strong>Member Have<h3>' + json + '</h3>books</strong>';
                            setTimeout(() => {
                                member_removed_success.style.display = 'none';
                                delete_member_input.value = delete_member_input.defaultValue;

                            }, 10000);

                        }
                        show_candidate();
                    });

                    req.send();
                });



            </script>
            <!-- table below the add canidate tab  -->
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
            <!-- history table -->
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
            <!-- payment  -->
            <script>
                let pay = document.querySelector('#pay');
                let payment_amount = document.querySelector('#payment_amount');
                let close = document.querySelector('#close');

                pay.addEventListener('click', async () => {
                    let response = await fetch('payment.do?member_id=' + member.value + '&payment_amount=' + payment_amount.value);
                    let flag = await response.json();
                    if (flag) {
                        close.click();
                        payment_amount.value = payment_amount.defaultValue;
                        find();
                    }
                });
            </script>
            <!-- all requests of candidates -->
            <script>
                let tbl = document.querySelector("#tbl");
                let requests = async () => {
                    tbl.innerHTML = '';
                    let response = await fetch('get_all_request.do');
                    let data = await response.json();
                    let i = 0;
                    for (let obj of data) {
                        let row = tbl.insertRow(i);
                        let j = 0;
                        let cell = row.insertCell(j++);
                        cell.innerText = i + 1;
                        for (let prop in obj) {
                            if (prop === 'user') {
                                for (let p in obj[prop]) {
                                    if (p === 'name') {
                                        cell = row.insertCell(j++);
                                        cell.innerText = obj.user.name;
                                    } else if (p === 'profilePic') {
                                        cell = row.insertCell(j++);
                                        cell.innerHTML = "<img src=logo.do?path=" + obj.user.profilePic + " width='25px' class='candidate_img m-auto'></img>";
                                    }


                                }
                            } else if (prop === 'status') {
                                cell = row.insertCell(j++);
                                cell.innerText = obj.status.name;
                                cell = row.insertCell(j++);
                                cell.innerHTML = '<img src=static/media/images/approve.png width = 20 class="approve" id=' + obj.user.userId + '></img>';

                                cell = row.insertCell(j++);

                                cell.innerHTML = '<img src=static/media/images/cancel.png width=20 class="reject" id=' + obj.user.userId + '></img>';
                            }

                        }

                    }
                    candidate_imgs = document.querySelectorAll(".candidate_img");
                    candidate_imgs.forEach((candidate_img) => {
                        candidate_img.addEventListener('mouseover', () => {
                            candidate_img.style.transform = 'scale(5)';
                        });
                        candidate_img.addEventListener('mouseout', () => {
                            candidate_img.style.transform = 'scale(1)';
                        });
                    });

                    let approve_imgs = document.querySelectorAll('.approve');
                    let cancel_imgs = document.querySelectorAll('.reject');


                    approve_imgs.forEach((approve_img) => {
                        approve_img.addEventListener('mouseover', () => {
                            approve_img.style.transform = 'scale(1.5)';
                        });
                    });
                    cancel_imgs.forEach((cancel_img) => {
                        cancel_img.addEventListener('mouseover', () => {
                            cancel_img.style.transform = 'scale(1.5)';
                        });
                    });
                    approve_imgs.forEach((approve_img) => {
                        approve_img.addEventListener('mouseout', () => {
                            approve_img.style.transform = 'scale(1)';
                        });
                    });
                    cancel_imgs.forEach((cancel_img) => {
                        cancel_img.addEventListener('mouseout', () => {
                            cancel_img.style.transform = 'scale(1)';
                        });
                    });
                };

            </script>
            <!-- approving and rejecting events -->
            <script>
                async function checking(url) {
                    let response = await fetch(url);
                    let data = await response.json();
                    if (data)
                        requests();
                };
                window.addEventListener('click', (e) => {
                    if (e.target.classList[0] === 'approve') {
                        let url = "approve_reject.do?status_id=9&user_id=" + e.target.id;
                        checking(url);

                    } else if (e.target.classList[0] === 'reject') {
                        let url = "approve_reject.do?status_id=10&user_id=" + e.target.id;
                        checking(url);

                    }
                });


            </script>

            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>