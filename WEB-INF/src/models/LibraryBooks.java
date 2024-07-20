package models;

public class LibraryBooks {
    
    // ################# porperties #################
    private Integer libraryBookId;
    private Library libraryId;
    private BookEdition bookEditionId;
    private Integer copies;
    private Integer bookIssued = 0;
    private Boolean scraped = false;
    
    // ################# constructor #################
    
    public LibraryBooks(){
        
    }
    
    // ################# get/set #################
    
    public Integer getLibraryBookId() {
        return libraryBookId;
    }

    public void setLibraryBookId(Integer libraryBookId) {
        this.libraryBookId = libraryBookId;
    }

    public Library getLibraryId() {
        return libraryId;
    }

    public void setLibraryId(Library libraryId) {
        this.libraryId = libraryId;
    }

    public BookEdition getBookEditionId() {
        return bookEditionId;
    }

    public void setBookEditionId(BookEdition bookEditionId) {
        this.bookEditionId = bookEditionId;
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
