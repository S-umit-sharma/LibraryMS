package utils;

import java.util.regex.Pattern;

public class RegexPatternUtil {

    public static final String NAME_PATTERN = "[a-zA-Z0-9_ ]{8,15}";
    public static final String EMAIL_PATTERN = "[A-Za-z0-9_.+-]+@[A-Za-z0-9-]+\\.[a-zA-Z0-9-.]+";
    public static final String PASSWORD_PATTERN = "(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[*_#@!~^$])[a-zA-Z0-9*_#@!~^$]{8,16}";
    public static final String CONTACT_PATTERN = "[6-9][0-9]{9}";
    public static final String ADDRESS_PATTERN = "[A-Za-z,0-9()- ]";

    public static boolean validateField(String FieldName, String pattern) {
        return  Pattern.compile(pattern).matcher(FieldName).matches();
    }
}
