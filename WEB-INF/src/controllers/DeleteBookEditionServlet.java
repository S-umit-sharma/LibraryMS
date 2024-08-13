package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.BookEdition;

@WebServlet("/delete_book_edition.do")
public class DeleteBookEditionServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException,ServletException{
        Integer editionId = Integer.parseInt(request.getParameter("book_edition_id"));
        Integer bookId = Integer.parseInt(request.getParameter("book_id"));

        BookEdition e = new BookEdition(editionId);
        e.deleteAllBookEdition(2);
        request.getRequestDispatcher("book_edition.do?num=1&book_id="+bookId).forward(request, response);
    }
}
