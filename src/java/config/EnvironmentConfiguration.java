/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package config;

public class EnvironmentConfiguration {
    public static int PASSWORD_ITERATIONS = 10000;
    public static int PASSWORD_KEY_LENGTH = 256; 
    public static int PASSWORD_SALT_LENGTH = 16;
    public static String DB_SERVER = "127.0.0.1";
    public static String DB_PORT = "3306";
    public static String DB_NAME = "quizvine_db";
    public static String DB_USERNAME = "root";
    public static String DB_PASSWORD = "toor";
    public static String GPT_MODEL = "gpt-3.5-turbo-1106";
    public static String GPT_API_KEY = "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";
}
