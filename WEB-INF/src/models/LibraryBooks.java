package models;

import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class LibraryBooks {
    
    // ################# porperties #################
    private Integer libraryBookId;
    private Library library;
    private BookEdition bookEdition;
    private Integer copies;
    private Integer bookIssued = 0;
    private Boolean scraped = false;
    
    // ################# constructor #################
    
    public LibraryBooks(){
        
    }

    public LibraryBooks(Library library){
        this.library = library;
    }
    
    public LibraryBooks(BookEdition bookEdition,Integer copies,Library library){
        this.bookEdition = bookEdition;
        this.copies = copies;
        this.library = library;
    }
    // ----------------------------Method for getting all books-----------------------------------------
    // public ArrayList<LibraryBooks> fetchAllLibrayBooks(){
    //     ArrayList<LibraryBooks> list = new ArrayList<>();

    //     try{
    //         Class.forName("com.mysql.cj.jdbc.Driver");
    //         Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
    //         String query = "select ";
    //     }
    // }
    // ----------------------------Method for savin librayr books-----------------------------------------
    public boolean saveLibraryBooks(){
        boolean flag = false;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

            String query = "insert into library_books (library_id, book_edition_id, copies) values(?,?,?)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1,library.getLibraryId());
            ps.setInt(2,bookEdition.getBookEditionId());
            ps.setInt(3,copies);

            int val = ps.executeUpdate();

            if(val==1)
                flag = true;
        }catch(SQLException|ClassNotFoundException e){
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

    public Boolean getScraped() {
        return scraped;
    }

    public void setScraped(Boolean scraped) {
        this.scraped = scraped;
    }



    
}
