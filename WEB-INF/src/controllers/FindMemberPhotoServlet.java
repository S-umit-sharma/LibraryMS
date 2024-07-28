package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.MemberShip;
import com.google.gson.Gson;

@WebServlet("/member_photo_find.do")
public class FindMemberPhotoServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer memberId = Integer.parseInt(request.getParameter("member_id"));

        MemberShip member = new MemberShip();
        member.setMemberId(memberId);

        member.collectPhoto();

        Gson gson = new Gson();

        String json = gson.toJson(member);

        response.getWriter().print(json);
    }
}
