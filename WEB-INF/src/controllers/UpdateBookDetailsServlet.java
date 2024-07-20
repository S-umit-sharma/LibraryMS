package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Book;
import models.Category;
import models.Publisher;

@WebServlet("/update_book.do")
public class UpdateBookDetailsServlet extends HttpServlet {
    public void doGet(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
        Integer bookId = Integer.parseInt(request.getParameter("book_id"));
        Book book = new Book(bookId);
        book.fetchBookDetails();
        request.setAttribute("book",book);
        request.getRequestDispatcher("update_book_details.jsp").forward(request, response);
    }
    
    public void doPost(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
        Integer bookId = Integer.parseInt(request.getParameter("book_id"));
        Integer bookCategory = Integer.parseInt(request.getParameter("book_category"));
        Integer pubId = Integer.parseInt(request.getParameter("publisher_id"));
        String bookTitle = request.getParameter("book_title");


        Book book = new Book(bookId,bookTitle,new Category(bookCategory),new Publisher(pubId));

        book.updateBookDetails();
        request.getRequestDispatcher("book.do?flag=true").forward(request,response);       
    }
}

        
