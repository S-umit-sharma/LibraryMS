package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import models.BookEdition;
import models.IssuedBook;
import models.Library;
import models.LibraryBooks;
import models.MemberShip;
import utils.DateUtil;

@WebServlet("/return_book.do")
public class ReturnBookServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        HttpSession session = request.getSession();
        Library lib = (Library) session.getAttribute("user");
        Integer memberId = Integer.parseInt(request.getParameter("member_id"));
        Integer bookIssued = Integer.parseInt(request.getParameter("book_issued"));
        System.out.println(bookIssued);
        Integer bookEditonId = Integer.parseInt(request.getParameter("book_edition_id"));
        // ------------------get records from issuedBooks ---------
        MemberShip memebership = new MemberShip();
        memebership.setMemberId(memberId);
        IssuedBook member = new IssuedBook(memebership, new BookEdition(bookEditonId));
        
        member.returnBook();
        // -----------------calculating fine ---------
        Long d = 0L; 
        try{

            d = DateUtil.getDateDifferenc(member.getReturnDate());
        }catch(Exception e){
            e.printStackTrace();

        }
        
        
        // ----------------- updating fine ---------
        if (d > 0) {
            
            Integer lateFine = lib.getLateFine();
            
            Integer fine = Integer.parseInt("" + d * lateFine + member.getFine());
            
            member.setFine(fine);
            member.updateFine();
        }
        
        // ----------------- updating books ----------
        boolean flag = member.updateIssuedBook();
        
        if (flag) {
            LibraryBooks libraryBooks = new LibraryBooks(new BookEdition(bookEditonId),bookIssued);
            libraryBooks.updateBookCopies();
        }

        Gson gson = new Gson();

        String json = gson.toJson(flag);

        response.getWriter().print(json);
    }
}
