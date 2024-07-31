<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publisher details</title>
    <link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css" />
    <style>
        #divcolor {
            background-color: rgb(230, 241, 241);
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
                    <form action="publisher_logo_upload.do" class="dropzone" id="publisher_logo" >
                        
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
        <%@ include file="nameHeader.html" %>
        <div class="row justify-content-center">
            <div class="col-6 border border-secondary rounded p-4 shadow-lg p-3 m-5 bg-body-tertiary rounded" id="divcolor">
                <h1>Publisher</h1>
                <small>Submit details before you login</small>
                <form action="publisher_details.do" method="post" id="form">
                    <div class="mb-4 text-start my-4">
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                            data-bs-target="#exampleModal">
                            Upload  Pic
                        </button>
                        <img src="static/media/images/tick.gif" class="d-none" height="38px" id="success_tick">
                    </div>
                    <div class="row">
                        <div class="col">
                            <label class="form-label">Website</label>
                            <input type="url" name="website" class="form-control">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <label class="form-label">About</label>
                            <textarea type="text" col="80" rows="5" name="details" class="form-control"></textarea>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <button type="button" class="btn btn-primary mt-4" id="btn_save">Save</button>
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
        const btn_save = document.querySelector("#btn_save");
        btn_save.addEventListener('click', () => {
            form.submit();
        });

        // -------------------------------Dropzone-----------------------------
        const success_tick = document.querySelector('#success_tick');
        Dropzone.autoDiscover = false;

        const dropzone = new Dropzone('#publisher_logo',{
            maxFiles:1,
            maxFileSize:1,
            acceptedFiles:'.png,.jpg',
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