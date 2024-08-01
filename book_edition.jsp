<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Book Edition</title>

        <link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css" />
    </head>

    <body>
        <!-- ----------------------------------------------------------------------------------- -->
        <div class="modal fade" id="edition_image">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 class="modal-title">Book Image</h2>
                    </div>
                    <div class="modal-body">
                        <form action="book_edition_logo_upload.do" class="dropzone" id="edition_image_upload">
                            <input type="hidden" name="edition_id" id="edition_input">
                        </form>
                    </div>
                    <div class="mdoal-footer my-1">
                        <button type="button" class="btn btn-secondary mx-1" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary mx-1" id="upload_btn">Upload</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- ----------------------------------------------------------------------------------- -->
        <div class="modal fade" id="edition_modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="model-header">
                        <h2 class="modal-title mx-3">Book Edition</h2>
                    </div>
                    <div class="modal-body">
                        <form action="book_edition.do" method="post">
                            <input type="hidden" name="flag" value="false">
                            <input type="hidden" name="num" value="1">

                            <input type="hidden" name="book_id" value="${param.book_id}">
                            <div>
                                <label for="isbn_no" class="form-label fs-3">Isbn No</label>
                                <input type="number" name="isbn_no" class="form-control" id="isbn_no">
                            </div>
                            <div>
                                <label for="book_edition" class="form-label fs-3">Edition</label>
                                <input type="number" name="edition" class="form-control" id="book_edition">
                            </div>
                            <div>
                                <label for="publish_date" class="form-label fs-3">Published Date</label>
                                <input type="date" name="publish_date" class="form-control" id="publish_date">
                            </div>
                            <div>
                                <label for="price" class="form-label fs-3">Price</label>
                                <input type="number" name="price" class="form-control" id="price">
                            </div>
                            <div>
                                <label for="details" class="form-label fs-3">More Details</label>
                                <textarea type="text" rows="7" col="70" name="more_details" id="details"
                                    class="form-control"></textarea>
                            </div>
                            <div class="text-center">
                                <button type="submit" class="btn btn-primary mt-4">&plus;Edition</button>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer"></div>
                </div>
            </div>
        </div>


        <!-- --------------------------------------------------------------------- -->
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
                            <li class="breadcrumb-item"><a href="book.do">Home</a></li>
                            <li class="breadcrumb-item active">Book Editions</li>
                        </ol>
                    </nav>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div data-bs-toggle="tab" data-bs-target="#book_edition_pane">
                        <div class="row">
                            <div class="col-1">
                                <a href="book.do" style="decoration:none;">
                                    <img src="static/media/images/previous.png" height="35">
                                </a>
                            </div>

                            <div class="col-2">
                                <a class="btn btn-outline-primary"
                                    href="book_edition.do?book_id=${param.book_id}&num=1">Show Editions</a>
                            </div>

                        </div>

                    </div>

                    <div class="tab-content">
                        <div class="tab-pane fade show active" id="book_edition_pane">
                            <div class="text-end mt-4 pe-5" id="">
                                <button class="btn btn-primary" data-bs-toggle="modal"
                                    data-bs-target="#edition_modal">&plus;Edition</button>
                            </div>
                            <c:forEach var="edition" items="${book_editions}" varStatus="n">
                                <c:if test="${(n.count-1)%4==0}">
                                    <div class="row justify-content-around mt-3">
                                </c:if>
                                <div class="col-md mt-4">
                                    <a data-bs-target="#edition_image" data-bs-toggle="modal" class="edition_book"
                                        id="${edition.bookEditionId}">
                                        <div class="card shadow p-3 mb-5 bg-body-tertiary rounded" style="width:15rem;">

                                            <c:choose>
                                                <c:when test="${empty edition.bookEditionPic}">
                                                    <img src="static/media/images/book.png" class="card-img-top"
                                                        width="100" height="250">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="show_edition_img.do?path=${edition.bookEditionPic}"
                                                        width="100" height="250" class="card-img-top">
                                                </c:otherwise>
                                            </c:choose>
                                    </a>

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
                                        <div class="row">
                                            <div class="col">
                                                <a
                                                    href="delete_book_edition.do?book_id=${param.book_id}&book_edition_id=${edition.bookEditionId}">
                                                    <img src="static/media/images/delete.png" width="35">
                                                </a>
                                            </div>
                                            <div class="col">
                                                <a
                                                    href="update_book_edition.do?book_edition_id=${edition.bookEditionId}">
                                                    <img src="static/media/images/update.png" width="35">
                                                </a>
                                            </div>

                                        </div>
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
        </div>

        </div>

        <script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
        <script>
            DropZone.autoDiscover = false;

            const dropzone = new Dropzone('edition_image_upload', {
                maxFiles: 1,
                maxFileSize: 1,
                acceptedFiles: '.png,.jpg',
                autoProcessQueue: false
            });

            const uploadBtn = document.querySelector('#upload_btn');

            uploadBtn.addEventListener('click', () => {
                dropzone.processQueue();
            });
            dropzone.on('complete', () => {
                // alert.classList.replace('d-none','d-block');
            })
        </script>
        <script>
            const editions = document.querySelectorAll('.edition_book');
            const editionInput = document.querySelector('#edition_input');

            editions.forEach((edition) => {
                edition.addEventListener('click', () => {
                    editionInput.value = edition.id;
                });
            });
        </script>
    </body>

    </html>