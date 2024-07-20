package controllers;

import java.io.IOException;
import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Library;
import models.LibraryBooks;
import models.BookEdition;


@WebServlet("/save_book_into_library.do")
public class SaveBookInToLibraryServlet extends HttpServlet{
    public void doGet(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
        
        HttpSession session = request.getSession();
        Library lib = (Library)session.getAttribute("user");

        Integer editionId = Integer.parseInt(request.getParameter("edition_id"));
        Integer copy = Integer.parseInt(request.getParameter("copy"));
        
        LibraryBooks libBooks = new LibraryBooks(new BookEdition(editionId),copy,new Library(lib.getLibraryId()));
        boolean flag = libBooks.saveLibraryBooks();
         
        request.getRequestDispatcher("book_edition.do?num=2").forward(request, response);
         
    }
}
