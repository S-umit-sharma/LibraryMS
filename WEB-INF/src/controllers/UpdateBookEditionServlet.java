package controllers;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.Book;
import models.BookEdition;

@WebServlet("/update_book_edition.do")
public class UpdateBookEditionServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException,ServletException{
        Integer bookEditionId = Integer.parseInt(request.getParameter("book_edition_id"));

        BookEdition edition = new BookEdition(bookEditionId);
        edition.fetchAllDetails();
        request.setAttribute("Edition", edition);

        request.getRequestDispatcher("update_book_edition_details.jsp").forward(request, response);
    }
    
    public void doPost(HttpServletRequest request, HttpServletResponse response)throws IOException,ServletException{
        
        Integer isbnNo = Integer.parseInt(request.getParameter("isbn_no"));
        Integer bookId = Integer.parseInt(request.getParameter("book_id"));
        Integer editionId = Integer.parseInt(request.getParameter("book_edition_id"));
        Integer edition = Integer.parseInt(request.getParameter("edition"));
        Date publishDate = Date.valueOf(request.getParameter("publish_date"));
        Integer price =  Integer.parseInt(request.getParameter("price"));
        String details = request.getParameter("more_details");

        BookEdition bookEdition = new BookEdition(editionId,isbnNo,new Book(bookId),edition,publishDate,price,details);
        bookEdition.updateBookEdition();

        request.getRequestDispatcher("book_edition.do?flag=true").forward(request,response);
    }
}