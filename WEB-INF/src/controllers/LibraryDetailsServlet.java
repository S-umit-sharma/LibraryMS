package controllers;

import models.Library;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;

import java.io.IOException;

import java.sql.Time;

@WebServlet("/library_details.do")
public class LibraryDetailsServlet extends HttpServlet {
    public void doPost(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
        HttpSession session = request.getSession();

        String about = request.getParameter("library_details");
        String website = request.getParameter("website");
        Time openingTime = Time.valueOf(request.getParameter("opening_time")+":00");
        Time closeingTime = Time.valueOf(request.getParameter("closeing_time")+":00");
        Integer bookIssueDays = Integer.parseInt(request.getParameter("book_issue_days"));
        Integer lateFine = Integer.parseInt(request.getParameter("late_fine"));
        Integer depositeAmount = Integer.parseInt(request.getParameter("deposite_amount"));

        Library library = (Library)session.getAttribute("library");

        library.setDetails(about);
        library.setWebsite(website);
        library.setOpeningTime(openingTime);
        library.setClosingTime(closeingTime);
        library.setBookIssueDays(bookIssueDays);
        library.setLateFine(lateFine);
        library.setDepositAmount(depositeAmount);

        library.saveDetails();
        library.saveProfilePic();

        response.sendRedirect("library_dashboard.jsp");
    }
}
