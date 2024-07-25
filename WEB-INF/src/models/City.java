package models;

import java.util.ArrayList;

import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
public class City {
    // ################ properties ################
    
    private Integer cityId;
    private String city;
    private State state;
    
    // ################ constructor ################
    
    public City(){
        
    }

    public City(String city){
        this.city = city;
    }
    
    public City(String city,State state){
        this.city=city;
        this.state = state;
    }

    public City(Integer cityId,String city,State state){
        this.cityId = cityId;
        this.city = city;
        this.state = state;
    }

    // ##################### Methods ########################
    
    // ##################### Show Cities Method ########################
    public static ArrayList<City> showCities(){
        ArrayList<City> list = new ArrayList<>();

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select city_id,c.city,s.state from cities as c inner join states as s where c.state_id=s.state_id";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                list.add(new City(rs.getInt(1),rs.getString(2),new State(rs.getString(3))));
            }

            con.close();
        }catch(ClassNotFoundException|SQLException e){
            e.printStackTrace();
        }


        return list;
    }

    
    // ################ Equals method implementation ################
        public boolean equals(Object obj){
            boolean flag = false;
            
            if(obj instanceof City){
                City c1 = this;
                City c2 = (City)obj;

                String ct1 = c1.city;
                String ct2 = c2.city;

                String st1 = c1.state.getState();
                String st2 = c2.state.getState();
                
                flag = ct1.equals(ct2) && st1.equals(st2);
            }
            return flag;
        }
    // ################ get/set ################
    
    public void setCityId(Integer cityId){
        this.cityId = cityId;
    }

    public Integer getcityId(){
        return cityId;
    }

    public void setCity(String city){
        this.city = city;
    }

    public String getCity(){
        return city;
    }

    public void setStateId(State stateId){
        this.state = stateId;
    }

    public State getState(){
        return state;
    }

}
