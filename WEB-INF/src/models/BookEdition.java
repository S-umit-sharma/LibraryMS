package models;

import java.sql.Date;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BookEdition {
    // ################ properties ################

    private Integer bookEditionId;
    private Integer isbnNo;
    private Book book;
    private Integer edition;
    private Date publishedOn;
    private Integer price;
    private String details;
    private Boolean imgStatus;

    // ################ constructor ################

    public BookEdition() {

    }

    public BookEdition(Integer bookEditionId, Book book, Integer edition, Integer isbnNo) {
        this.bookEditionId = bookEditionId;
        this.book = book;
        this.edition = edition;
        this.isbnNo = isbnNo;
    }

    // --------------------
    public BookEdition(Integer bookEditionId, Integer edition, Date publishedOn, Integer price, String details,
            Book book) {
        this.bookEditionId = bookEditionId;
        this.edition = edition;
        this.publishedOn = publishedOn;
        this.price = price;
        this.details = details;
        this.book = book;
    }

    // --------------------
    public BookEdition(Integer bookEditionId) {
        this.bookEditionId = bookEditionId;
    }

    public BookEdition(Book book) {
        this.book = book;
    }

    public BookEdition(Integer bookEditionId, Integer isbnNo, Book book, Integer edition, Date publishedOn,
            Integer price, String details) {
        this.bookEditionId = bookEditionId;
        this.isbnNo = isbnNo;
        this.edition = edition;
        this.book = book;
        this.publishedOn = publishedOn;
        this.price = price;
        this.details = details;
    }

    public BookEdition(Integer bookEditionId, Integer edition, Date publishedOn,
            Integer price, Integer isbnNo, String details, Book book, Boolean imgStatus) {
        this.bookEditionId = bookEditionId;
        this.isbnNo = isbnNo;
        this.edition = edition;
        this.publishedOn = publishedOn;
        this.price = price;
        this.details = details;
        this.book = book;
        this.imgStatus = imgStatus;
    }

    public BookEdition(Integer isbnNo, Book book, Integer edition, Date publishedOn, Integer price, String details) {
        this.isbnNo = isbnNo;
        this.book = book;
        this.edition = edition;
        this.publishedOn = publishedOn;
        this.price = price;
        this.details = details;
    }

    // ################ methods ################

    // -----------------------------------------------------------------------------------------------------------------------------

    // -----------------------------------------------------------------------------------------------------------------------------
    public void updateBookEdition() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "update book_editions set edition=?,published_on=?,price=?,details=?,isbn_no=?,book_id=? where book_edition_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, edition);
            ps.setDate(2, publishedOn);
            ps.setInt(3, price);
            ps.setString(4, details);
            ps.setInt(5, isbnNo);
            ps.setInt(6, book.getBookId());
            ps.setInt(7, bookEditionId);

            ps.executeUpdate();

            con.close();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

    }

    // -----------------------------------------------------------------------------------------------------------------------------
    public void changeImageStatus() {
        try {

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "update book_editions set img_status=1 where book_edition_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1,bookEditionId);
            ps.executeUpdate();

        }catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // -----------------------------------------------------------------------------------------------------------------------------
    public ArrayList<BookEdition> collectAllEditions() {
        ArrayList<BookEdition> list = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select book_edition_id,edition,published_on,price,isbn_no,details,be.book_id,title,img_status from book_editions as be inner join books as b where be.book_id=b.book_id and be.book_id=? and be.status_id=?";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, book.getBookId());
            ps.setInt(2, Status.AVAILABLE);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new BookEdition(rs.getInt(1), rs.getInt(2), rs.getDate(3), rs.getInt(4), rs.getInt(5),
                        rs.getString(6), new Book(rs.getInt(7), rs.getString(8)), rs.getBoolean(9)));

            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }
    // -----------------------------------------------------------------------------------------------------------------------------

    public void fetchAllDetails() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select edition,published_on,price,details,isbn_no,book_id,book_edition_id from book_editions where book_edition_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookEditionId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                edition = rs.getInt(1);
                publishedOn = rs.getDate(2);
                price = rs.getInt(3);
                details = rs.getString(4);
                isbnNo = rs.getInt(5);
                book = new Book(rs.getInt(6));
                bookEditionId = rs.getInt(7);
            }
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // --------------------------------------delete book edition and All book
    public String collectTitle() {
        String title = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select b.title,edition from books as b inner join book_editions as be where be.book_edition_id=? and be.book_id=b.book_id";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookEditionId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                title = rs.getString(1);
                setEdition(rs.getInt(2));
            }

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return title;
    }

    // Edition----------------------------------------------------------------------
    public void deleteAllBookEdition(Integer num) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            PreparedStatement ps;
            if (num == 1) {
                String query = "update book_editions set status_id=? where book_id=?";
                ps = con.prepareStatement(query);
                ps.setInt(1,Status.DELETED);
                ps.setInt(2, book.getBookId());
            } else {
                String query = "update book_editions set status_id=? where book_edition_id=?";
                ps = con.prepareStatement(query);
                ps.setInt(1,Status.DELETED);
                ps.setInt(2, bookEditionId);
            }

            ps.executeUpdate();

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

    }

    // -----------------------------------------------save book method
    // start------------------------------------------------------------------------------
    public void saveBookEdition() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "insert into book_editions(book_id,isbn_no,edition,published_on,price,details,status_id) value(?,?,?,?,?,?,12)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, book.getBookId());
            ps.setInt(2, isbnNo);
            ps.setInt(3, edition);
            ps.setDate(4, publishedOn);
            ps.setInt(5, price);
            ps.setString(6, details);

            ps.executeUpdate();

            con.close();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    // -----------------------------------------------save book method
    // end------------------------------------------------------------------------------
    // ################ get/set ################

    public Integer getBookEditionId() {
        return bookEditionId;
    }

    public void setBookEditionId(Integer bookEditionId) {
        this.bookEditionId = bookEditionId;
    }

    public void setIsbnNo(Integer isbnNo) {
        this.isbnNo = isbnNo;
    }

    public Integer getIsbnNo() {
        return isbnNo;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public Integer getEdition() {
        return edition;
    }

    public void setEdition(Integer edition) {
        this.edition = edition;
    }

    public Date getPublishedOn() {
        return publishedOn;
    }

    public void setPublishedOn(Date publishedOn) {
        this.publishedOn = publishedOn;
    }

    public Integer getPrice() {
        return price;
    }

    public void setPrice(Integer price) {
        this.price = price;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public void setImgStatus(Boolean imgStatus) {
        this.imgStatus = imgStatus;
    }

    public Boolean getImgStatus() {
        return imgStatus;
    }
}
