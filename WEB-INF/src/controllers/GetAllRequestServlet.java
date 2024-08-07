package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;

import models.Library;
import models.Request;

@WebServlet("/get_all_request.do")
public class GetAllRequestServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Library lib = (Library)session.getAttribute("user");
        
        Request req = new Request();
        req.setLibrary(lib);

        ArrayList<Request> list = req.allRequests();

        Gson gson = new Gson();

        String json = gson.toJson(list);

        response.getWriter().print(json);
        
    }
}
