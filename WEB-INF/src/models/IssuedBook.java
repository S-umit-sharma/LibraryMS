package models;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class IssuedBook {

    private Integer issuedBookId;
    private BookEdition bookEdition;
    private MemberShip memberShip;
    private Date issueDate;
    private Date returnDate;
    private Integer fine = 0;
    private String status;

    public IssuedBook() {

    }

    public IssuedBook(BookEdition bookEdition, MemberShip memberShip, Date issueDate, Date returnDate,String status) {
        this.bookEdition = bookEdition;
        this.memberShip = memberShip;
        this.issueDate = issueDate;
        this.returnDate = returnDate;
        this.status = status;
    }

    // ------------------------method--------------------------------
    public boolean issueBook() {
        boolean flag = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "insert into issued_books(book_edition_id,membership_id,issue_date,return_date,status) values(?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookEdition.getBookEditionId());
            ps.setInt(2, memberShip.getMembershipId());
            ps.setDate(3, issueDate);
            ps.setDate(4, returnDate);
            ps.setString(5, status);
            int val = ps.executeUpdate();
            if (val == 1) {
                flag = true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return flag;
    }

    // ------------------------get/set--------------------------------
    public Integer getIssuedBookId() {
        return issuedBookId;
    }

    public void setIssuedBookId(Integer issuedBookId) {
        this.issuedBookId = issuedBookId;
    }

    public BookEdition getBookEditionId() {
        return bookEdition;
    }

    public void setBookEditionId(BookEdition bookEdition) {
        this.bookEdition = bookEdition;
    }

    public MemberShip getMemberShipId() {
        return memberShip;
    }

    public void setMemberShipId(MemberShip memberShip) {
        this.memberShip = memberShip;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public Date getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Date returnDate) {
        this.returnDate = returnDate;
    }

    public Integer getFine() {
        return fine;
    }

    public void setFine(Integer fine) {
        this.fine = fine;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

}
