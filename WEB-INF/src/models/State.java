package models;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
public class State{
    // ################ properties ################

    private Integer stateId;
    private String state;   
    
    // ################ constructor ################
    
    public State(){
        
    }

    public State(String state){
        this.state = state;
    }
    
    public State(Integer stateId,String state){
        this.stateId = stateId;
        this.state = state;
    }
    
    // ################ state get ################
    public static ArrayList<State> listState(){
        ArrayList<State> dropList = new ArrayList<>(); 
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select * from states";
            PreparedStatement ps = con.prepareStatement(query);           
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                dropList.add(new State(rs.getInt(1),rs.getString(2)));
            }
        }catch(ClassNotFoundException|SQLException e){
            e.printStackTrace();
        }
        return dropList;
    }


    public String toString(){
        return state;
    }















    // ################ get/set ################
    public void setStateId(Integer stateId){
        this.stateId = stateId;
    }

    public Integer getStateId(){
        return stateId;
    }

    public void setState(String state){
        this.state = state;
    }

    public String getState(){
        return state;
    }

}