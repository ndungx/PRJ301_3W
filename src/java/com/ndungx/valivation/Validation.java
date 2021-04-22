package com.ndungx.valivation;

import java.util.regex.Pattern;

/*
 * @author NDungx
 */
public class Validation {

    public static boolean isValidEmail(String email) {
        //"\\.": để phân biệt với "." trong regex
        Pattern p = Pattern.compile("^[a-zA-Z][a-zA-Z0-9]+@[a-zA-Z]{2,}(\\.[a-zA-Z]{2,}){1,3}$");
        return p.matcher(email).find();
    }

    public static boolean isValidPhoneNumber(String phone) {
        //nhập số từ 9-12 kí tự
        Pattern p = Pattern.compile("^[0-9]{10,12}$");
        return p.matcher(phone).find();
    }
}
