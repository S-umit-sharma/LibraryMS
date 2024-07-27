// package controllers;

// import java.io.IOException;

// import javax.servlet.ServletException;
// import javax.servlet.annotation.WebServlet;
// import javax.servlet.http.HttpServlet;
// import javax.servlet.http.HttpServletRequest;
// import javax.servlet.http.HttpServletResponse;

// import com.google.gson.Gson;

// import java.util.ArrayList;
// import models.IssuedBook;

// @WebServlet("/history_of_issued_books.do")
// public class BookIssuedHistoryServlet extends HttpServlet{
//     public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException,ServletException{
//         IssuedBook issued = new IssuedBook();

        
//         ArrayList<IssuedBook> list = issued.collectAllIssuedBooks();

//         Gson gson = new Gson();

//         String json = gson.toJson(list);

//         response.getWriter().print(json);
         
//     }
// }
