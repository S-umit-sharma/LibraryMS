<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Edition details</title>
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
                <form action="update_book_edition.do" method="post">
                    <input type="hidden" name="book_id" value="${Edition.book.getBookId()}">
                    <input type="hidden" name="book_edition_id" value="${Edition.bookEditionId}">
                    <input type="hidden" name="num" value="1">
                        <div>
                            <label for="isbn_no" class="form-label fs-3">Isbn No</label>
                            <input type="number" name="isbn_no" class="form-control" id="isbn_no" value="${Edition.isbnNo}">
                        </div>
                        <div>
                            <label for="book_edition" class="form-label fs-3">Edition</label>
                            <input type="number" name="edition" class="form-control" id="book_edition"  value="${Edition.edition}">
                        </div>
                        <div>
                            <label for="publish_date" class="form-label fs-3">Published Date</label>
                            <input type="date" name="publish_date" class="form-control" id="publish_date"  value="${Edition.publishedOn}">
                        </div>
                        <div>
                            <label for="price" class="form-label fs-3">Price</label>
                            <input type="number" name="price" class="form-control" id="price" value="${Edition.price}">
                        </div>
                        <div>
                            <label for="details" class="form-label fs-3">More Details</label>
                            <textarea type="text" rows="7" col="70" name="more_details" id="details"
                            class="form-control">${Edition.details}"</textarea>
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary mt-4">&plus;Update</button>
                        </div>
                    
                </form>
            </div>
        </div>
    </div>
</body>
</html>