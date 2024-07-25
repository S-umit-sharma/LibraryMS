package controllers;

import models.Library;

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

@WebServlet("/library_logo_upload.do")
public class LibraryLogoUploadServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        ServletContext context = getServletContext();
        Library library = (Library) session.getAttribute("library");
        // System.out.println(library);
        if (library != null) {
            if (ServletFileUpload.isMultipartContent(request)) {
                try {

                    DiskFileItemFactory dfif = new DiskFileItemFactory();
                    ServletFileUpload sf = new ServletFileUpload(dfif);
                    List<FileItem> items = sf.parseRequest(request);
                    FileItem item = items.get(0);
                    
                    String fileName = "logo." + item.getName().split("\\.")[1];

                    library.setProfilePic("libraries/"+library.getEmail()+"/logo/"+fileName);
                    String uploadPath = context.getRealPath("/WEB-INF/uploads/libraries/"+ library.getEmail()+"/logo");
                    
                    library.saveProfilePic();

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
