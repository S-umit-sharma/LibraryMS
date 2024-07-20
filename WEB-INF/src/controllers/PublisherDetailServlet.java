package controllers;

import javax.servlet.http.HttpServlet;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import models.Publisher;

import java.io.IOException;

@WebServlet("/publisher_details.do")
public class PublisherDetailServlet extends HttpServlet {
    public void doPost(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
        String details = request.getParameter("details");
        String website = request.getParameter("website");

        String nextPage = "signin.jsp";
        HttpSession session = request.getSession();

        Publisher publisher = (Publisher)session.getAttribute("publisher");
        System.out.println(publisher);
        
        publisher.setDetails(details);
        publisher.setWebsite(website);

        boolean flag = publisher.savePublisherDetails();
        publisher.saveProfilePic();
        
        if(flag){
            nextPage = "publisher_dashboard.jsp";
        }

        response.sendRedirect(nextPage);
    }
}
