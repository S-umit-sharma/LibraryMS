package models;

import java.util.ArrayList;

import java.sql.SQLException;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class Category {
    // ############## properties ############## 
    
    private Integer categoryId;
    private String name;
    
    // ############## properties ############## 
    
    public Category(){
        
    }
    public Category(String name){
        this.name = name;
    }

    public Category(Integer categoryId){
        this.categoryId = categoryId;
    }

    public Category(Integer categoryId,String name){
        this.categoryId = categoryId;
        this.name = name;
    }
    
    // ############## method ############## 



    // ----------------------------------------------------------------------------------------------------------------------
        
    // ----------------------------------------------------------------------------------------------------------------------

    public boolean equals(Object obj){
        boolean flag = false;
        
        if(obj instanceof Category){
            Category n1 = this;
            Category n2 = (Category)obj;
            
            String nm1 = n1.name;
            String nm2 = n2.name;

            System.out.println();
            
            flag = nm1.equals(nm2);
        }
        
        return flag;
    }

    // ----------------------------------------------------------------------------------------------------------------------

    public static ArrayList<Category> showCategories(){
        ArrayList<Category> list = new ArrayList<>();

        try{ Class.forName("com.mysql.cj.jdbc.Driver"); }catch(ClassNotFoundException e){ e.printStackTrace(); }
        String query = "Select * from categories";

        try(Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");){

            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                list.add(new Category(rs.getInt(1),rs.getString(2)));
            }
        }catch(SQLException e){
            e.printStackTrace();
        }

        return list;
    }   

    // ############## get/set ############## 

    public void setCategoryId(Integer categoryId){
        this.categoryId = categoryId;
    }

    public Integer getCategoryId(){
        return categoryId;
    }

    public void setName(String name){
        this.name = name;
    }

    public String getName(){
        return name;
    }

}
