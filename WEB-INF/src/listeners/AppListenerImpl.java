package listeners;

import javax.servlet.ServletContextListener;

import models.Category;
import models.City;
import java.util.ArrayList;
import utils.EmailSender;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

public class AppListenerImpl implements ServletContextListener {
    public void contextInitialized(ServletContextEvent ev){
        ServletContext context = ev.getServletContext();

        EmailSender.fromEmail = context.getInitParameter("from_email");
        EmailSender.fromPass = context.getInitParameter("from_email_password"); 
        System.out.println("------------------------");
        System.out.println("------ Welcome to LMS -----");
        System.out.println("------------------------");
        System.out.println("------------------------");
        System.out.println("------------------------");
        System.out.println("------------------------");

        ArrayList<City> cities = City.showCities();
        context.setAttribute("cities",cities);
        ArrayList<Category> categories = Category.showCategories();
        context.setAttribute("category",categories);
    }



    public void contextDestroyed(ServletContextEvent ev){
        
    }
}
