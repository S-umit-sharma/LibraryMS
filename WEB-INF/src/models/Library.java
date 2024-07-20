package models;


import java.sql.Timestamp;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.Time;



public class Library extends User{
    // ###################### properties ######################

    private Integer libraryId;
    private String details;
    private String website;
    private Time openingTime;
    private Time closingTime;
    private Integer bookIssueDays;
    private Integer lateFine;
    private Integer depositAmount;

    // ###################### constructor ######################
    
    public Library(){

    }

    public Library(String email,String password){
        super(email,password);

    }
   
    // ###################### methods ######################


    public boolean saveDetails(){
        boolean flag = false;
        
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

            String query = "insert into libraries(user_id,details,website,open_timing,close_timing,book_issue_days,late_fine,deposit_amount) values(?,?,?,?,?,?,?,?)";
            
            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1,getUserId());
            ps.setString(2,details);
            ps.setString(3,website);
            ps.setTime(4,openingTime);
            ps.setTime(5,closingTime);
            ps.setInt(6,bookIssueDays);
            ps.setInt(7,lateFine);
            ps.setInt(8,depositAmount);

            int val = ps.executeUpdate();

            if(val==1){
                flag = true;
            }

            con.close();
        }catch(ClassNotFoundException|SQLException e){
            e.printStackTrace();
        }

        return flag;
    }


    public int login(){
        int result = super.login();

        if(result == 3 && getStatus().getStatusId() == Status.ACTIVE){
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

                String query = "select * from libraries where user_id  = ?";

                PreparedStatement ps = con.prepareStatement(query);

                ps.setInt(1,getUserId());

                ps.executeQuery();

                // System.out.println(ps);

                con.close();
            }catch(ClassNotFoundException|SQLException e){
                e.printStackTrace();
            }
        }

        return result;
    }





    // ###################### get/set ######################
    
    public Integer getLibraryId() {
        return libraryId;
    }
    public void setLibraryId(Integer libraryId) {
        this.libraryId = libraryId;
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
    public Time getOpeningTime() {
        return openingTime;
    }
    public void setOpeningTime(Time openingTime) {
        this.openingTime = openingTime;
    }
    public Time getClosingTime() {
        return closingTime;
    }
    public void setClosingTime(Time closingTime) {
        this.closingTime = closingTime;
    }
    public Integer getBookIssueDays() {
        return bookIssueDays;
    }
    public void setBookIssueDays(Integer bookIssueDays) {
        this.bookIssueDays = bookIssueDays;
    }
    public Integer getLateFine() {
        return lateFine;
    }
    public void setLateFine(Integer lateFine) {
        this.lateFine = lateFine;
    }
    public Integer getDepositAmount() {
        return depositAmount;
    }
    public void setDepositAmount(Integer depositAmount) {
        this.depositAmount = depositAmount;
    }





}
