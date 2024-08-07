package controllers;

import java.io.IOException;

import java.util.Map;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import models.IssuedBook;

@WebServlet("/member_photo_for_issue.do")
public class MemberPhotoForIssueServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer memberId = Integer.parseInt(request.getParameter("member_id"));

        IssuedBook issuedBook = new IssuedBook();
        issuedBook.setMemberId(memberId);
        boolean flag = issuedBook.memberPhotoFindForIssue();

        Gson gson = new Gson();
        String json = "";
        Map<String, Object> map = new HashMap<>();
        map.put("flag", flag);
        if (flag)
            map.put("issued_book", issuedBook);
        json = gson.toJson(map);

        response.getWriter().print(json);
    }
}
