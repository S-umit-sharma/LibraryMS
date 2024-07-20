package controllers;

import java.io.File;
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
import models.UserType;

@WebServlet("/show_book_logo.do")
public class ShowBookLogoServlet extends HttpServlet {
    public void doGet(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
        HttpSession session = request.getSession();
        ServletContext context = getServletContext();
        Publisher publisher = (Publisher)session.getAttribute("user");
        Integer bookId = Integer.parseInt(request.getParameter("book_id"));

        String path=null;
        if(publisher != null){
            try{
                path = context.getRealPath("/WEB-INF/uploads/publishers/"+publisher.getEmail()+"/book_image");
            }catch(Exception e){
                e.printStackTrace();
            }
            File file = new File(path);
            String[] list = file.list();
            Book book = new Book(bookId);
            // ---------------------------------------------------------
            String imgPath = book.getImagePath();
            
            
            // ---------------------------------------------------------
            InputStream is = context.getResourceAsStream("/WEB-INF/uploads/publishers/"+imgPath);
            
            OutputStream os = response.getOutputStream();

            byte[] arr = new byte[256];

            int count = 0;
            while((count=is.read(arr)) != -1){
                os.write(arr);
            }

            os.flush();
            os.close();
        }


    }
}
