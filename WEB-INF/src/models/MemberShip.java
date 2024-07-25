package models;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MemberShip extends User {
    private Integer membershipId;
    private Library libraryId;
    private Date joinedOn;
    private Date leftOn;
    private Integer currentDues = 0;

    public MemberShip() {

    }

    public MemberShip(Integer membershipId){
        this.membershipId = membershipId;
    }
    public MemberShip(String email, String password) {
        super(email, password);
    }

    // -------------------- methods --------------------------------------

    
    public int login(){
        int result = super.login();

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
