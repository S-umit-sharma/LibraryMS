<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://unpkg.com/dropzone@5/dist/min/dropzone.min.css" type="text/css" />

    <title>MemberShip</title>
</head>

<body>
    <!-- ------------------------------------------------------ -->
    <div class="modal fade" id="logo_upload">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title">Your Image</h1>
                </div>
                <div class="modal-body">
                    <form action="candidate_logo_upload.do" class="dropzone" method="post" id="form">

                    </form>

                    <button type="button" class="btn btn-primary" id="upload_btn">upload</button>
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
        <div class="row">
            <div class="col">

            </div>
        </div>
        <div class="row">
            <div class="col">
                <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#logo_upload" >upload</button>
            </div>
        </div>
    </div>

    <script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>
    <script>

        Dropzone.autoDiscover = false;
        const dropzone = new Dropzone('#form', {
            maxFiles: 1,
            maxFileSize: 1,
            acceptedFiles: '.png,.jpg',
            autoProcessQueue: false
        });
        const upload_btn = document.querySelector("#upload_btn");

        upload_btn.addEventListener('click', () => {
            dropzone.processQueue();
        });

    </script>
</body>

</html>