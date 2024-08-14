package models;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.ResultSet;

import java.util.ArrayList;

public class Book {
    // ################ porpeties ################

    private Integer bookId;
    private String title;
    private Category category;
    private Publisher publisher;
    private String bookPic;
    private Status status;

    // ################ constructor ################

    public Book() {

    }

    public Book(String title, Integer bookId) {
        this.bookId = bookId;
        this.title = title;
    }

    public Book(String title) {
        this.title = title;
    }

    public Book(Integer bookId, String title) {
        this.bookId = bookId;
        this.title = title;
    }

    public Book(Category category) {
        this.category = category;
    }

    public Book(Integer bookId, String title, Category category, Publisher publihser, String bookPic, Status status) {
        this.title = title;
        this.bookId = bookId;
        this.category = category;
        this.publisher = publihser;
        this.bookPic = bookPic;
        this.status = status;
    }

    public Book(Integer bookId, String title, Category category, Publisher publihser) {
        this.title = title;
        this.bookId = bookId;
        this.category = category;
        this.publisher = publihser;
    }

    public Book(Publisher publisher) {
        this.publisher = publisher;
    }

    public Book(Integer bookId) {
        this.bookId = bookId;
    }

    public Book(String title, Category catedory, Publisher publihser, String bookPic) {
        this.title = title;
        this.category = catedory;
        this.publisher = publihser;
        this.bookPic = bookPic;
    }

    public Book(Integer bookId, String title, Category category, String bookPic) {
        this.bookId = bookId;
        this.title = title;
        this.category = category;
        this.bookPic = bookPic;
    }

    public Book(String title, Category category, Publisher publihser) {
        this.title = title;
        this.category = category;
        this.publisher = publihser;
    }

    // ################ get/set ################
    // ----------------------------------------{-------------------------------------
    public void findTitle() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select title from books where book_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();
            {
                if (rs.next()) {
                    title = rs.getString(1);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // -----------------------------------------------------------------------------
    public String getImagePath() {
        String path = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select book_pic from books where book_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                path = rs.getString(1);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return path;
    }

    // -----------------------------------------------------------------------------
    public ArrayList<Book> searchByTitle() {
        ArrayList<Book> books = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select * from books where title LIKE ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, "%" + title + "%");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                books.add(new Book(rs.getInt(1), rs.getString(2), new Category(rs.getInt(3)),
                        new Publisher(rs.getInt(4)), rs.getString(5),new Status(rs.getInt(6))));
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    // -----------------------------------------------------------------------------
    public void updateBookDetails() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "update books set title=?,category_id=?,publisher_id=? where book_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, title);
            ps.setInt(2, category.getCategoryId());
            ps.setInt(3, publisher.getPublisherId());
            ps.setInt(4, bookId);

            ps.executeUpdate();

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

    }

    // -----------------------------------------------------------------------------
    public void fetchBookDetails() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select * from books where book_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                bookId = rs.getInt(1);
                title = rs.getString(2);
                category = new Category(rs.getInt(3));
                publisher = new Publisher(rs.getInt(4));
                bookPic = rs.getString(5);
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // -----------------------------------------------------------------------------
    public void deleteBook(Book book) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "update books set status_id=? where book_id=?";
            BookEdition e = new BookEdition(book);
            e.deleteAllBookEdition(1);
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, Status.DELETED);
            ps.setInt(2, bookId);
            ps.executeUpdate();
            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }

    // -----------------------------------------------------------------------------
    public void saveBookImage() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

            String query = "update books set book_pic=? where book_id=?";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, bookPic);
            ps.setInt(2, bookId);

            ps.executeUpdate();

            con.close();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    // -----------------------------------------------------------------------------

    public ArrayList<Book> collectAllBooks(Integer publisherId) {
        ArrayList<Book> list = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

            String query = "select book_id,title,c.category_id,name,book_pic from books as b inner join categories as c where b.category_id=c.category_id and publisher_id = ? and status_id=?";
            // String query1 = "select name from categories where category_id=?";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, publisherId);
            ps.setInt(2, Status.AVAILABLE);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                list.add(new Book(rs.getInt(1), rs.getString(2), new Category(rs.getInt(3), rs.getString(4)),
                        rs.getString(5)));
            }

            con.close();

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;
    }

    // -----------------------------------------------------------------------------
    public boolean saveBook() {
        boolean flag = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "insert into books(title,category_id,publisher_id,status_id) values(?,?,?,12)";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, title);
            ps.setInt(2, category.getCategoryId());
            ps.setInt(3, publisher.getPublisherId());

            int val = ps.executeUpdate();

            if (val == 1) {
                flag = true;
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return flag;
    }

    // -----------------------------------------------------------------------------
    // ################ get/set ################

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public String getBookPic() {
        return bookPic;
    }

    public void setBookPic(String bookPic) {
        this.bookPic = bookPic;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Category getCategoryId() {
        return category;
    }

    public void setCategoryId(Category category) {
        this.category = category;
    }

    public Publisher getPublisher() {
        return publisher;
    }

    public void setPublisher(Publisher publisher) {
        this.publisher = publisher;
    }

    public void setStatus(Status status){
        this.status = status;
    }

    public Status getStatus(){
        return status;
    }

}
