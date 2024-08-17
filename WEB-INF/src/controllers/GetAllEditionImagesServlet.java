package controllers;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.BookEdition;
import models.BookEditionPic;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import com.google.gson.Gson;

@WebServlet("/getAllImages.do")
public class GetAllEditionImagesServlet extends HttpServlet {
    public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException,ServletException {
        Integer editionId = Integer.parseInt(request.getParameter("edition_id"));

        BookEditionPic pic = new BookEditionPic();
        BookEdition edition = new BookEdition();
        edition.setBookEditionId(editionId);

        pic.setBookEdition(edition);

        ArrayList<BookEditionPic> list  = (ArrayList<BookEditionPic>)pic.getAllImages();

        Gson gson = new Gson();

        String json = gson.toJson(list);

        response.getWriter().print(json);
    }
}
