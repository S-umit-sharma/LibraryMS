<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Publisher Dashboard</title>
        <link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css" />
    
        
    </head>

    <body>
        <!-- BookPic Modal -->
        <div class="modal fade" id="bookPicModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel">Upload Book Logo</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="book_logo_upload.do" class="dropzone" id="book_logo">
                            <input type="hidden" name="book_id"  id="input_book">
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" id="upload_btn">Upload</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- ------------------------------------ADD BOOK Modal--------------------------------------------- -->
        <div class="modal fade" id="books_modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title">New Book</h3>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form action="book.do" method="post">
                            <div>
                                <label class="form-label fs-4" for="book">Book Category</label>
                                <select name="book_category" id="book">
                                    <option value="1">History</option>
                                    <option value="2">Story</option>
                                    <option value="3">Novel</option>
                                    <option value="4">Art</option>
                                    <option value="5">Psychology</option>
                                    <option value="6">Philosophy</option>
                                    <option value="7">economics</option>
                                    <option value="8">politics</option>
                                    <option value="9">religion</option>
                                    <option value="10">Biography</option>
                                    <option value="11">autobiography</option>
                                    <option value="13">self-help</option>
                                    <option value="14">Science</option>
                                    <option value="15">Technology</option>

                                </select>
                            </div>
                            <div>
                                <label class="form-label fs-4" for="book_title">Book Title</label>
                                <input type="text" name="book_title" class="form-control fs-3" id="book_title">
                            </div>

                            <div class="mt-4">
                                <input type="submit" class="btn btn-primary" value="&plus;ADD" id="submit_button">
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!-- ------------------------------alert for image upload--------------------------------------- -->
            <div class="alert alert-success d-none" id="alert">Image Uploaded successfully Please Refresh</div>
        <!-- --------------------------------------------------------------------- -->
        <div class="container">
            <div class="row">
                <div class="col">
                    <%@ include file="Navbar.jsp" %>
                </div>
            </div>
            <div class="row">
                <div class="col-1">
                    <abbr title="Show Books">
                        <a href="book.do">
                            <img src="static/media/images/show_book.png" width="70" class="shadow p-3 mb-2 bg-body-tertiary rounded">
                        </a>
                    </abbr>
                </div>
                <div class="col-1" data-bs-toggle="modal" data-bs-target="#books_modal">
                    <abbr title="Add Books">
                        <img src="static/media/images/add_book.png" width="70" class="shadow p-3 mb-2 bg-body-tertiary rounded">    
                    </abbr>
                </div>
            </div>
            <div class="row md">

            
                <c:forEach var="book" items="${books}" varStatus="n">
                    <c:if test="${(recs.count-1)%4==0}">
                        <div class="row justify-content-around mt-1">
                    </c:if>
                    <div class="col-md mt-4">
                        <a href="book_edition.do?book_id=${book.bookId}&num=1">
                            <div class="card shadow p-3 mb-2 bg-body-tertiary rounded" id="${book.bookId}" style="width:15rem;" >   
                                <c:choose>
                                    <c:when test="${empty book.bookPic}">
                                        <img  src="static/media/images/book.png"  class="rounded-start img-fluid x">
                                        
                                    </c:when>
                                    <c:otherwise>
                                        <img  src="show_book_logo.do?book_id=${book.bookId}" width="100" height="250" class="card-img-top">
                                    </c:otherwise>
                                </c:choose>
                            </a>
                            <div class="card-body">
                                <div class="row fs-1">
                                    <span class="fs-1">
                                        <h3 class="card-title">${book.title}</h3>
                                    </span>
                                </div>

                                <div class="row">
                                    <span class="col-md" style="cursor: pointer;">
                                        <a data-bs-toggle="modal"style="decoration:none" data-bs-target="#bookPicModal" class="book_anchor mt-2" id="${book.bookId}">
                                        <img src="static/media/images/imgedit.png" width="40">
                                        </a>
                                    </span>
                                    <span class="col cursor-pointer">
                                        <a href="update_book.do?book_id=${book.bookId}" style="decoration:none">
                                            <img src="static/media/images/update.png" width="40">
                                        </a>
                                    </span>
                                    <span class="col cursor-pointer">
                                        <a href="delete_book.do?book_id=${book.bookId}" style="decoration:none">
                                            <img src="static/media/images/delete.png" width="30">
                                        </a>
                                    </span>
    
                                </div>
                                
                            </div>
                            </div>
                    </div>
                    <c:if test="${(recs.count%4-1)==0}">
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
        <script>
           Dropzone.autoDiscover = true;

            const dropzone = new Dropzone('#book_logo', {
                maxFiles: 1,
                maxFileSize: 1,
                acceptedFiles: '.png,.jpg',
                autoProcessQueue: false
            });


            const uploadBtn = document.querySelector('#upload_btn');
            const alert = document.getElementById("alert");

            uploadBtn.addEventListener('click', () => {
                dropzone.processQueue();
            });
            dropzone.on('comlete',()=>{
                alert.classList.replace('d-none','d-block');
            });
            
        </script>
        <script>

        </script>
        <script>
            const books = document.querySelectorAll(".book_anchor");
            const input = document.querySelector("#input_book");
            
            books.forEach((book)=>{
                book.addEventListener('click',()=>{
                    const bookId = book.id;
                    input.value = bookId;
                })
            });
        </script>
    </body>

    </html>
