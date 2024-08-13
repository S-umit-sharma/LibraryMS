package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Book;
import models.BookEdition;

@WebServlet("/dispatcher_edition.do")
public class DispatcherForEditionServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer bookId = Integer.parseInt(request.getParameter("book_id"));
        Integer num = Integer.parseInt(request.getParameter("num"));

        BookEdition bookEdition = new BookEdition(new Book(bookId));
        ArrayList<BookEdition> editions = bookEdition.collectAllEditions();
        request.setAttribute("book_editions", editions);

        if (num == 1) {
            request.getRequestDispatcher("book_edition.jsp").forward(request, response);
        } else {
            String title = request.getParameter("title");
            request.setAttribute("title", title);
            request.getRequestDispatcher("library_book_edition.jsp?title=" + title).forward(request, response);
        }

    }
}
