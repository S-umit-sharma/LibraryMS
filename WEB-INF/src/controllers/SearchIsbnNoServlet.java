package controllers;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.annotation.WebServlet;

import com.google.gson.Gson;

import models.BookEdition;
import models.BookEditionPic;
import models.Library;
import models.LibraryBooks;

@WebServlet("/search_isbn_no.do")
public class SearchIsbnNoServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        HttpSession session = request.getSession();

        Library lib = (Library) session.getAttribute("user");

        Integer isbnNo = Integer.parseInt(request.getParameter("isbn_no"));

        LibraryBooks libBooks = new LibraryBooks(lib);

        boolean flag = libBooks.searchIsbnNo(isbnNo);

        Gson gson = new Gson();
        Map<String, Object> map = new HashMap<>();
        map.put("flag",flag);
        map.put("libBooks",libBooks);
        if (flag) {

            Integer id = libBooks.getBookEditionId().getBookEditionId();

            BookEditionPic bookEditionPic = new BookEditionPic();
            bookEditionPic.setBookEdition(new BookEdition(id));

            String path = bookEditionPic.getEditionImageForIsbn();

            map.put("path", path);
        }


        String json = gson.toJson(map);

        response.getWriter().print(json);

    }

}