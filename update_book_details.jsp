<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col">
                <%@ include file="Navbar.jsp" %>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col">
                <form action="update_book.do" method="post"> 
                    <input type="hidden" name="publisher_id" value="${book.publisher.getPublisherId()}">                   
                    <input type="hidden" name="book_id" value="${book.bookId}">                   
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
                            <input type="text" name="book_title" class="form-control fs-3" id="book_title" value="${book.title}">
                        </div>

                        <div class="mt-4">
                            <input type="submit" class="btn btn-primary" value="Update" id="submit_button">
                        </div>
                    </form>
                
            </div>
        </div>
    </div>
</body>
</html>