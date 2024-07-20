package models;

public class LibraryPics {
    //################## properties ##################  
    
    private Integer libraryPicsId;
    private Library libraryId;
    private String picPath;
    
    //################## constructor ################## 
    
    public LibraryPics(){
        
    }
    
    //################## get/set ################## 

    public void setLibraryPicsId(Integer libraryPicsId){
        this.libraryPicsId = libraryPicsId;
    }
    public Integer getLibraryPicsId(){
        return libraryPicsId;
    }
    public void setLibraryId(Library libraryId){
        this.libraryId = libraryId;
    }
    public Library getLibraryId(){
        return libraryId;
    }
    public void setPicPath(String picPath){
        this.picPath = picPath;
    }  
    public String getPicPath(){
        return picPath;
    }

}
