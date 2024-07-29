package controllers;

import java.io.File;
import java.io.IOException;
import java.util.List;

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

import models.MemberShip;

@WebServlet("/candidate_logo_upload.do")
public class CandidateLogoUploadServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ServletContext context = getServletContext();
        HttpSession session = request.getSession();
        MemberShip memberShip = (MemberShip) session.getAttribute("user");

        if (memberShip != null) {
            try {
                if (ServletFileUpload.isMultipartContent(request)) {

                    ServletFileUpload sfu = new ServletFileUpload(new DiskFileItemFactory());
                    List<FileItem> file = sfu.parseRequest(request);
                    FileItem item = file.get(0);

                    String fileName = "logo." + item.getName().split("\\.")[1];
                    String fullName = "candidates/" + memberShip.getEmail() + "/logo/" + fileName;
                    memberShip.setProfilePic(fullName);
                    String uploadPath = context
                            .getRealPath("/WEB-INF/uploads/candidates/" + memberShip.getEmail() + "/logo");
                    memberShip.saveProfilePic();
                    File folder = new File(uploadPath);
                    folder.mkdirs();
                    File f = new File(uploadPath,fileName);

                    try{item.write(f);}catch(Exception e){e.printStackTrace();  }
                }
            } catch (FileUploadException e) {
                e.printStackTrace();
            }

        }
    }
}
