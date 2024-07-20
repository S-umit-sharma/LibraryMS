<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Library</title>
</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col">
                <%@ include file="Navbar.jsp" %>
            </div>
        </div>
        <div class="tab-content">
            <div class="tab-pane fade show active" id="book_edition_pane">

                <c:forEach var="edition" items="${book_editions}" varStatus="n">
                    <c:if test="${(n.count-1)%4==0}">
                        <div class="row justify-content-around mt-3">
                    </c:if>
                    <div class="col-md mt-4">
                        <div class="card shadow p-3 mb-5 bg-body-tertiary rounded" style="width:15rem;">

                            <c:choose>
                                <c:when test="${empty edition.bookEditionPic}">
                                    <img src="static/media/images/book.png" class="card-img-top" width="100"
                                        height="250">
                                </c:when>
                                <c:otherwise>
                                    <img src="show_edition_img.do?path=${edition.bookEditionPic}" width="100"
                                        height="250" class="card-img-top">
                                </c:otherwise>
                            </c:choose>

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
                            </div>
                                <div class="card-footer">
                                    <button id="${edition.bookEditionId}" class="btn btn-outline-primary button">&plus;Add</button>
                                </div>

                        </div>
                    </div>
                    <c:if test="${n.count%4==0}">
            </div>

            </c:if>
            </c:forEach>
        </div>

    </div>
</body>

</html>