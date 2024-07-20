// package controllers;

// import java.io.IOException;
// import java.util.ArrayList;

// import javax.servlet.ServletException;
// import javax.servlet.annotation.WebServlet;
// import javax.servlet.http.HttpServlet;
// import javax.servlet.http.HttpServletRequest;
// import javax.servlet.http.HttpServletResponse;
// import javax.servlet.http.HttpSession;

// import models.Library;
// import models.LibraryBooks;

// @WebServlet("/show_library_books.do")
// public class ShowLibraryBooksServlet extends HttpServlet {
//     public void doGet(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
//         HttpSession session = request.getSession();
//         Library lib = (Library)session.getAttribute("user"); 

//         LibraryBooks libBooks = new LibraryBooks(lib);

//         ArrayList<LibraryBooks> list = libBooks.fetchAllLibrayBooks();
//     }
// }
