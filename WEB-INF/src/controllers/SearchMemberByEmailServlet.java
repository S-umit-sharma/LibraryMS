package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import models.User;

@WebServlet("/search_email.do")
public class SearchMemberByEmailServlet extends HttpServlet {
    public void doGet(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
        String email = request.getParameter("email");

        User user = new User(email);

        user.searchEmail();

        Gson gson = new Gson();
        
        String json = gson.toJson(user);

        response.getWriter().print(json);
    }
}
