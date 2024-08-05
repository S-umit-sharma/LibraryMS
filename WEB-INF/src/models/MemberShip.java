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
    private Integer memberId;
    private Status memberStatusId;

    public MemberShip() {

    }

    public MemberShip(Integer memberId, Date leftOn) {
        this.memberId = memberId;
        this.leftOn = leftOn;
    }

    public MemberShip(Library library) {
        this.library = library;
    }

    public MemberShip(String name, String contact, City city, String address, String profilePic, Date joinedOn,
            Date leftOn, Integer currentDues, Integer memberId) {
        super(name, contact, city, address, profilePic);
        this.joinedOn = joinedOn;
        this.leftOn = leftOn;
        this.currentDues = currentDues;
        this.memberId = memberId;
    }

    public MemberShip(Library library, Integer userId, Date joinedOn, Integer memberId) {
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

    // -------------------- return book method--------------------------------------
    public boolean checkStatus() {
        boolean flag = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select member_status_id from memberships where member_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, memberId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

                if (rs.getInt(1) == Status.ACTIVE) {
                    flag = true;
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return flag;
    }

    // -------------------- return book method--------------------------------------
    public int checkingForBooks() {
        int val = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

            String query = "select * from memberships as m inner join issued_books as ib where ib.member_id = m.member_id and m.member_id=? and ib.status=1";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, memberId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                val++;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return val;
    }

    // -------------------- return book method--------------------------------------
    public boolean changeStatus() {
        boolean flag = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "update memberships set left_on=?,member_status_id=? where member_id=?";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setDate(1, leftOn);
            ps.setInt(2, Status.LEFT);
            ps.setInt(3, memberId);
            int val = ps.executeUpdate();

            if (val == 1) {
                flag = true;
            }
            con.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return flag;
    }

    // -------------------- collect photo by member
    // id--------------------------------------
    public void collectPhoto() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select u.profile_pic,u.name,current_dues from memberships m join users u where u.user_id=m.user_id and m.member_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, memberId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                this.setProfilePic(rs.getString(1));
                this.setName(rs.getString(2));
                this.setCurrentDues(rs.getInt(3));
            }

            con.close();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

    }

    // -------------------- collect all record from the member table of the specific
    // library --------------------------------------
    public ArrayList<MemberShip> collectAllMembers() {
        ArrayList<MemberShip> list = new ArrayList<>();
        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select name,contact,city,address,profile_pic,joined_on,left_on,current_dues,member_id from memberships m join users u join cities c on u.user_id=m.user_id and c.city_id=u.city_id where m.library_id=? and m.member_status_id=1";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, library.getLibraryId());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new MemberShip(rs.getString(1), rs.getString(2), new City(rs.getString(3)), rs.getString(4),
                        rs.getString(5), rs.getDate(6), rs.getDate(7), rs.getInt(8), rs.getInt(9)));
            }
            con.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;

    }

    // -------------------- collect the id of the member
    // --------------------------------------
    public void collectMember() {

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select member_id from memberships where user_id=? and library_id=? and member_status_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, getUserId());
            ps.setInt(2, library.getLibraryId());
            ps.setInt(3, Status.ACTIVE);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                memberId = rs.getInt(1);
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

            String query = "insert into memberships(library_id,user_id,joined_on,member_id,member_status_id) values(?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, library.getLibraryId());
            ps.setInt(2, getUserId());
            ps.setDate(3, joinedOn);
            ps.setInt(4, memberId);
            ps.setInt(5, 1);

            ps.executeUpdate();

            con.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

    }

    // -------------------- methods --------------------------------------
    public boolean checkUserAvailabilityForAdd() {
        boolean flag = true;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select member_id from memberships where user_id=? and library_id=? and member_status_id=1 ";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, getUserId());
            ps.setInt(2, library.getLibraryId());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                setMemberId(rs.getInt(1));
                flag = false;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return flag;
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

    public Library getLibrary() {
        return library;
    }

    public void setLibrary(Library library) {
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

    public void setMemberId(Integer memberId) {
        this.memberId = memberId;
    }

    public Integer getMemberId() {
        return memberId;
    }

    public void setMemberStatusId(Status memberStatusId) {
        this.memberStatusId = memberStatusId;
    }

    public Status getMemberStatusId() {
        return memberStatusId;
    }
}
