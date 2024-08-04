package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import java.util.ArrayList;
import models.City;
import models.Library;
import models.User;

@WebServlet("/library_search.do")
public class SearchLibraryByCityServlet extends HttpServlet{
    public void doGet(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
        // String city = request.getParameter("city");
        String library = request.getParameter("library");

        Library lib = new Library();
        System.out.println(library);
        lib.setName(library);

        ArrayList<Library> list = lib.collectLibraryByName();

        Gson gson = new Gson();

        String json = gson.toJson(list);

        response.getWriter().print(json);

    }
}