package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import models.MemberShip;

@WebServlet("/payment.do")
public class PaymentServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
        Integer memberId = Integer.parseInt(request.getParameter("member_id"));
        Integer paymentAmount = Integer.parseInt(request.getParameter("payment_amount"));

        MemberShip memberShip = new MemberShip();
        memberShip.setMemberId(memberId);

        memberShip.currentDues();

        boolean flag = memberShip.payment(paymentAmount);

        response.getWriter().print(flag);

    }
}
