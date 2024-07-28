package controllers;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.BookEdition;
import models.IssuedBook;
import models.Library;
import models.LibraryBooks;
import models.MemberShip;
import utils.DateUtil;

@WebServlet("/issue_book.do")
public class BookIssueServlet extends HttpServlet{
    public void doGet(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException {
        
        HttpSession session = request.getSession();

        Library lib = (Library)session.getAttribute("user");
        Integer editionId = Integer.parseInt(request.getParameter("edition_id"));
        Integer membershipId = Integer.parseInt(request.getParameter("member_id"));
        Integer libraryBookId = Integer.parseInt(request.getParameter("library_book_id"));
        Integer bookIssued = Integer.parseInt(request.getParameter("book_issued"));
        
        
        // ----------------------------------------------------

        // ----------------------------------------------------
        
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(DateUtil.getCurrentDate());
        calendar.add(Calendar.DATE,lib.getBookIssueDays());
        
        java.util.Date date = calendar.getTime();
        Date returnDate = new Date(date.getTime());
        
        // ----------------------------------------------------
        
        IssuedBook issuedBook = new IssuedBook(new BookEdition(editionId),new MemberShip(membershipId),DateUtil.getCurrentDate(),returnDate);
        
        boolean flag = issuedBook.issueBook();
        if(flag){
            LibraryBooks libraryBooks = new LibraryBooks(libraryBookId,bookIssued+1);
            libraryBooks.numberOfBooksIssued();
            }
        
        response.getWriter().print(flag);
    }
}