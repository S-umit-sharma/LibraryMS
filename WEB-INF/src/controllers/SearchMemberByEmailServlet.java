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
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String email = request.getParameter("email");
        User user = new User(email);

        boolean flag = user.searchEmail();
        Integer userTypeId = 0;
        if (flag) {
            userTypeId = user.getUserType().getUserTypeId();
        }

        Gson gson = new Gson();

        if (userTypeId == 3) {
            String json = gson.toJson(user);
            response.getWriter().print(json);
        } else {
            flag = true;
            String json = gson.toJson(flag);
            response.getWriter().print(json);

        }
    }
}
