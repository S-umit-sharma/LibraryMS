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
import models.Category;

@WebServlet("/search_title.do")
public class SearchBookByTitle extends HttpServlet {
    public void doGet(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
        String title = request.getParameter("title");
        // System.out.println(title);

        Book book = new Book(title);
        ArrayList<Book> books = (ArrayList<Book>)book.searchByTitle();
        System.out.println(books + "####");
        
        request.setAttribute("books", books);

        request.getRequestDispatcher("library_dashboard.jsp").forward(request,response);
    }
}
