package models;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Time;
import java.util.ArrayList;

public class Library extends User {
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

    public Library() {

    }


    // public Library(City city) {
    //     super(city);
    // }

    public Library(Integer libraryId) {
        this.libraryId = libraryId;
    }

    public Library(String email, String password) {
        super(email, password);

    }

    // ###################### methods ######################

    // ------------------------------------------collect all libraries with city
    // ----------------------------------------------------------
    public ArrayList<Library> collectLibraryByName() {
        ArrayList<Library> list = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            
            String query = "SELECT u.name, u.dob,u.address,u.contact,u.profile_pic,l.details,l.website,l.open_timing,l.close_timing, l.book_issue_days, l.late_fine,l.deposit_amount,c.city,l.library_id FROM users AS u INNER JOIN libraries AS l inner join cities as c ON l.user_id = u.user_id and c.city_id = u.city_id WHERE u.name LIKE ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, "%"+ getName() +"%");
            System.out.println(this.getName() + "######");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Library lib = new Library();
                lib.setName(rs.getString(1));
                lib.setDob(rs.getDate(2));
                lib.setAddress(rs.getString(3));
                lib.setContact(rs.getString(4));
                lib.setProfilePic(rs.getString(5));
                lib.setDetails(rs.getString(6));
                lib.setWebsite(rs.getString(7));
                lib.setOpeningTime(rs.getTime(8));
                lib.setClosingTime(rs.getTime(9));
                lib.setBookIssueDays(rs.getInt(10));
                lib.setLateFine(rs.getInt(11));
                lib.setDepositAmount(rs.getInt(12));
                lib.setCity(new City(rs.getString(13)));
                lib.setLibraryId(rs.getInt(14));

                list.add(lib);
            }
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // ----------------------------------------------------------------------------------------------------
    public boolean saveDetails() {
        boolean flag = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

            String query = "insert into libraries(user_id,details,website,open_timing,close_timing,book_issue_days,late_fine,deposit_amount) values(?,?,?,?,?,?,?,?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, getUserId());
            ps.setString(2, details);
            ps.setString(3, website);
            ps.setTime(4, openingTime);
            ps.setTime(5, closingTime);
            ps.setInt(6, bookIssueDays);
            ps.setInt(7, lateFine);
            ps.setInt(8, depositAmount);

            int val = ps.executeUpdate();

            if (val == 1) {
                flag = true;
            }

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return flag;
    }

    public int login() {
        int result = super.login();

        if (result == 3 && getStatus().getStatusId() == Status.ACTIVE) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager
                        .getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

                String query = "select library_id, details, website, open_timing, close_timing, book_issue_days, late_fine, deposit_amount from libraries where user_id  = ?";

                PreparedStatement ps = con.prepareStatement(query);

                ps.setInt(1, getUserId());

                ResultSet rs = ps.executeQuery();

                while (rs.next()) {
                    libraryId = rs.getInt(1);
                    details = rs.getString(2);
                    website = rs.getString(3);
                    openingTime = rs.getTime(4);
                    closingTime = rs.getTime(5);
                    bookIssueDays = rs.getInt(6);
                    lateFine = rs.getInt(7);
                    depositAmount = rs.getInt(8);
                }

                con.close();
            } catch (ClassNotFoundException | SQLException e) {
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
