package models;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;


public class IssuedBook {

    private Integer issuedBookId;
    private BookEdition bookEdition;
    private MemberShip memberShip;
    private Date issueDate;
    private Date returnDate;
    private Integer fine ;
    private Integer status;
    private Integer memberId;

    public IssuedBook() {

    }

    public IssuedBook(MemberShip memberShip, BookEdition bookEdition) {
        this.memberShip = memberShip;
        this.bookEdition = bookEdition;
    }

    public IssuedBook(BookEdition bookEdition, MemberShip memberShip, Date issueDate, Date returnDate) {
        this.bookEdition = bookEdition;
        this.memberShip = memberShip;
        this.issueDate = issueDate;
        this.returnDate = returnDate;
    }
    // ------------------------collect photo and collect book info for returning--------------------------------
    public boolean collectPhoto() {
        boolean flag = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select u.profile_pic,u.name,current_dues,be.book_edition_id,be.isbn_no from memberships m join users u join book_editions be join books b join issued_books ib where u.user_id=m.user_id and be.book_edition_id=ib.book_edition_id and b.book_id=be.book_id and m.member_id=? and ib.status=1";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, memberId);
            System.out.println(ps);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {

                // System.out.println("###################10");
                try{
                    
                    MemberShip memberShip = new MemberShip();
                    memberShip.setProfilePic(rs.getString(1));
                    memberShip.setName(rs.getString(2));
                    memberShip.setCurrentDues(rs.getInt(3));
                    setMemberShip(memberShip);
                    BookEdition bookEdition = new BookEdition();
                    bookEdition.setBookEditionId(rs.getInt(4));
                    bookEdition.setIsbnNo(rs.getInt(5));
                    setBookEdition(bookEdition);
                    flag = true;

                }catch(Exception e){
                    e.printStackTrace();
                }
                
            }

            con.close();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return flag;
    }
    // ------------------------History book method--------------------------------
    public void collectAllIssuedBooks() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select issued_book_id,issue_date,return_date,status from issued_books as ib inner join libraries as l inner join user as u inner join book_editions be inner join books as b where ib.user_id=";
            PreparedStatement ps = con.prepareStatement(query);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                issuedBookId = rs.getInt(1);
                issueDate = rs.getDate(2);
                returnDate = rs.getDate(3);
                fine = rs.getInt(4);
                status = rs.getInt(5);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

    }
    // ------------------------delete book record--------------------------------
    public boolean updateIssuedBook(){
        boolean flag = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

            String query = "update issued_books set status=2 where member_id=? and book_edition_id=? and status=1";

            PreparedStatement ps = con.prepareStatement(query);

            
            ps.setInt(1, memberShip.getMemberId());
            ps.setInt(2, bookEdition.getBookEditionId());
            
            // System.out.println(ps + "########");
            int val = ps.executeUpdate();
            // System.out.println(val + "############");
            if(val == 1){
                // System.out.println(flag + "############");
                flag = true; 
            }

            con.close();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return flag;
    }
    // ------------------------update fine--------------------------------
    public void updateFine() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

            String query = "update issued_books as bi inner join memberships as m set bi.fine=?,m.current_dues=bi.fine where m.member_id=bi.member_id and bi.member_id=? and book_edition_id=?";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, fine);
            ps.setInt(2, memberShip.getMemberId());
            ps.setInt(3, bookEdition.getBookEditionId());

            ps.executeUpdate();

            con.close();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // ------------------------return book--------------------------------
    public void returnBook() {

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select issued_book_id,issue_date,return_date,fine,status from issued_books where member_id=? and book_edition_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, memberShip.getMemberId());
            ps.setInt(2, bookEdition.getBookEditionId());

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                issuedBookId = rs.getInt(1);
                issueDate = rs.getDate(2);
                returnDate = rs.getDate(3);
                fine = rs.getInt(4);
                status = rs.getInt(5);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

    }

    // ------------------------issue book--------------------------------
    public boolean issueBook() {
        boolean flag = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "insert into issued_books(book_edition_id,member_id,issue_date,return_date,status) values(?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookEdition.getBookEditionId());
            ps.setInt(2, memberShip.getMembershipId());
            ps.setDate(3, issueDate);
            ps.setDate(4, returnDate);
            ps.setInt(5, 1);
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

    public BookEdition getBookEdition() {
        return bookEdition;
    }

    public void setBookEdition(BookEdition bookEdition) {
        this.bookEdition = bookEdition;
    }

    public MemberShip getMemberShip() {
        return memberShip;
    }

    public void setMemberShip(MemberShip memberShip) {
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

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public void setMemberId(Integer memberId){
        this.memberId = memberId;
    }

    public Integer getMemberId(){
        return memberId;
    }

}
