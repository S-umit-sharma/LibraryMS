package models;

import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

public class Publisher extends User{
    // ################ properties ################ 

    private Integer publisherId;
    private String details;
    private String website;

    // ################ properties ################ 
    
    public Publisher(){
        
    }

    public Publisher(String email,String password){
        super(email,password);
    }

    public Publisher(Integer publisherId){
        this.publisherId = publisherId;
    }
    
    // ################ methods ################ 
    
    // public static ArrayList<Publisher> showPublisher(){
    //     ArrayList<Publisher> list = new ArrayList<>();

    //     try{ Class.forName("com.mysql.cj.jdbc.Driver"); }catch(ClassNotFoundException e){ e.printStackTrace(); }
    //     String query = "Select name from publishers";

    //     try(Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");){

    //         PreparedStatement ps = con.prepareStatement(query);

    //         ResultSet rs = ps.executeQuery();

    //         while(rs.next()){
    //             list.add(new Publisher(rs.getString(1)));
    //         }
    //     }catch(SQLException e){
    //         e.printStackTrace();
    //     }

    //     return list;
    // }   

    public  boolean savePublisherDetails(){
        boolean flag = false;

        try{ Class.forName("com.mysql.cj.jdbc.Driver"); }catch(ClassNotFoundException e){e.printStackTrace();}
        String query = "insert into publisher(user_id,details,website) values(?,?,?)";
        try(Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234")){
            
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,getUserId());
            ps.setString(2,details);
            ps.setString(3,website);
            // System.out.println(ps);

            int val = ps.executeUpdate();

            if(val==1){
                flag=true;
            }
            // System.out.println(flag);

            return flag;


        }catch(SQLException e){
            e.printStackTrace();
        }

        return flag;
    }

    public int  login(){
        int res = super.login();

        if(res==3){
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
                String query = "select * from publisher where user_id=?";
                
                PreparedStatement ps = con.prepareStatement(query);

                ps.setInt(1,getUserId());

                ResultSet rs =  ps.executeQuery();

                

                if(rs.next()){

                    publisherId = rs.getInt(1);
                    details = rs.getString(2);
                    website = rs.getString(3);
                   
                }

                con.close();
            }catch(SQLException|ClassNotFoundException e){
                e.printStackTrace();
            }
        }
        return res;
    }

    // ################ get/set ################ 

    public Integer getPublisherId() {
        return publisherId;
    }

    public void setPublisherId(Integer publisherId) {
        this.publisherId = publisherId;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }
    





    

}
