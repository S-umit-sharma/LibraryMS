<%@ taglib prefix="i" uri="http://libraryMS/EditionImage" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library Edition</title>
</head>

<body>
    <!-- ----------------------------------------ADD BOOK TO LIBRARY MODAL----------------------------------------------------------- -->
    <div class="modal fade" id="save_library_book">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h2 class="modal-title">Enter number of Books</h2>
                </div>
                <div class="modal-body">

                    <div class="row">
                        <form action="save_book_into_library.do" id="form">
                            <input type="hidden" name="edition_id" id="edition_input">
                            <input type="hidden" name="book_id" id="book_id_input">
                            <div class="col-md fs-4">
                                <button id="minus">-</button>
                                <input id="copies_number" type="number" name="copy" value="0">
                                <button id="plus">+</button>
                            </div>
                        </form>
                    </div>

                </div>
                <div class="mdoal-footer my-1">
                    <button type="button" class="btn btn-secondary mx-1" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary mx-1" id="add_button">&plus;ADD</button>
                </div>
            </div>
        </div>
    </div>
    <!-- --------------------------------------------------------------------------------------------------- -->
    <div class="container">
        <div class="row">
            <div class="col">
                <%@ include file="Navbar.jsp" %>
            </div>
        </div>
        <%@ include file="nameHeader.html" %>
            <div class="row">
                <div class="col">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <!-- home_page.do meanes to library page -->
                            <li class="breadcrumb-item"><a href="home_page.do">Home</a></li>
                            <li class="breadcrumb-item active">Editions</li>
                        </ol>
                    </nav>
                </div>
            </div>
            <div class="row mt-3">
                <div class="col text-center">
                    <span> Editions Of &nbsp;<span class="fs-1 fw-bold">${book_editions[0].book.title}&nbsp;</span>
                        book</span>
                </div>
            </div>
            <div class="tab-content">
                <div class="tab-pane fade show active" id="book_edition_pane">

                    <c:forEach var="edition" items="${book_editions}" varStatus="n">
                        <c:if test="${(n.count-1)%4==0}">
                            <div class="row justify-content-around mt-3">
                        </c:if>
                        <div class="col-md mt-4">
                            <div class="card shadow p-3 mb-5 bg-body-tertiary rounded" style="width:15rem;"
                                id="${edition.bookEditionId}">

                                <c:choose>
                                    <c:when test="${empty edition.imgStatus}">
                                        <img src="static/media/images/book.png" class="card-img-top" width="100"
                                            height="250">
                                    </c:when>
                                    <c:otherwise>
                                    <div id="carouselExampleAutoplaying" class="carousel slide" data-bs-ride="carousel">
                                        <div class="carousel-inner" style="transform: 0.5s ease-in-out">
                                            <i:showImages editionId="${edition.bookEditionId}">
                                                ${img}
                                            </i:showImages>
                                        </div>
                                        <button class="carousel-control-prev" type="button"
                                            data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
                                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                            <span class="visually-hidden">Previous</span>
                                        </button>
                                        <button class="carousel-control-next" type="button"
                                            data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
                                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                            <span class="visually-hidden">Next</span>
                                        </button>
                                    </div>
                                </c:otherwise>
                                </c:choose>

                                <div class="card-body">
                                    <h4 class="card-title">${edition.edition}
                                        <c:choose>
                                            <c:when test="${edition.edition == 1}"><sup>st</sup></c:when>
                                            <c:when test="${edition.edition == 2}"><sup>nd</sup></c:when>
                                            <c:when test="${edition.edition == 3}"><sup>rd</sup></c:when>
                                            <c:otherwise><sup>th</sup></c:otherwise>
                                        </c:choose>Edition
                                    </h4>
                                    <h4>&#8377; ${edition.price}</h4>
                                    <h4 class="fs-6">Publish On: ${edition.publishedOn}</h4>

                                </div>
                                <div class="card-footer">
                                    <button id="${edition.bookEditionId}.${edition.book.getBookId()}"
                                        class="addBookbutton btn btn-outline-primary"
                                        data-bs-target="#save_library_book" data-bs-toggle="modal">&plus;Add</button>
                                </div>

                            </div>
                        </div>
                        <c:if test="${n.count%4==0}">
                </div>

                </c:if>
                </c:forEach>
            </div>
    </div>
    </div>
    <script>
        let editions = document.querySelectorAll('.addBookbutton');
        let edition_input = document.querySelector('#edition_input');
        let book_id_input = document.querySelector('#book_id_input');
        let cards = document.querySelectorAll('.card');
        let copies = document.querySelectorAll('copies');

        editions.forEach((edition) => {
            edition.addEventListener('click', () => {
                edition_input.value = edition.id.split('.')[0];
                book_id_input.value = edition.id.split('.')[1];

            });
        });

        cards.forEach((card) => {
            let h4 = document.createElement('h4');
            h4.innerText = '';
            card.addEventListener('mouseover', async () => {
                let param = 'book_edition_id=' + card.id;
                let response = await fetch('find_total_books.do?' + param);
                let data = await response.json();
                card.append(h4);
                h4.innerText = "Owned : " + data.copies;
                h4.className = 'fw-bold';
            });
            card.addEventListener("mouseout", (e) => {
                console.log();
                if (e.target.classList.contains("card"))
                    e.target.lastElementChild.innerText = '';
            })
        });




        let input = document.querySelector('#copies_number');
        let plus = document.getElementById('plus');
        let minus = document.getElementById('minus');

        plus.addEventListener('click', event => {
            event.preventDefault();
            const number = Number(input.value) || 0;
            input.value = number + 1;
        });

        minus.addEventListener('click', event => {
            event.preventDefault();
            const number = Number(input.value) || 0;
            input.value = number - 1;
        });

        let add_btn = document.querySelector('#add_button');
        let form = document.querySelector('#form');
        let modal = document.querySelector('#save_library_book');

        add_btn.addEventListener('click', () => {

            form.submit();
            modal.style.display = 'none';
        });
    </script>
</body>

</html>