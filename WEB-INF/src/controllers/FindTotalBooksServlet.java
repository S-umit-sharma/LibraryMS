package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import models.BookEdition;
import models.Library;
import models.LibraryBooks;

@WebServlet("/find_total_books.do")
public class FindTotalBooksServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        Integer edition_id = Integer.parseInt(request.getParameter("book_edition_id"));
        HttpSession session = request.getSession();
        Library lib = (Library) session.getAttribute("user");
        LibraryBooks libBooks = new LibraryBooks();
        libBooks.setBookEditionId(new BookEdition(edition_id));
        libBooks.setLibraryId(lib);

        libBooks.BookInfo();

        Gson gson = new Gson();

        String json = gson.toJson(libBooks);

        response.getWriter().print(json);

    }
}
