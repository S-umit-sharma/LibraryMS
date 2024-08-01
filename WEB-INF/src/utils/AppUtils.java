package utils;

import models.City;
import models.State;
import java.util.ArrayList;
import models.Category;
public class AppUtils {
    public static City getCity(ArrayList<City> cities,String city){

        int i = city.indexOf("(");

        
        String state = city.substring(i+1, city.length()-1);
        city = city.substring(0,i);

        int index = cities.indexOf(new City(city,new State(state)));

        
        return cities.get(index);
    }

    public static String printEmailPattern(String email){
        String[] arr = email.split("@");

        String firstPart = arr[0];
        String endPart = arr[1];

        StringBuilder star = new StringBuilder();
        
        int count = firstPart.substring(2).length();

        int i;
        for(i=0;i<count;i++){
            star.append("*");
        }

        return star.toString();
    }


}

