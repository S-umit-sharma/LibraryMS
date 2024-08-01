package controllers;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import models.MemberShip;
import utils.DateUtil;

@WebServlet("/remove_member.do")
public class RemoveMemberServlet extends HttpServlet{
    public void doGet(HttpServletRequest request, HttpServletResponse response)throws IOException,ServletException{
        
        Integer memberId = Integer.parseInt(request.getParameter("member_id"));
        
        
        Date leftOn = DateUtil.getCurrentDate();
        
        MemberShip member = new MemberShip(memberId,leftOn);
        
        
        int val = member.checkingForBooks();
        
        if(val==0){
            member.changeStatus();
        }
        
        
        Gson gson = new Gson();
        
        String json = gson.toJson(val);
        
        response.getWriter().write(json);
        
        
    }
}
