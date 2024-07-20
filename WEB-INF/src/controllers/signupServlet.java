package controllers;

import models.City;
import models.User;
import models.UserType;
import models.Gender;

import utils.GenrateCode;
import utils.MessageTemplate;
import utils.AppUtils;
import utils.EmailSender;
import utils.EmailTemplates;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletContext;

import java.sql.Date;

import java.util.ArrayList;

@WebServlet("/signup.do")
public class signupServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        Integer userTypeId = Integer.parseInt(request.getParameter("user_type_id"));
        request.getRequestDispatcher("signup.jsp?user_type_id="+userTypeId).forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ServletContext context = getServletContext();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Date dob = Date.valueOf(request.getParameter("dob"));
        String city = request.getParameter("city");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
        Integer gender = Integer.parseInt(request.getParameter("gender"));
        Integer userTypeId = Integer.parseInt(request.getParameter("user_type_id"));

        // ----------------------- seprating cities and states ------------------------

        ArrayList<City> cities = (ArrayList<City>) getServletContext().getAttribute("cities");

        // -----------------------------------------------------------------------------
        String verificationCode = GenrateCode.genrateCode();
        String subject = " welcom to lms";
        User user = new User(name, email, password, dob, AppUtils.getCity(cities, city), contact, address,
                new Gender(gender), new UserType(userTypeId), verificationCode);

        String emailContent = EmailTemplates.genrateWelcomeMail(name, email, verificationCode,userTypeId);
        EmailSender.sendEmail(email, subject, emailContent);

        if (user.saveUser()) {
            String userTypeFolderPath = context
                    .getRealPath("/WEB-INF/uploads/" + UserType.userTypes[userTypeId - 1].toLowerCase());
            File file = new File(userTypeFolderPath, email);
            file.mkdir();
        }
        String signupSuccessMessage = MessageTemplate.getSignupSuccessMessage();
        response.sendRedirect("success.jsp?color=alert-success&status_id=1&user_type_id="+userTypeId+"&message="+signupSuccessMessage);
    }
}
