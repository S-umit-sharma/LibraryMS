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
        String memberId = request.getParameter("member_id");
        Integer bookIssued = Integer.parseInt(request.getParameter("book_issued"));
        System.out.println(bookIssued);
        Integer bookEditonId = Integer.parseInt(request.getParameter("book_edition_id"));
        // ------------------get records from issuedBooks ---------
        IssuedBook member = new IssuedBook(new MemberShip(memberId), new BookEdition(bookEditonId));
        System.out.println("######################1");
        
        member.returnBook();
        System.out.println("######################2");
        // -----------------calculating fine ---------
        Long d = 0L; 
        try{

            d = DateUtil.getDateDifferenc(member.getReturnDate());
            System.out.println("######################3");
        }catch(Exception e){
            e.printStackTrace();

        }
        
        
        // ----------------- updating fine ---------
        if (d > 0) {
            System.out.println("######################4");
            
            Integer lateFine = lib.getLateFine();
            System.out.println("######################5");
            
            Integer fine = Integer.parseInt("" + d * lateFine + member.getFine());
            System.out.println("######################6");
            
            member.setFine(fine);
            System.out.println("######################7");
            member.updateFine();
            System.out.println("######################8");
        }
        
        // ----------------- updating books ----------
        boolean flag = member.deleteIssuedBook();
        System.out.println("######################9");
        
        if (flag) {
            System.out.println("######################10");
            LibraryBooks libraryBooks = new LibraryBooks(new BookEdition(bookEditonId),bookIssued);
            System.out.println("######################11");
            libraryBooks.updateBookCopies();
            System.out.println("######################12");
        }
        System.out.println("######################13");

        Gson gson = new Gson();

        String json = gson.toJson(flag);

        response.getWriter().print(json);
    }
}
