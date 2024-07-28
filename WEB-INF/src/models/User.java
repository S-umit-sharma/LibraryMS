package models;

import java.sql.Date;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.jasypt.util.password.StrongPasswordEncryptor;

public class User {
    // ########################## Properties #######################
    private Integer userId;
    private String name;
    private String email;
    private String password;
    private Gender gender;
    private Date dob;
    private City city;
    private String address;
    private String contact;
    private String profilePic;
    private String verificationCode;
    private Status status;
    private DocumentType documnetType;
    private String documentPath;
    private UserType userType;

    private static StrongPasswordEncryptor spe = new StrongPasswordEncryptor();

    // ########################## Constructor #######################
    public User() {

    }

    public User(Integer userId){
        this.userId = userId;
    }

    public User (String email){
        this.email = email; 
    }

    public User(String name,String contact,City city,String address,String profilePic){
        this.name=name;
        this.contact = contact;
        this.city = city;
        this.address = address;
        this.profilePic = profilePic;
    }


    public User(String name, String email, String password, Date dob, City city, String contact,
            String address, Gender gender, UserType userType, String verificationCode) {

        this.name = name;
        this.email = email;
        this.password = password;
        this.dob = dob;
        this.city = city;
        this.contact = contact;
        this.address = address;
        this.gender = gender;
        this.userType = userType;
        this.verificationCode = verificationCode;

    }

    public User(String email, String password) {
        this.email = email;
        this.password = password;
    }

    // ########################## Methods #######################


    // -----------------------------------------------------------------
    public boolean searchEmail(){
        boolean flag = false;
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "select name,profile_pic,user_id,user_type_id from users where email=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,email);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                name = rs.getString(1);
                profilePic = rs.getString(2);
                userId = rs.getInt(3);
                userType = new UserType(rs.getInt(4));
                flag = true;
            }
        }catch(SQLException|ClassNotFoundException e){
            e.printStackTrace();
        }

        return flag;
    } 
    // -----------------------------------------------------------------
    
    public void saveProfilePic(){
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "update users set profile_pic=?,status_id=? where user_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setString(1,profilePic);
            
            ps.setInt(2,Status.ACTIVE);
            ps.setInt(3,userId);
            
            int val = ps.executeUpdate();

            con.close();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
    
    }
    
    
    // ------------------------------login------------------------------

    public int login() {

        int result = 0; // exception genrated 

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

            String query = "select password,user_id,u.name,u.gender_id,dob,c.city_id,c.city,s.state_id,s.state,address,contact,profile_pic,status_id from users as u inner join cities as c inner join states as s where c.state_id = s.state_id and u.city_id = c.city_id and email = ? ";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                if(spe.checkPassword(password,rs.getString(1))){
                    userId = rs.getInt(2);
                    name = rs.getString(3);
                    gender = new Gender(rs.getInt(4));
                    dob = rs.getDate(5);
                    city = new City(rs.getInt(6),rs.getString(7),new State(rs.getInt(8),rs.getString(9)));
                    address = rs.getString(10);
                    contact = rs.getString(11);
                    profilePic = rs.getString(12);
                    status = new Status(rs.getInt(13));  
                    result = 3; //Login success
                }else{
                    result = 2;//incorrect Password 
                }
            }else{
                result = 1; // Email dosen't exist
            }

            con.close();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return result;
    }


    // -----------------verify method ----------------------------
    public static boolean verify(String email, String verificationCode, Integer userTypeId) {
        boolean flag = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");

            String query = "UPDATE users SET verification_code = NULL, status_id = ? WHERE email = ? AND verification_code = ?";

            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, Status.EMAIL_VERIFIED);
            ps.setString(2, email);
            ps.setString(3, verificationCode);
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
    
    // ---------------------------------Save User -----------------------------
    public boolean saveUser() {
        boolean flag = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/lmsdb?user=root&password=1234");
            String query = "insert into users (name,email,password,dob,city_id,contact,address,gender_id,user_type_id,verification_code) values(?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, spe.encryptPassword(password));
            ps.setDate(4, dob);
            ps.setInt(5, city.getcityId());
            ps.setString(6, contact);
            ps.setString(7, address);
            ps.setInt(8, gender.getGenderId());
            ps.setInt(9, userType.getUserTypeId());
            ps.setString(10, verificationCode);
            int val = ps.executeUpdate();
            setUserType(userType);
            if (val == 1) {
                flag = true;
            }
            con.close();

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }


    // ########################## get/set #######################
    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public City getCity() {
        return city;
    }

    public void setCity(City city) {
        this.city = city;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getProfilePic() {
        return profilePic;
    }

    public void setProfilePic(String profilePic) {
        this.profilePic = profilePic;
    }

    public String getVerficationCode() {
        return verificationCode;
    }

    public void setVerficationCode(String verficationCode) {
        this.verificationCode = verficationCode;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public DocumentType getDocumnetType() {
        return documnetType;
    }

    public void setDocumnetType(DocumentType documnetType) {
        this.documnetType = documnetType;
    }

    public String getDocumentPath() {
        return documentPath;
    }

    public void setDocumentPath(String documentPath) {
        this.documentPath = documentPath;
    }

    public UserType getUserType() {
        return userType;
    }

    public void setUserType(UserType userType) {
        this.userType = userType;
    }

    public void setSpe(StrongPasswordEncryptor spe) {
        this.spe = spe;
    }

    public StrongPasswordEncryptor getSpe() {
        return spe;
    }

}