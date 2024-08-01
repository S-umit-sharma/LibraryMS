package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/home_page.do")
public class ForwardLibraryPageServlet extends HttpServlet{
    public void doGet(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
        String nextPage = "login.do";
        if(request.getSession().getAttribute("user") != null)
            nextPage = "library_dashboard.jsp";
        request.getRequestDispatcher(nextPage).forward(request, response);
    }
}
