package models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Request {
    private Integer requestId;
    private Library library;
    private User user;
    private Status status;

    public Request() {

    }

    public Request(Integer requestId, Library library, Status status) {
        this.requestId = requestId;
        this.library = library;
        this.status = status;
    }

    public Request(User user, Status status) {
        this.user = user;
        this.status = status;
    }

    public Request(Library library, User user) {
        this.library = library;
        this.user = user;
    }

    // ------------------------------------------------------------
    public boolean changeStatus() {
        boolean flag = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "update requests set status_id = ? where user_id=? and library_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, status.getStatusId());
            ps.setInt(2, user.getUserId());
            ps.setInt(3, library.getLibraryId());

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

    // ------------------------------------------------------------
    public Boolean collectAllRequestsInfo() {
        Boolean flag = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select request_id from requests where user_id=? and library_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, user.getUserId());
            ps.setInt(2, library.getLibraryId());

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                flag = true;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return flag;
    }

    // ------------------------------------------------------------
    public ArrayList<Request> allRequests() {
        ArrayList<Request> list = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select u.name,u.profile_pic,u.user_id,s.name from requests as r inner join users as u inner join status as s where r.status_id=s.status_id and library_id = ? and u.user_id=r.user_id and r.status_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, library.getLibraryId());
            ps.setInt(2,Status.PENDING);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User u = new User();
                u.setName(rs.getString(1));
                u.setProfilePic(rs.getString(2));
                u.setUserId(rs.getInt(3));
                Status s = new Status();
                s.setName(rs.getString(4));
                list.add(new Request(u, s));
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ------------------------------------------------------------
    public boolean sendJoinRequest() {
        boolean flag = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "insert into requests(library_id,user_id,status_id) value(?,?,?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, library.getLibraryId());
            ps.setInt(2, user.getUserId());
            ps.setInt(3, Status.PENDING);
            int val = ps.executeUpdate();

            if (val == 1) {
                flag = true;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return flag;
    }

    // ------------------------------------------------------------
    public Integer getRequestId() {
        return requestId;
    }

    public void setRequestId(Integer requestId) {
        this.requestId = requestId;
    }

    public Library getLibrary() {
        return library;
    }

    public void setLibrary(Library library) {
        this.library = library;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

}
