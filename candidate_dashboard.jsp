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
        <%@ include file="nameHeader.html" %>
            <hr>
            <div class="row mt-2 ">

                <!-- <div class="col-md"> -->
                <!-- <div class="row">
                        <div class="col">
                            <input list="cities" class="form-control" id="city"
                                placeholder="type city for nearby Library........">
                            <datalist id="cities">
                                <c:forEach var="ct" items="${cities}">
                                    <option value="${ct.city}(${ct.state.state})"></option>
                                </c:forEach>
                            </datalist>
                        </div>

                        <div class="col">
                            <button type="button" class="btn btn-outline-secondary">
                                <img src="static/media/images/search.png" width="20" id="search_img">
                            </button>

                        </div> -->

                <!-- </div> -->
                <!-- </div> -->

                <div class="col-md ">
                    <div class="col-md">
                        <button type="button" class="btn btn-success float-end" data-bs-toggle="modal"
                            data-bs-target="#logo_upload">Upload Pic</button>
                    </div>
                    <div class="col-md">
                        <button type="button" class="btn btn-info float-end mx-2" data-bs-toggle="modal"
                            data-bs-target="#document_modal">Upload Document</button>
                    </div>
                    <div class="col-md">
                        <button type="button" class="btn btn-outline-primary float-end mx-2">Near BY Library</button>
                    </div>
                </div>
            </div>

            <div class="row mt-4">
                <div class="col-md-12">
                    <input type="text" placeholder="type the name of library .........." class="form-control"
                        id="library_search">
                    <input type="hidden" value="${user.userId}" id="user_id">
                </div>
            </div>
            <div class="row mt-4" id="row_for_library">
            </div>

    </div>

    <script>
        const dropZone = new Dropzone('#document_pic_form', {
            maxFiles: 1,
            maxFileSize: 1,
            acceptedFiles: '.jpg,.png',
            autoProcessQueue: false
        });
    </script>
    <script>

        const dropzone = new Dropzone('#form', {
            maxFiles: 1,
            maxFileSize: 1,
            acceptedFiles: '.png,.jpg',
            autoProcessQueue: false
        });


    </script>
    <script>
        let library_search = document.querySelector('#library_search');
        let city = document.querySelector('#city');
        let row_for_library = document.querySelector('#row_for_library');
        let search_img = document.querySelector('#search_img');

        row_for_library.innerHTML = '';

        let regex = /[a-zA-Z]{3,}/;
        let search_lib_func = async () => {
            row_for_library.innerHTML = '';

            let param = 'library=' + library_search.value;



            if (regex.test(library_search.value)) {
                try {
                    let response = await fetch('library_search.do?' + param);
                    let data = await response.json();

                    for (let obj of data) {

                        let card = document.createElement('div');
                        row_for_library.append(card);
                        card.className = 'card mt-4';

                        let row = document.createElement('div');
                        card.append(row);
                        row.className = 'row mt-4';

                        let row_col_1 = document.createElement('div');
                        row.append(row_col_1);
                        row_col_1.className = 'col-md-3';

                        let img = document.createElement('img');
                        row_col_1.append(img);
                        img.className = 'card-img-top mb-3';
                        img.src = 'logo.do?path=' + obj.profilePic;
                        img.style.width = '280px';

                        let row_col_2 = document.createElement('div');
                        row.append(row_col_2);
                        row_col_2.className = 'col-md';

                        let card_body = document.createElement('div');
                        row_col_2.append(card_body);
                        card_body.className = 'card-body';

                        let card_body_row_1 = document.createElement('div');
                        card_body.append(card_body_row_1);
                        card_body_row_1.className = 'row';

                        let card_body_row_1_col_1 = document.createElement('div');
                        card_body_row_1.append(card_body_row_1_col_1);
                        card_body_row_1_col_1.className = 'col-md';

                        let card_body_row_1_col_2 = document.createElement('div');
                        card_body_row_1_col_2.className = 'col-md';
                        card_body_row_1.append(card_body_row_1_col_2);

                        let h2 = document.createElement('h2');
                        card_body_row_1_col_1.append(h2);
                        h2.className = 'card-title';
                        h2.innerText = obj.name;

                        let card_body_row_1_col_1_row = document.createElement('div');
                        card_body_row_1_col_1_row.className = 'row';
                        card_body_row_1_col_2.append(card_body_row_1_col_1_row);


                        let card_body_row_1_col_1_row_col_1 = document.createElement('div');
                        card_body_row_1_col_1_row_col_1.className = 'col-md';
                        card_body_row_1_col_1_row.append(card_body_row_1_col_1_row_col_1);

                        let card_body_row_1_col_1_row_col_2 = document.createElement('div');
                        card_body_row_1_col_1_row_col_2.className = 'col-md-1';
                        card_body_row_1_col_1_row.append(card_body_row_1_col_1_row_col_2);


                        let span = document.createElement('span');
                        card_body_row_1_col_1_row_col_1.append(span)
                        span.className = 'float-end text-end';
                        span.innerText = obj.city.city;

                        let img_location = document.createElement('img');
                        img_location.src = 'static/media/images/map.png';
                        img_location.style.width = '20px';

                        card_body_row_1_col_1_row_col_2.append(img_location);
                        // console.log(obj);

                        let card_body_row_2 = document.createElement('div');
                        card_body_row_2.className = 'row mt-1';
                        card_body.append(card_body_row_2);

                        let card_body_row_2_col_1 = document.createElement('div');
                        card_body_row_2_col_1.className = 'col-md-1';
                        card_body_row_2.append(card_body_row_2_col_1)

                        let clock_img = document.createElement('img');
                        clock_img.style.width = '20px';
                        clock_img.className = 'float-end mt-1';
                        clock_img.src = 'static/media/images/clock.png'
                        card_body_row_2_col_1.append(clock_img);

                        let card_body_row_2_col_2 = document.createElement('div');
                        card_body_row_2_col_2.className = 'col-md';
                        card_body_row_2.append(card_body_row_2_col_2)

                        let h4 = document.createElement('h4');
                        h4.innerText = obj.openingTime + ' to ' + obj.closingTime;
                        card_body_row_2_col_2.append(h4);

                        let card_body_row_2_col_3 = document.createElement('div');
                        card_body_row_2_col_3.className = 'col-md-3';
                        card_body_row_2.append(card_body_row_2_col_3);

                        let card_body_row_2_col_3_row = document.createElement('div');
                        card_body_row_2_col_3_row.className = 'row';
                        card_body_row_2_col_3.append(card_body_row_2_col_3_row);

                        let card_body_row_2_col_3_row_col_1 = document.createElement('div');
                        card_body_row_2_col_3_row_col_1.className = 'col-md';
                        card_body_row_2_col_3_row.append(card_body_row_2_col_3_row_col_1);

                        let card_body_row_2_col_3_row_col_2 = document.createElement('div');
                        card_body_row_2_col_3_row_col_2.className = 'col-md-2';
                        card_body_row_2_col_3_row.append(card_body_row_2_col_3_row_col_2);

                        let span_contact = document.createElement('span');
                        card_body_row_2_col_3_row_col_1.append(span_contact);
                        span_contact.innerText = obj.contact;
                        span_contact.className = 'float-end';

                        let phone_img = document.createElement('img');
                        phone_img.src = 'static/media/images/phone.png';
                        phone_img.style.width = '20px';
                        phone_img.className = 'float-end';
                        card_body_row_2_col_3_row_col_2.append(phone_img);



                        let card_body_row_3 = document.createElement('div');
                        card_body_row_3.className = 'row mt-4';
                        card_body.append(card_body_row_3);

                        card_body_row_3.innerHTML = '<h2>Details</h2><br><p>' + obj.details + '</p>';

                        let card_body_row_4 = document.createElement('div');
                        card_body_row_4.className = 'row mt-4';
                        card_body.append(card_body_row_4);

                        card_body_row_4.innerHTML = '<h3>Late Fine:</h3><br><p>' + obj.lateFine + '</p>';

                        let card_body_row_5 = document.createElement('div');
                        card_body_row_5.className = 'row mt-2';
                        card_body.append(card_body_row_5);

                        let card_body_row_5_col_1 = document.createElement('div');
                        card_body_row_5_col_1.className = 'col-md';
                        card_body_row_5.append(card_body_row_5_col_1);

                        let button = document.createElement('button');
                        button.className = 'btn btn-info id';
                        button.innerText = 'Join now'
                        button.id = obj.libraryId;
                        card_body_row_5_col_1.append(button);

                    }



                } catch (error) {
                    console.log(error);
                }
            }


        };

        let debounceFunc = function (func, delay) {
            let timer;
            return function () {
                if (timer)
                    clearTimeout(timer);
                timer = setTimeout(func, delay)
            }
        }
        let optimizeFunc = debounceFunc(search_lib_func, 800);
        library_search.addEventListener('keyup', () => {
            optimizeFunc();
        });

    </script>

    <script>

        window.addEventListener('click', (e) => {
            if(e.target.tagName === 'BUTTON'){
                let id = e.target.id;
                let par = 'library_id='+id ;
                async function sendApproveRequest() {   
                    let response = await fetch('request.do?'+par);
                    let flag = await response.text();
                    if(flag){
                        e.target.innerText = 'requested';

                        localStorage.setItem('button_style'+e.target.id,id);
                        localStorage.setItem('style',e.target.innerText);
                        console.log(localStorage.getItem('button_style')+"########");
                    } else{

                    }
                }
                if(!(
                    console.log(localStorage.getItem('button_style' ) )=== e.target.id)){
                    sendApproveRequest();
                    console.log('if');
                }else{
                    window.addEventListener('load',()=>{
                        // e.target.innerText = console.log(localStorage.getItem('style'));
                        console.log('else');
                    });
                }



                
            }
        });

    </script>
    <script src="https://unpkg.com/dropzone@5/dist/min/dropzone.min.js"></script>




</body>

</html>