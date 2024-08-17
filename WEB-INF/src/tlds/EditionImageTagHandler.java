package tlds;

import java.io.IOException;
import java.util.ArrayList;

import com.google.gson.Gson;

import models.BookEdition;
import models.BookEditionPic;

import javax.servlet.ServletRequest;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import javax.servlet.jsp.tagext.JspFragment;
import javax.servlet.jsp.PageContext;

// @WebServlet("/showAllBookEditionImages.do")
public class EditionImageTagHandler extends SimpleTagSupport {

    private Integer editionId;

    public void setEditionId(Integer editionId) {
        this.editionId = editionId;
    }

    public Integer getEditionId() {
        return editionId;
    }

    public void doTag() throws IOException, JspException {
        JspFragment frag = getJspBody();

        BookEditionPic pic = new BookEditionPic();
        BookEdition bookEdition = new BookEdition();
        bookEdition.setBookEditionId(editionId);
        pic.setBookEdition(bookEdition);

        ArrayList<BookEditionPic> list = pic.showAllBookEditionImages();

        PageContext context = (PageContext) getJspContext();
        String img = "";
        ServletRequest request =  context.getRequest();
        for (BookEditionPic path : list) {
            img = "<div class='carousel-item active'><img src='show_book_img.do?img_path="+ path.getEditionImgPath()+ "' class='d-block w-100' width='200' height='260'></div>";
      
            request.setAttribute("img", img);
            frag.invoke(null);
        }

    }
}