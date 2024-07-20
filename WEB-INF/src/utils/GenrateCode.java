package utils;

import java.util.Random;
import java.util.Date;
public class GenrateCode {
    static Random rand = new Random();
    public static String genrateCode(){
        
        return new Date().getTime()+"_"+Math.abs(rand.nextLong());
    }

}
