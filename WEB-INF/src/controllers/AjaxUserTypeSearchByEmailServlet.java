package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import com.google.gson.Gson;

import models.User;

@WebServlet("/search_for_usertype.do")
public class AjaxUserTypeSearchByEmailServlet extends HttpServlet{
    public void doGet(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException{
        Integer user_type_id=0;
        try{
            user_type_id = Integer.parseInt(request.getParameter("user_type_id"));
            
        }catch(Exception e){
            e.printStackTrace();
        }
        
        String email = request.getParameter("email");
        User user = new User();
        user.setEmail(email);
        user.searchEmail();
        
        boolean flag = false;
        
        if(user_type_id == user.getUserType().getUserTypeId()){
            flag = true;
        }
        
        Gson gson = new Gson();
        String json = gson.toJson(flag);
        response.getWriter().write(json);
    }

}
