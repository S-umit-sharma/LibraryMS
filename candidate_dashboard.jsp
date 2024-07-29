<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candidate DashBoard</title>

    <link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css" />
</head>

<body>
    <!-- ------------------------------------------------------ -->
    <div class="modal fade" id="logo_upload">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title">Upload Your Image</h1>
                </div>
                <div class="modal-body">
                    <form action="candidate_logo_upload.do" class="dropzone" method="post" id="pic_form">

                    </form>

                </div>
            </div>
        </div>
    </div>
    <!-- ------------------------------------------------------ -->
    <div class="modal fade" id="document_modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Upload Your document</h3>
                </div>
                <div class="modal-body">
                    <form action="upload_document.do" class="dropzone" id="document_pic_form">

                    </form>
                </div>
            </div>
        </div>
    </div>
    <!-- ------------------------------------------------------ -->
    <div class="container">
        <div class="row">
            <div class="col">
                <%@ include file="Navbar.jsp" %>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-md-1 mb-1">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                    data-bs-target="#logo_upload">upload</button>
            </div>
            <div class="col-md">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal"
                    data-bs-target="#document_modal">upload Document</button>
            </div>
        </div>
        <div class="row">
            <div class="col">
                <img src="logo.do?path=${user.profilePic}" width="200">
            </div>
            <div class="col">
                
            </div>
        </div>
    </div>

    <script>
        const dropZone = new Dropzone('#document_pic_form', {
            maxFiles: 1,
            maxFileSize: 1,
            acceptedFiles: '.jpg,.png',
            autoProcessQueue: false
        });

        // const upload_doc_btn = document.querySelector("#upload_doc_btn");

        // upload_doc_btn.addEventListener('click', () => {
        //     dropZone.processQueue();
        // });
    </script>
    <script>

        // Dropzone.autoDiscover = false;
        const dropzone = new Dropzone('#form', {
            maxFiles: 1,
            maxFileSize: 1,
            acceptedFiles: '.png,.jpg',
            autoProcessQueue: false
        });
        // const upload_btn = document.querySelector("#upload_btn");

        // upload_btn.addEventListener('click', () => {
        //     dropzone.processQueue();
        // });

    </script>
    <script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
    



</body>

</html>