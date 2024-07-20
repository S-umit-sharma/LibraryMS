package controllers;

import java.io.IOException;
import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;

import models.User;
import models.UserType;

@WebServlet("/logo.do")
public class LogoServlet extends HttpServlet {
    public void doGet(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
        HttpSession session = request.getSession();
        ServletContext context = getServletContext();
        User user = (User)session.getAttribute("user");
        Integer userTypeId = Integer.parseInt(request.getParameter("user_type_id"));
        
        String path=null;
        if(user != null){
            try{
                path = context.getRealPath("/WEB-INF/uploads/"+UserType.userTypes[userTypeId - 1].toLowerCase()+"/"+user.getEmail()+"/logo");
            }catch(Exception e){
                e.printStackTrace();
            }
            File file = new File(path);
            String[] list = file.list();

            InputStream is = context.getResourceAsStream("/WEB-INF/uploads/"+UserType.userTypes[userTypeId-1].toLowerCase()+"/"+user.getEmail()+"/logo/"+list[0]);

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
