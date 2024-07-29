package controllers;

import java.io.IOException;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

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

        MemberShip member = new MemberShip();
        member.setUserId(userId);
        member.setLibrary(lib);
        boolean flag = member.checkUserAvailabilityForAdd();
        // System.out.println(member.getMemberId() + "########");
        // System.out.println(flag + "#########");
        Gson gson = new Gson();
        String json = "";

        if (flag) {
            Date currentDate = DateUtil.getCurrentDate();

            num += 1;

            Integer memberId = Integer.parseInt(libraryId + "" + userId + "" + num);

            member.setLibrary(new Library(libraryId));

            member.setMemberId(memberId);

            member.setJoinedOn(currentDate);

            member.saveMemberShip();

            member.collectMember();

            Map<String,Object> obj = new HashMap<>();
            obj.put("flag",flag);
            obj.put("member",member);

            json = gson.toJson(obj);

        } else  {

            Map<String, Object> obj = new HashMap<>();
            obj.put("flag", flag);
            obj.put("member", member);

            json = gson.toJson(obj);
        }

        response.getWriter().print(json);

    }
}
