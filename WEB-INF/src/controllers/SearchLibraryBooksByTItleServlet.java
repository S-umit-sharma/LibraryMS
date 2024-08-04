package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import models.Book;
import models.BookEdition;
import models.Library;
import models.LibraryBooks;

@WebServlet("/search_books_in_library.do")
public class SearchLibraryBooksByTItleServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
        Library lib = (Library)request.getSession().getAttribute("user");
            
    
        String title = request.getParameter("title");

        LibraryBooks books = new LibraryBooks(new BookEdition(new Book(title)));

        ArrayList<LibraryBooks> list = books.searchBookInLibrary(lib.getLibraryId());

        Gson gson = new Gson();

        String json = gson.toJson(list);

        response.getWriter().print(json);

    }
}
