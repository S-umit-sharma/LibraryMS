package models;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Librarian extends User {
    // ---------------properties-----------
    private Integer librarianId;
    private Library libraryId;
    private Status statusId;
    private Date joinedOn;
    private Date leftOn;

    // ---------------constructor-----------

    public Librarian() {

    }

    public Librarian(String email, String password) {
        super(email, password);
    }

    // --------------- methods ------------------------------------

    public int login() {
        int res = super.login();

        if (res == 3 && getStatus().getStatusId() == Status.ACTIVE) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager
                        .getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

                String query = "select * from librarians where user_id  = ?";

                PreparedStatement ps = con.prepareStatement(query);

                ps.setInt(1, getUserId());

                ps.executeQuery();


                con.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }

        return res;

    }

    // ---------------get/set------------------------------------

    public void setLibrarianId(Integer librarianId) {
        this.librarianId = librarianId;
    }

    public Integer getLibrarainId() {
        return librarianId;
    }

    public Library getLibraryId() {
        return libraryId;
    }

    public void setLibraryId(Library libraryId) {
        this.libraryId = libraryId;
    }

    public Status getStatusId() {
        return statusId;
    }

    public void setStatusId(Status statusId) {
        this.statusId = statusId;
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

}
