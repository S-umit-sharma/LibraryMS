package utils;

import java.util.Date;

public class DateUtil {
    public static java.sql.Date getCurrentDate(){
        Date d = new Date();
        long mili = d.getTime();
        java.sql.Date date = new java.sql.Date(mili); 
        return date;
    }

    public static Long getDateDifferenc(java.sql.Date returnDate){
        java.sql.Date currentDate = getCurrentDate();
        Long rd = returnDate.getTime();
        Long cd = currentDate.getTime();

        Long dd = cd-rd;
        System.out.println(cd + "##########");
        System.out.println(rd + "##########");
        int perDay = 24*60*60*1000;

        Long res = dd/perDay;

        return res;
    }
}
