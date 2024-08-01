package controllers;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Book;
import models.Publisher;

@WebServlet("/show_book_logo.do")
public class ShowBookLogoServlet extends HttpServlet {
    public void doGet(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
        HttpSession session = request.getSession();
        ServletContext context = getServletContext();
        Publisher publisher = (Publisher)session.getAttribute("user");
        Integer bookId = Integer.parseInt(request.getParameter("book_id"));

        if(publisher != null){
            
            Book book = new Book(bookId);
            // ---------------------------------------------------------
            String imgPath = book.getImagePath();
            
            
            // ---------------------------------------------------------
            InputStream is = context.getResourceAsStream("/WEB-INF/uploads/publishers/"+imgPath);
            
            OutputStream os = response.getOutputStream();

            byte[] arr = new byte[256];

            while((is.read(arr)) != -1){
                os.write(arr);
            }

            os.flush();
            os.close();
        }


    }
}
