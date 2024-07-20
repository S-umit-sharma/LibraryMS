package models;

import java.sql.Timestamp;

public class IssuedBook {
    private Integer issuedBookId;
    private BookEdition bookEditionId;
    private MemberShip memberShipId;
    private Timestamp issueDate;
    private Timestamp returnDate;
    private Integer fine = 0;

    public IssuedBook(){

    }
// ------------------------get/set--------------------------------
    public Integer getIssuedBookId() {
        return issuedBookId;
    }

    public void setIssuedBookId(Integer issuedBookId) {
        this.issuedBookId = issuedBookId;
    }

    public BookEdition getBookEditionId() {
        return bookEditionId;
    }

    public void setBookEditionId(BookEdition bookEditionId) {
        this.bookEditionId = bookEditionId;
    }

    public MemberShip getMemberShipId() {
        return memberShipId;
    }

    public void setMemberShipId(MemberShip memberShipId) {
        this.memberShipId = memberShipId;
    }

    public Timestamp getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Timestamp issueDate) {
        this.issueDate = issueDate;
    }

    public Timestamp getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(Timestamp returnDate) {
        this.returnDate = returnDate;
    }

    public Integer getFine() {
        return fine;
    }

    public void setFine(Integer fine) {
        this.fine = fine;
    }

}
