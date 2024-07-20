package controllers;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;

import models.User;
import utils.EmailTemplates;
import utils.MessageTemplate;

import javax.servlet.ServletException;

import java.io.IOException;

@WebServlet("/email_verify.do")
public class verifyEmailServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String email = request.getParameter("email");
        String verificationCode = request.getParameter("verification_code");
        Integer userTypeId = Integer.parseInt(request.getParameter("user_type_id"));

        boolean flag = User.verify(email, verificationCode, userTypeId);

        String nextPage = "signin.jsp?user_type_id=" + userTypeId;

        if (userTypeId == 1 || userTypeId == 2) {

            nextPage = "success.jsp?color=alert-success&message="
                    + MessageTemplate.getEmailVerificationSuccessMessage();
        }
        request.getRequestDispatcher(nextPage).forward(request, response);
    }
}
