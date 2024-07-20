package models;


public class DocumentType {
    // ############# properties #############

    private Integer documnetTypeId;
    private String documentType;
    
    // ############# constructor #############
    
    public DocumentType(){
        
    }
    
    // ############# get/set #############

    public Integer getDocumnetTypeId() {
        return documnetTypeId;
    }

    public void setDocumnetTypeId(Integer documnetTypeId) {
        this.documnetTypeId = documnetTypeId;
    }

    public String getDocumentType() {
        return documentType;
    }

    public void setDocumentType(String documentType) {
        this.documentType = documentType;
    }

}
