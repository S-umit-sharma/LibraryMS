package controllers;

import java.io.IOException;
import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import models.Publisher;

@WebServlet("/show_edition_img.do")
public class ShowBookEditionLogo extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        String path = request.getParameter("path");
        System.out.println(path);
        ServletContext context = getServletContext();

        InputStream is = context.getResourceAsStream("/WEB-INF/uploads/publishers/" + path);
        OutputStream os = response.getOutputStream();

        byte[] arr = new byte[256];
        int count = 0;
        while ((count = is.read(arr)) != -1) {
            os.write(arr);
        }

        os.flush();
        os.close();

    }
}
