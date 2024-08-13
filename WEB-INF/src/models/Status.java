package models;

public class Status {
    // ############### porperties ###############

    private Integer statusId;
    private String name;

    public static final Integer ACTIVE = 1;
    public static final Integer INACTIVE = 2;
    public static final Integer WORKING = 3;
    public static final Integer LEFT = 4;
    public static final Integer CLOSED = 5;
    public static final Integer BLOCKED = 6;
    public static final Integer MANUAL_VERIFIED = 7;
    public static final Integer EMAIL_VERIFIED = 8;
    public static final Integer APPROVE = 9;
    public static final Integer REJECTED = 10;
    public static final Integer PENDING = 11;
    public static final Integer AVAILABLE = 12;
    public static final Integer DELETED = 13;
    
    // ############### constructor ###############
    
    public Status(){
        
    }

    public Status(Integer statusId){
        this.statusId = statusId;
    }
    
    // ############### get/set ###############
    
    public Integer getStatusId() {
        return statusId;
    }

    public void setStatusId(Integer statusId) {
        this.statusId = statusId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    

    

}
