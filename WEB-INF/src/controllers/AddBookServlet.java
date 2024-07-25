package controllers;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Book;
import models.Category;
import models.Publisher;

// import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/book.do")
public class AddBookServlet extends HttpServlet {
    // showing books
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Publisher publisher = (Publisher) session.getAttribute("user");
        String nextPage = "login.do?user_type_id=2";
        Book book = new Book(publisher);
        ArrayList<Book> books = book.collectAllBooks(publisher.getPublisherId());

        if (publisher != null) {
            nextPage = "publisher_dashboard.jsp";
            request.setAttribute("books", books);

            request.setAttribute("record_size", books.size());
        }

        request.getRequestDispatcher(nextPage).forward(request, response);
    }

    // add books
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
        if (Boolean.parseBoolean(request.getParameter("flag"))) {
            doGet(request, response);
        } else {
            HttpSession session = request.getSession();
            // ServletContext context = getServletContext();
            Publisher publisher = (Publisher) session.getAttribute("user");

            Integer bookCategory = Integer.parseInt(request.getParameter("book_category"));
            String bookTitle = request.getParameter("book_title");

            Book book = new Book(bookTitle, new Category(bookCategory), new Publisher(publisher.getPublisherId()));
            boolean flag = book.saveBook();

            request.setAttribute("flag", flag);
            doGet(request, response);

        }

    }
}
