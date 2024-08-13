package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Library;
import models.MemberShip;
import models.Request;
import com.google.gson.Gson;

@WebServlet("/checkStatus.do")
public class CheckStatusServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException{
        HttpSession session = request.getSession();
        MemberShip member = (MemberShip)session.getAttribute("user");
        Integer libId = Integer.parseInt(request.getParameter("library_id"));

        Request req = new Request();
        req.setUser(member);
        req.setLibrary(new Library(libId));
        
        Boolean flag = req.collectAllRequestsInfo();

        response.getWriter().print(flag);
    }
}
