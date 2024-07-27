package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.MemberShip;

@WebServlet("/remove_member.do")
public class RemoveMemberServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException,ServletException{
        Integer memberId = Integer.parseInt(request.getParameter("member_id"));

        MemberShip member = new MemberShip(memberId);

        
    }
}
