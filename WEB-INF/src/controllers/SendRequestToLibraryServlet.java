package controllers;

import java.io.IOException;
import java.lang.reflect.Member;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import models.Library;
import models.MemberShip;
import models.Request;
import models.User;

@WebServlet("/request.do")
public class SendRequestToLibraryServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer library_id = Integer.parseInt(request.getParameter("library_id"));

        MemberShip user = (MemberShip)request.getSession().getAttribute("user");
        
        if(user != null){
            Library lib = new Library();
            lib.setLibraryId(library_id);

            Request r = new Request(lib,user);
            boolean flag = r.sendJoinRequest(); 

            response.getWriter().print(flag);
        }
    }
}
