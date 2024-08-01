package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;

import com.google.gson.Gson;

import models.Library;
import models.LibraryBooks;

@WebServlet("/search_isbn_no.do")
public class SearchIsbnNoServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException,ServletException{
    
        HttpSession session = request.getSession();

        Library lib = (Library)session.getAttribute("user");
    
        Integer isbnNo = Integer.parseInt(request.getParameter("isbn_no"));
        

        LibraryBooks libBooks = new LibraryBooks(lib);

        libBooks.searchIsbnNo(isbnNo);

        Gson gson = new Gson();

        String json = gson.toJson(libBooks);

        response.getWriter().print(json);

    }
        
}