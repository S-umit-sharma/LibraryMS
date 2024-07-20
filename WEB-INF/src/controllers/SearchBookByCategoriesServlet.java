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

@WebServlet("/search_category.do")
public class SearchBookByCategoriesServlet extends HttpServlet {
    public void doGet(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
        Integer category_id = Integer.parseInt(request.getParameter("category_id"));

        Book book = new Book(new Category(category_id));
        System.out.println(book);
        ArrayList<Book> books = (ArrayList<Book>)book.searchByCategory();
        
        request.setAttribute("books", books);

        request.getRequestDispatcher("library_dashboard.jsp").forward(request,response);
    }
}
