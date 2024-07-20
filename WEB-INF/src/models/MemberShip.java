package models;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class MemberShip extends User {
    private Integer membershipId;
    private Library libraryId;
    private Date joinedOn;
    private Date leftOn;
    private Integer currentDues = 0;

    public MemberShip() {

    }

    public MemberShip(String email, String password) {
        super(email, password);
    }

    // -------------------- methods --------------------------------------

    
    public int login(){
        int result = super.login();

        if(result == 3 && getStatus().getStatusId() == Status.ACTIVE){
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

                String query = "select * from memberships where user_id  = ?";

                PreparedStatement ps = con.prepareStatement(query);

                ps.setInt(1,getUserId());

                ps.executeQuery();

                System.out.println(ps);

                con.close();
            }catch(ClassNotFoundException|SQLException e){
                e.printStackTrace();
            }
        }

        return result; 
    }

    // --------------------get/set--------------------------------------
    public Integer getMembershipId() {
        return membershipId;
    }

    public void setMembershipId(Integer membershipId) {
        this.membershipId = membershipId;
    }

    public Library getLibraryId() {
        return libraryId;
    }

    public void setLibraryId(Library libraryId) {
        this.libraryId = libraryId;
    }

    public Date getJoinedOn() {
        return joinedOn;
    }

    public void setJoinedOn(Date joinedOn) {
        this.joinedOn = joinedOn;
    }

    public Date getLeftOn() {
        return leftOn;
    }

    public void setLeftOn(Date leftOn) {
        this.leftOn = leftOn;
    }

    public Integer getCurrentDues() {
        return currentDues;
    }

    public void setCurrentDues(Integer currentDues) {
        this.currentDues = currentDues;
    }

}
