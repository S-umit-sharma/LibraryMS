package controllers;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;

import models.Library;
import models.MemberShip;
import utils.DateUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import com.google.gson.Gson;

@WebServlet("/add_candidate.do")
public class AddCandidateServlet extends HttpServlet {
    static Integer num = 0;
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Library lib = (Library) session.getAttribute("user");
        Integer libraryId = lib.getLibraryId();
        Integer userId = Integer.parseInt(request.getParameter("user_id"));
        Date currentDate = DateUtil.getCurrentDate();
        num += 1;
        String memberId = libraryId +""+ userId + "" + num;


        MemberShip member = new MemberShip(new Library(libraryId), userId, currentDate, memberId);

        member.saveMemberShip();
        member.collectMember();
        Gson gson = new Gson();

        String json = gson.toJson(member);
        response.getWriter().print(json);

    }
}
