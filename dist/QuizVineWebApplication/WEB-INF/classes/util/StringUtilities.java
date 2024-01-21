/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

public class StringUtilities {
    public static boolean isNullOrWhiteSpace(String s) {
        return s == null || s.trim().length() == 0;
    }
}