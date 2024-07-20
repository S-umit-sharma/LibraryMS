package models;

public class UserType {
    
    // ################## properties ##################
    
    private Integer userTypeId;
    private String type;

    public static String[] userTypes = {"LIBRARIES","PUBLISHERS","CANDIDATES","LIBRARIANS"}; 
    
    // ################## constructor ##################
    
    public UserType(){
        
    }

    public UserType(Integer userTypeId){
        this.userTypeId = userTypeId;
    }
    
    // ################## get/set ##################

    public void setUserTypeId(Integer userTypeId){
        this.userTypeId = userTypeId;
    }

    public Integer getUserTypeId(){
        return userTypeId;
    }

    public void setTypeI(String type){
        this.type = type;
    }

    public String getType(){
        return type;
    }
    
}
