<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="i" uri="http://libraryMS/EditionImage" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Book Edition</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" />
            <link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css" />
        </head>

        <body>
            <!-- Modal for Image Upload -->
            <div class="modal fade" id="edition_image" tabindex="-1" aria-labelledby="edition_image_label"
                aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2 class="modal-title" id="edition_image_label">Book Image</h2>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="book_edition_logo_upload.do" class="dropzone" id="edition_image_upload">
                                <input type="hidden" name="edition_id" id="edition_input">
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary" id="upload_btn">Upload</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Modal for Adding Edition -->
            <div class="modal fade" id="edition_modal" tabindex="-1" aria-labelledby="edition_modal_label"
                aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h2 class="modal-title" id="edition_modal_label">Book Edition</h2>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="book_edition.do" method="post">
                                <input type="hidden" name="flag" value="false">
                                <input type="hidden" name="num" value="1">
                                <input type="hidden" name="book_id" value="${param.book_id}">

                                <div class="mb-3">
                                    <label for="isbn_no" class="form-label fs-3">ISBN No</label>
                                    <input type="number" name="isbn_no" class="form-control" id="isbn_no" required>
                                </div>
                                <div class="mb-3">
                                    <label for="book_edition" class="form-label fs-3">Edition</label>
                                    <input type="number" name="edition" class="form-control" id="book_edition" required>
                                </div>
                                <div class="mb-3">
                                    <label for="publish_date" class="form-label fs-3">Published Date</label>
                                    <input type="date" name="publish_date" class="form-control" id="publish_date"
                                        required>
                                </div>
                                <div class="mb-3">
                                    <label for="price" class="form-label fs-3">Price</label>
                                    <input type="number" name="price" class="form-control" id="price" required>
                                </div>
                                <div class="mb-3">
                                    <label for="details" class="form-label fs-3">More Details</label>
                                    <textarea name="more_details" id="details" rows="7" cols="70"
                                        class="form-control"></textarea>
                                </div>
                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary mt-4">&plus; Edition</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
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
                                    <li class="breadcrumb-item"><a href="book.do">Home</a></li>
                                    <li class="breadcrumb-item active">Book Editions</li>
                                </ol>
                            </nav>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col">
                            <div class="row">
                                <div class="col-1">
                                    <a href="book.do" style="text-decoration:none;">
                                        <img src="static/media/images/previous.png" height="35" alt="Previous">
                                    </a>
                                </div>
                                <div class="col-2">
                                    <a class="btn btn-outline-primary"
                                        href="book_edition.do?book_id=${param.book_id}&num=1">Show Editions</a>
                                </div>
                                <div class="col">

                                    <div class="text-end pe-5">
                                        <button class="btn btn-primary" data-bs-toggle="modal"
                                            data-bs-target="#edition_modal">&plus; Edition</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <c:forEach var="edition" items="${book_editions}" varStatus="n">
                            <c:if test="${(n.count - 1) % 4 == 0}">
                                <div class="row justify-content-around mt-3">
                            </c:if>

                            <div class="col-md mt-4">
                                <div class="card shadow p-3 mb-5 bg-body-tertiary rounded" style="width:15rem;">
                                    <!-- ------------------- -->

                                    <c:choose>
                                        <c:when test="${!edition.imgStatus}">
                                            <img src="static/media/images/book.png" class="card-img-top"  width='200' height='260'>
                                        </c:when>
                                        <c:otherwise>
                                            <div id="carouselExampleAutoplaying" class="carousel slide"
                                                data-bs-ride="carousel">
                                                <div class="carousel-inner">
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
                                            </c:choose> Edition
                                        </h4>
                                        <h4>&#8377; ${edition.price}</h4>
                                        <h4 class="fs-6">Published On: ${edition.publishedOn}</h4>
                                        <div class="row">
                                            <div class="col">

                                                <a data-bs-target="#edition_image" data-bs-toggle="modal"
                                                    class="edition_book" id="${edition.bookEditionId}">
                                                    <img src="static/media/images/imgedit.png" alt="" width="35">
                                                </a>
                                            </div>
                                            <div class="col">
                                                <a
                                                    href="delete_book_edition.do?book_id=${param.book_id}&book_edition_id=${edition.bookEditionId}">
                                                    <img src="static/media/images/delete.png" width="35" alt="Delete">
                                                </a>
                                            </div>
                                            <div class="col">
                                                <a
                                                    href="update_book_edition.do?book_edition_id=${edition.bookEditionId}">
                                                    <img src="static/media/images/update.png" width="35" alt="Update">
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- ------------------- -->

                                </div>
                            </div>
                            <c:if test="${n.count % 4 == 0}">
                    </div>
                    </c:if>
                    </c:forEach>
            </div>
            </div>

            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
            <script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
            <script>
                Dropzone.autoDiscover = false;

                let edition_image_upload = document.querySelector("#edition_image_upload");

                const dropzone = new Dropzone('#edition_image_upload', {
                    maxFiles: 1,
                    maxFileSize: 1,
                    acceptedFiles: '.png,.jpg,.jpeg,.webp',
                    autoProcessQueue: false
                });

                document.querySelector('#upload_btn').addEventListener('click', () => {
                    dropzone.processQueue();
                });

                dropzone.on('complete', () => {
                    setTimeout(() => {
                        dropzone.removeAllFiles(true);

                    }, 3000);
                });

                document.querySelectorAll('.edition_book').forEach(edition => {
                    edition.addEventListener('click', () => {
                        document.querySelector('#edition_input').value = edition.id;
                    });
                });
            </script>
            <!-- custom tag for edition images -->

        </body>

        </html>