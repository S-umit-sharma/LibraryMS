package controllers;

import models.User;
import models.UserType;
import models.Librarian;
import models.Library;
import models.MemberShip;
import models.Publisher;
import models.Status;
import utils.MessageTemplate;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSessionIdListener;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;

@WebServlet("/signin.do")
public class SigninServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
        request.setAttribute("user_type_id", request.getParameter("user_type_id"));
        request.getRequestDispatcher("signin.jsp").forward(request, response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Integer userTypeId = Integer.parseInt(request.getParameter("user_type_id"));
        
        String nextPage = "signin.jsp";
        
        if (userTypeId == 1) {
            Library lib = new Library(email, password);
            int res = lib.login();
            
            if (res == 1) {
                request.setAttribute("err_email_message", MessageTemplate.getIncorrectEmailMessage());
            } else if (res == 2) {
                request.setAttribute("err_password_message", MessageTemplate.getIncorrectPasswordMessage());
                
            } else if (res == 3) {
                Integer statusId = lib.getStatus().getStatusId();
                if (statusId == Status.ACTIVE) {
                    nextPage = "library_dashboard.jsp";
                    session.setAttribute("user", lib);
                } else if (statusId == Status.INACTIVE) {
                    String msg = MessageTemplate.getIncompleteEmailVerificationMessage(email);
                    nextPage = "success.jsp?color=alert-secondary&message=" + msg;
                } else if (statusId == Status.EMAIL_VERIFIED) {
                    String msg = MessageTemplate.getIncompleteManualVerificationMessage();
                    nextPage = "success.jsp?color=alert-secondary&message=" + msg;
                } else if (statusId == Status.MANUAL_VERIFIED) {
                    session.setAttribute("library", lib);
                    nextPage = "library_deatils.jsp";
                } else if (statusId == Status.BLOCKED) {

                } else if (statusId == Status.LEFT) {

                } else if (statusId == Status.WORKING) {

                } else if (statusId == Status.CLOSED) {

                }
            }

        } else if (userTypeId == 2) {

            Publisher pub = new Publisher(email, password);
            int res = pub.login();

            if (res == 1) {
                request.setAttribute("err_email_message", MessageTemplate.getIncorrectEmailMessage());
            } else if (res == 2) {
                request.setAttribute("err_password_message", MessageTemplate.getIncorrectPasswordMessage());
            } else if (res == 3) {
                Integer statusId = pub.getStatus().getStatusId();
                if (statusId == Status.ACTIVE) {
                    nextPage = "book.do";
                    session.setAttribute("user", pub);
                } else if (statusId == Status.INACTIVE) {
                    String msg = MessageTemplate.getIncompleteEmailVerificationMessage(email);
                    nextPage = "success.jsp?color=alert-secondary&message=" + msg;
                } else if (statusId == Status.EMAIL_VERIFIED) {
                    String msg = MessageTemplate.getIncompleteManualVerificationMessage();
                    nextPage = "success.jsp?color=alert-secondary&message=" + msg;
                } else if (statusId == Status.MANUAL_VERIFIED) {
                    session.setAttribute("publisher", pub);
                    nextPage = "publisher_details.jsp";
                } else if (statusId == Status.BLOCKED) {

                } else if (statusId == Status.LEFT) {

                } else if (statusId == Status.WORKING) {

                } else if (statusId == Status.CLOSED) {

                }
            }

        } else if (userTypeId == 3) {
            MemberShip member = new MemberShip(email, password);
            int res = member.login();

            if (res == 1) {
                request.setAttribute("err_email_message", MessageTemplate.getIncorrectEmailMessage());
            } else if (res == 2)
                request.setAttribute("err_password_message", MessageTemplate.getIncorrectPasswordMessage());
            else if (res == 3) {
                Integer statusId = member.getStatus().getStatusId();
                if (Status.ACTIVE == statusId) {
                    session.setAttribute("user", member);
                    nextPage = "candidate_dashboard.jsp";

                } else if (statusId == Status.INACTIVE) {
                    String msg = MessageTemplate.getIncompleteEmailVerificationMessage(email);
                    nextPage = "success.jsp?color=alert-secondary&message=" + msg;
                } else if (statusId == Status.MANUAL_VERIFIED) {
                    session.setAttribute("member",member);
                    nextPage = "candidate_upload_pic.jsp";
                }

            } else {
                Librarian librarian = new Librarian(email, password);
                int res1 = librarian.login();
                if (res1 == 1) {
                    request.setAttribute("err_email_message", MessageTemplate.getIncorrectEmailMessage());
                } else if (res1 == 2)
                    request.setAttribute("err_password_message", MessageTemplate.getIncorrectPasswordMessage());
                else if (res1 == 3) {
                    session.setAttribute("user", librarian);
                    nextPage = "librarian_dashboard.jsp";
                }

            }

        }
            request.getRequestDispatcher(nextPage).forward(request, response);
    }
}
