package controllers;

import java.io.IOException;
import java.io.File;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;

import java.util.List;

import models.BookEdition;
import models.BookEditionPic;
import models.Publisher;

@WebServlet("/book_edition_logo_upload.do")
public class BookEditionLogoUploadServlet extends HttpServlet {
    static int i = 1;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        Publisher pub = (Publisher) session.getAttribute("user");
        ServletContext context = getServletContext();
        Boolean flag = ServletFileUpload.isMultipartContent(request);
        BookEditionPic bookEditionPic = new BookEditionPic();

        BookEdition bookEdition = new BookEdition();
        String title = null;

        if (flag) {
            try {
                List<FileItem> fileItems = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);

                for (FileItem fileItem : fileItems) {
                    if (fileItem.isFormField()) {
                        String fieldName = fileItem.getFieldName();
                        Integer fieldValue = Integer.parseInt(fileItem.getString());

                        switch (fieldName) {
                            case "edition_id":
                                bookEdition.setBookEditionId(fieldValue);
                                title = bookEdition.collectTitle();
                                bookEditionPic.setBookEdition(bookEdition);
                                break;
                        }
                    } else {

                        Integer edtion_number = bookEdition.getEdition();
                        String uploadPath = context.getRealPath("/WEB-INF/uploads/publishers/" + pub.getEmail() + "/"
                                + title + "/" + edtion_number + "_edition/");
                        File folder = new File(uploadPath);
                        folder.mkdir();
                        String fileName = i + "." + fileItem.getName().split("\\.")[1];

                        String filePath = pub.getEmail() + "/" + title + "/" + edtion_number + "_edition/";
                        bookEditionPic.setEditionImgPath(filePath + fileName);
                        bookEditionPic.saveEditionImage();
                        bookEdition.changeImageStatus();

                        File file = new File(uploadPath, fileName);

                        try {
                            fileItem.write(file);
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        i++;
                    }

                }

            } catch (FileUploadException e) {
                e.printStackTrace();
            }
        }
        request.getRequestDispatcher("book_edition.jsp").forward(request, response);
    }
}
