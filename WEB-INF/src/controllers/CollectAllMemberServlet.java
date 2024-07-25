package controllers;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

import models.Library;
import models.MemberShip;


import java.io.IOException;

import java.util.ArrayList;

import com.google.gson.Gson;

@WebServlet("/collect_all_member.do")
public class CollectAllMemberServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException,ServletException{

        HttpSession session = request.getSession();

        Library library = (Library)session.getAttribute("user");

        MemberShip member = new MemberShip(library);

        ArrayList<MemberShip> list = member.collectAllMembers();
        System.out.println(list);

        Gson gson = new Gson();

        String json = gson.toJson(list);

        response.getWriter().print(json);
    }
}
