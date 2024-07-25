package models;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class MemberShip extends User {
    private Integer membershipId;
    private Library library;
    private Date joinedOn;
    private Date leftOn;
    private Integer currentDues = 0;
    private String memberId;

    public MemberShip() {

    }

    public MemberShip(Library library){
        this.library = library;
    }

    public MemberShip(String name,String contact,City city,String address,String profilePic, Date joinedOn, Date leftOn, Integer currentDues,String memberId) {
        super(name,contact,city,address,profilePic);
        this.joinedOn = joinedOn;
        this.leftOn = leftOn;
        this.currentDues = currentDues;
        this.memberId = memberId;
    }

    public MemberShip(Library library, Integer userId, Date joinedOn, String memberId) {
        super(userId);
        this.library = library;
        this.joinedOn = joinedOn;
        this.memberId = memberId;
    }

    public MemberShip(Integer membershipId) {
        this.membershipId = membershipId;
    }

    public MemberShip(String email, String password) {
        super(email, password);
    }

    // -------------------- collect all record from the member table of the specific library --------------------------------------
    public ArrayList<MemberShip> collectAllMembers(){
        ArrayList<MemberShip> list = new ArrayList<>();
        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select name,contact,city,address,profile_pic,joined_on,left_on,current_dues,member_id from memberships m join users u join cities c on u.user_id=m.user_id and c.city_id=u.city_id where m.library_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, library.getLibraryId());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new MemberShip(rs.getString(1),rs.getString(2),new City(rs.getString(3)),rs.getString(4),rs.getString(5),rs.getDate(6),rs.getDate(7),rs.getInt(8),rs.getString(9)));
            }
            con.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;

    }
    // -------------------- collect the id of the member --------------------------------------
    public void collectMember() {
        
        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select member_id from memberships where user_id=? and library_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, getUserId());
            ps.setInt(2, library.getLibraryId());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                memberId = rs.getString(1);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // -------------------- methods --------------------------------------
    public void saveMemberShip() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

            String query = "insert into memberships(library_id,user_id,joined_on,member_id) values(?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, library.getLibraryId());
            ps.setInt(2, getUserId());
            ps.setDate(3, joinedOn);
            ps.setString(4, memberId);

            ps.executeUpdate();

            con.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

    }

    // -------------------- methods --------------------------------------
    public int login() {
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
        return library;
    }

    public void setLibraryId(Library library) {
        this.library = library;
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
