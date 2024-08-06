package models;

import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LibraryBooks {

    // ################# porperties #################
    private Integer libraryBookId;
    private Library library;
    private BookEdition bookEdition;
    private Integer copies;
    private Integer bookIssued = 0;
    private Integer scraped = 0;

    // ################# constructor #################

    public LibraryBooks() {

    }

    public LibraryBooks(Integer libraryBookId,Integer bookIssued,Integer copies,BookEdition bookEdition){
        this.libraryBookId = libraryBookId;
        this.bookIssued = bookIssued;
        this.copies = copies;
        this.bookEdition = bookEdition;
    }

    public LibraryBooks(BookEdition bookEdition){
        this.bookEdition = bookEdition;
    }

    public LibraryBooks(BookEdition bookEdition, Integer bookIssued) {
        this.bookEdition = bookEdition;
        this.bookIssued = bookIssued;
    }

    public LibraryBooks(Integer libraryBookId, Integer bookIssued) {
        this.libraryBookId = libraryBookId;
        this.bookIssued = bookIssued;
    }

    public LibraryBooks(Integer libraryBookId, Integer copies, Integer bookIssued, Integer scraped,
            BookEdition bookEdition) {
        this.libraryBookId = libraryBookId;
        this.copies = copies;
        this.bookIssued = bookIssued;
        this.scraped = scraped;
        this.bookEdition = bookEdition;
    }

    public LibraryBooks(Library library) {
        this.library = library;
    }

    public LibraryBooks(BookEdition bookEdition, Integer copies, Library library) {
        this.bookEdition = bookEdition;
        this.copies = copies;
        this.library = library;
    }

     // ----------------------------Method for books-----------------------------------------
     public ArrayList<LibraryBooks> searchBookInLibrary(Integer id){
        ArrayList<LibraryBooks> list = new ArrayList<>();

        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "SELECT lb.library_book_id, lb.books_issued, lb.copies, be.book_edition_id, b.title, b.book_id,be.book_edition_pic,be.edition,be.isbn_no  FROM library_books AS lb INNER JOIN book_editions AS be ON lb.book_edition_id = be.book_edition_id INNER JOIN books AS b ON be.book_id = b.book_id WHERE library_id = ? and  b.title LIKE ?";
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setInt(1,id);
            ps.setString(2,"%"+bookEdition.getBook().getTitle()+"%");

            ResultSet rs = ps.executeQuery();

            while(rs.next()){
                list.add(new LibraryBooks(rs.getInt(1),rs.getInt(2),rs.getInt(3),new BookEdition(rs.getInt(4),new Book(rs.getString(5),rs.getInt(6)),rs.getString(7),rs.getInt(8),rs.getInt(9))));
            }
        }catch(SQLException | ClassNotFoundException e){
            e.printStackTrace();
        }

        return list;
    }
   
    // -------------------updating copies----------------------
    public void updateBookCopies() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "update library_books set books_issued=? where  book_edition_id=? ";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookIssued - 1);
            // System.out.println(bookIssued + "##########");
            ps.setInt(2, bookEdition.getBookEditionId());
            ps.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // ----------------------------Method for updating the issued books-----------------------------------------
    public void numberOfBooksIssued() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "update library_books set books_issued=? where  library_book_id=? ";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookIssued);
            ps.setInt(2, libraryBookId);
            ps.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // ----------------------------Method for getting all
    // books-----------------------------------------
    public void searchIsbnNo(Integer isbnNo) {
        // ArrayList<LibraryBooks> list = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select library_book_id,copies,books_issued,scraped,lb.book_edition_id,edition,published_on,price,details,book_edition_pic,be.book_id,title from library_books as lb inner join book_editions as be inner join books as b where lb.book_edition_id=be.book_edition_id and be.book_id=b.book_id and lb.library_id=? and be.isbn_no=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, library.getLibraryId());
            ps.setInt(2, isbnNo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                libraryBookId = rs.getInt(1);
                copies = rs.getInt(2);
                bookIssued = rs.getInt(3);
                scraped = rs.getInt(4);
                bookEdition = new BookEdition(rs.getInt(5), rs.getInt(6), rs.getDate(7), rs.getInt(8), rs.getString(9),
                        rs.getString(10), new Book(rs.getInt(11), rs.getString(12)));

            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

    }

    // ----------------------------Method for savin librayr
    // books-----------------------------------------
    public boolean saveLibraryBooks() {
        boolean flag = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

            String query = "insert into library_books (library_id, book_edition_id, copies) values(?,?,?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, library.getLibraryId());
            ps.setInt(2, bookEdition.getBookEditionId());
            ps.setInt(3, copies);

            int val = ps.executeUpdate();

            if (val == 1)
                flag = true;
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return flag;
    }

    // ---------------------------------------------------------------------

    // ################# get/set #################

    public Integer getLibraryBookId() {
        return libraryBookId;
    }

    public void setLibraryBookId(Integer libraryBookId) {
        this.libraryBookId = libraryBookId;
    }

    public Library getLibraryId() {
        return library;
    }

    public void setLibraryId(Library library) {
        this.library = library;
    }

    public BookEdition getBookEditionId() {
        return bookEdition;
    }

    public void setBookEditionId(BookEdition bookEdition) {
        this.bookEdition = bookEdition;
    }

    public Integer getCopies() {
        return copies;
    }

    public void setCopies(Integer copies) {
        this.copies = copies;
    }

    public Integer getBookIssued() {
        return bookIssued;
    }

    public void setBookIssued(Integer bookIssued) {
        this.bookIssued = bookIssued;
    }

    public Integer getScraped() {
        return scraped;
    }

    public void setScraped(Integer scraped) {
        this.scraped = scraped;
    }

}
