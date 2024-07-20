package controllers;

import models.Library;
import models.Publisher;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;

import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;

import java.util.List;
import java.io.File;

import java.io.IOException;

@WebServlet("/publisher_logo_upload.do")
public class PublisherLogoUploadServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        ServletContext context = getServletContext();
        Publisher publisher = (Publisher) session.getAttribute("publisher");
        // System.out.println(publisher);
        if (publisher != null) {
            if (ServletFileUpload.isMultipartContent(request)) {
                try {

                    DiskFileItemFactory dfif = new DiskFileItemFactory();
                    ServletFileUpload sf = new ServletFileUpload(dfif);
                    List<FileItem> items = sf.parseRequest(request);
                    FileItem item = items.get(0);
                    
                    String fileName = "logo." + item.getName().split("\\.")[1];

                    publisher.setProfilePic(fileName);
                    String uploadPath = context.getRealPath("/WEB-INF/uploads/publishers/"+ publisher.getEmail()+"/logo");
                    File folder = new File(uploadPath);
                    folder.mkdir();
                    // System.out.println(publisher.getEmail()+ "Email of the publiaher 111111111111");

                    // System.out.println(uploadPath +"---------------######111111");
                    publisher.saveProfilePic();

                    File file = new File(uploadPath,fileName);

                    try{item.write(file); }catch(Exception e){e.printStackTrace();}
                } catch (FileUploadException e) {
                    e.printStackTrace();
                }
            }
        }else{
            // handle session invalidate
        }
    }
}
