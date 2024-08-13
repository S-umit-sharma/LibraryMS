package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import models.BookEdition;
import models.BookEditionPic;

@WebServlet("/showAllBookEditionImages.do")
public class showAllBookEditionImagesServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer bookId = Integer.parseInt(request.getParameter("book_id"));

        BookEditionPic pic = new BookEditionPic();
        BookEdition bookEdition = new BookEdition();
        bookEdition.setBookEditionId(bookId);
        pic.setBookEdition(bookEdition);

        ArrayList<BookEditionPic> list = pic.showAllBookEditionImages();

        request.setAttribute("edition_images",list);

        request.getRequestDispatcher("book_edition.jsp").forward(request,response);

    }
}