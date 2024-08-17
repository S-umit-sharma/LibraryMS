package models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BookEditionPic {
    private Integer bookEditionPicId;
    private BookEdition bookEdition;
    private String editionImgPath;

    public BookEditionPic() {

    }

    public BookEditionPic(Integer bookEditionPicId, String editionImagePath) {
        this.bookEditionPicId = bookEditionPicId;
        this.editionImgPath = editionImagePath;
    }

    // --------------------------------------------------------------------------------
    public String getEditionImageForIsbn() {
        String path = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select edition_img_path from book_edition_pic where book_edition_id=? limit 1";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookEdition.getBookEditionId());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                path = rs.getString(1);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return path;
    }

    // --------------------------------------------------------------------------------
    public ArrayList<BookEditionPic> getAllImages() {
        ArrayList<BookEditionPic> list = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select book_edition_pic_id,edition_img_path from book_edition_pic where book_edition_id = ? ";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookEdition.getBookEditionId());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new BookEditionPic(rs.getInt(1), rs.getString(2)));
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }

        return list;
    }

    // --------------------------------------------------------------------------------
    public ArrayList<BookEditionPic> showAllBookEditionImages() {
        ArrayList<BookEditionPic> list = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select book_edition_pic_id,edition_img_path from book_edition_pic where book_edition_id=?";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookEdition.getBookEditionId());
            ResultSet rs = ps.executeQuery();
            int count = 0;
            while (rs.next()) {
                list.add(new BookEditionPic(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return list;

    }

    // --------------------------------------------------------------------------------

    public void saveEditionImage() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "insert into  book_edition_pic (edition_img_path,book_edition_id) value(?,?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, editionImgPath);
            ps.setInt(2, bookEdition.getBookEditionId());

            ps.executeUpdate();

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    }
    //
    // ----------------------------get/set------------------------------------------------

    // ----------------------------get/set------------------------------------------------

    public Integer getBookEditionPicId() {
        return bookEditionPicId;
    }

    public void setBookEditionPicId(Integer bookEditionPicId) {
        this.bookEditionPicId = bookEditionPicId;
    }

    public BookEdition getBookEdition() {
        return bookEdition;
    }

    public void setBookEdition(BookEdition bookEdition) {
        this.bookEdition = bookEdition;
    }

    public String getEditionImgPath() {
        return editionImgPath;
    }

    public void setEditionImgPath(String editionImgPath) {
        this.editionImgPath = editionImgPath;
    }

}
