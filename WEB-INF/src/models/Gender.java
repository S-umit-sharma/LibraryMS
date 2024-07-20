package models;

public class Gender {
    // ############ properties ############
    
    private Integer genderId;
    private Character genderType;
    // ############ constructor ############
    
    public Gender(){
        
    }

    public Gender(Integer genderId){
        this.genderId = genderId;
    }
    
    // ############ get/set ############
    
    public void setGenderId(Integer genderId){
        this.genderId = genderId;
    }

    public Integer getGenderId(){
        return genderId;
    }

    public void setGenderType(Character genderType){
        this.genderType = genderType;
    }

    public Character getGenderType(){
        return genderType;
    }

}
