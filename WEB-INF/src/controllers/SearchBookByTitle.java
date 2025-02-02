package controllers;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import models.Book;

@WebServlet("/search_title.do")
public class SearchBookByTitle extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String title = request.getParameter("title");

        Book book = new Book(title);
        ArrayList<Book> books = (ArrayList<Book>) book.searchByTitle();

        Gson gson = new Gson();

        String json = gson.toJson(books);

        response.getWriter().print(json);

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

    }
}
