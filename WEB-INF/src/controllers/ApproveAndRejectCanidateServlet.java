package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Library;
import models.Request;
import models.Status;
import models.User;

@WebServlet("/approve_reject.do")
public class ApproveAndRejectCanidateServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException{
        HttpSession session = request.getSession();
        Library lib = (Library)session.getAttribute("user");

        Integer userId = Integer.parseInt(request.getParameter("user_id"));
        Integer statusId = Integer.parseInt(request.getParameter("status_id"));
        
        Request req = new Request();
        req.setLibrary(lib);
        User u = new User();
        u.setUserId(userId);
        req.setUser(u);
        req.setStatus(new Status(statusId));

        Boolean flag = req.changeStatus();

        response.getWriter().print(flag);
    }
}
