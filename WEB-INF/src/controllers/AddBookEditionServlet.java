package controllers;

import java.io.IOException;

import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

import models.Book;
import models.BookEdition;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

@WebServlet("/book_edition.do")
public class AddBookEditionServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        Boolean flag = Boolean.parseBoolean(request.getParameter("flag"));
        if (flag) {

            doGet(request, response);
        } else {

            Integer isbnNo = Integer.parseInt(request.getParameter("isbn_no"));
            Integer bookId = Integer.parseInt(request.getParameter("book_id"));
            Integer edition = Integer.parseInt(request.getParameter("edition"));
            Date publishDate = Date.valueOf(request.getParameter("publish_date"));
            Integer price = Integer.parseInt(request.getParameter("price"));
            String details = request.getParameter("more_details");

            BookEdition bookEdition = new BookEdition(isbnNo, new Book(bookId), edition, publishDate, price, details);
            bookEdition.saveBookEdition();
            doGet(request, response);
        }

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        Integer bookId = Integer.parseInt(request.getParameter("book_id"));
        Integer num = Integer.parseInt(request.getParameter("num"));
        
        response.sendRedirect("dispatcher_edition.do?book_id=" + bookId + "&num=" + num);

    }

}
