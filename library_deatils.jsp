<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library</title>
    <link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css" />
    <style>
        #divcolor {
            background-color: rgb(212, 240, 241);
        }
    </style>
</head>

<body>
    <!-- //Modal form -->
    <!-- Button trigger modal -->


    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="exampleModalLabel">Upload Library Logo</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="library_logo_upload.do" class="dropzone" id="library_logo">
                        
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" id="upload_btn">Upload</button>
                </div>
            </div>
        </div>
    </div>
    <!-- ----------------------------------------------------------------------------------------------------- -->
    <div class="container text-center">
        <div class="row">
            <div class="col">
                <%@ include file="Navbar.jsp" %>
            </div>
        </div>
        <div class="row justify-content-center">
            <div class="col-6 border border-secondary rounded p-4" id="divcolor">
                <h1>LIBRARY</h1>
                <small>Submit details before you login</small>
                <form action="library_details.do" method="post" id="form">
                    <div class="mb-4 text-start my-4">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                            data-bs-target="#exampleModal">
                            Upload Library Pic
                        </button>
                        <img src="static/media/images/tick.gif" class="d-none" height="38px" id="success_tick">
                    </div>
                    <div class="mb-4">
                        <label class="form-label fs-5">About us<sup class="text-danger">*</sup> :</label>
                        <textarea class="form-control fs-5" name="library_details" rows="8" col="80"
                            id="details_form"></textarea>
                    </div>
                    <div class="mb-4">
                        <label class="form-label fs-5">WebSite:</label>
                        <input type="url" class="form-control fs-5" name="website">
                    </div>

                    <div class="mb-4">
                        <label class="form-label fs-5">Opening Time:</label>
                        <input class="form-control fs-5" type="time" name="opening_time">
                    </div>
                    <div class="mb-4">
                        <label class="form-label fs-5">Closeing Time:</label>
                        <input class="form-control fs-5" type="time" name="closeing_time">
                    </div>
                    <div class="mb-4">
                        <label class="form-label">Book Issue Days:</label><br>
                        <input class="form-control fs-5" type="number" name="book_issue_days">
                    </div>
                    <div class="mb-4">
                        <label class="form-label fs-5">Late Fine:</label>
                        <input class="form-control fs-5" type="number" name="late_fine">
                    </div>
                    <div class="mb-4">
                        <label class="form-label fs-5">Deposite Amount:</label>
                        <input class="form-control fs-5" type="number" name="deposite_amount">
                    </div>
                    <div class="row text-center ">
                        <div class="col text-md my-4">
                            <button class="btn btn-success" id="add_library_btn">Add Library</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    </div>

    <script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
    <script>
        const form = document.querySelector("#form");
        const add_library_btn = document.querySelector("#add_library_btn");
        add_library_btn.addEventListener('click', () => {
            form.submit;
        });

        // -------------------------------Dropzone-----------------------------
        const success_tick = document.querySelector('#success_tick');
        Dropzone.autoDiscover = false;

        const dropzone = new Dropzone('#library_logo',{
            maxFiles:1,
            maxFileSize:1,
            acceptedFiles:'.png,.jpg,.webp,.jpeg',
            autoProcessQueue:false
        });
        const upload_btn = document.querySelector("#upload_btn");

        upload_btn.addEventListener('click',()=>{
            dropzone.processQueue();
        });
        dropzone.on('complete',()=>{
            success_tick.classList.replace('d-none','d-inline');
        });


    </script>
</body>

</html>