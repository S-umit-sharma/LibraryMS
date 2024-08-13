package controllers;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;

import java.util.List;

import models.Book;
import models.Publisher;

@WebServlet("/book_logo_upload.do")
public class BookLogoUploadServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        ServletContext context = getServletContext();
        Publisher pub = (Publisher) session.getAttribute("user");
        Book book = new Book();
        boolean flag = ServletFileUpload.isMultipartContent(request);

        if (flag) {
            try {
                List<FileItem> fileItems = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

                for (FileItem fileItem : fileItems) {
                    if (fileItem.isFormField()) {
                        String fieldName = fileItem.getFieldName();
                        Integer fieldValue = Integer.parseInt(fileItem.getString());

                        switch (fieldName) {
                            case "book_id":
                                book.setBookId(fieldValue);
                                book.findTitle();
                                break;
                        }
                    } else {
                        // int i =0;
                        String fileName = book.getBookId() + "." + fileItem.getName().split("\\.")[1];
                        String bookTitle = book.getTitle();
                        String newTitle = bookTitle.replace(" ","_");
                        String uploadPath = context.getRealPath("/WEB-INF/uploads/publishers/" + pub.getEmail() + "/"+ newTitle+"/");

                        File folder = new File(uploadPath);
                        
                        folder.mkdir();

                        book.setBookPic(pub.getEmail() + "/"+ newTitle+"/"+fileName);

                        File file = new File(uploadPath, fileName);

                        try {
                            fileItem.write(file);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }

                book.saveBookImage();
            } catch (FileUploadException e) {
                e.printStackTrace();
            }
        }
        request.getRequestDispatcher("publisher_dashboard.jsp").forward(request,response);
    }
}