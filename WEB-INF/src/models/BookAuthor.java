package models;

public class BookAuthor {
    // ############## properties ##############
    
    Integer bookAuthorId;
    BookEdition bookEditionId;
    User userId;

    // ############## constructor ##############
    
    public BookAuthor(){
        
    }
    
    // ############## get/set ##############

    public Integer getBookAuthorId() {
        return bookAuthorId;
    }

    public void setBookAuthorId(Integer bookAuthorId) {
        this.bookAuthorId = bookAuthorId;
    }

    public BookEdition getBookEditionId() {
        return bookEditionId;
    }

    public void setBookEditionId(BookEdition bookEditionId) {
        this.bookEditionId = bookEditionId;
    }

    public User getUserId() {
        return userId;
    }

    public void setUserId(User userId) {
        this.userId = userId;
    }
    

    

}
