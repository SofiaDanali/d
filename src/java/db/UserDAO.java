/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import exceptions.ExistingUserException;
import exceptions.InvalidCredentialsException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.logging.Level;
import java.util.logging.Logger;
public class UserDAO {
    
    public void insertUser(User user) throws Exception {
        DB db = new DB(); 
        Connection conn = db.getConnection();
        try {
            String sql = "INSERT INTO USERS (Username, FirstName, Lastname, Password, Active) VALUES (?, ?, ?, ?, 'Y')";
            PreparedStatement stmt = conn.prepareStatement(sql); 
            stmt.setNString(1, user.getUsername());
            stmt.setNString(2, user.getFirstname());
            stmt.setNString(3, user.getLastname());
            stmt.setNString(4, user.getPassword());            
            stmt.execute();
         
        } catch (SQLIntegrityConstraintViolationException e) {
            throw new ExistingUserException(e.getMessage(), user.getUsername());
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, e.toString(), e);
            throw e;
        } finally {
            conn.close();
        }
    }
    
    public void updateUserName(User user, String firstName, String lastName) throws Exception {
        DB db = new DB(); 
        Connection conn = db.getConnection();
        try {
            String sql = "UPDATE USERS SET FirstName = ?, LastName = ? WHERE ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql); 
            stmt.setNString(1, firstName);
            stmt.setNString(2, lastName);
            stmt.setInt(3, user.getId());
            stmt.execute();
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, e.toString(), e);
            throw e;
        } finally {
            conn.close();
        }
    }
    
    public void updateUserPassword(User user, String oldPassword, String password) throws Exception {
        DB db = new DB(); 
        Connection conn = db.getConnection();
        try {
            String sql = "SELECT Password FROM USERS WHERE ID = ?";
            PreparedStatement stmt = conn.prepareStatement(sql); 
            stmt.setInt(1, user.getId());
            ResultSet res = stmt.executeQuery();
            if (res.next()) {
                if (oldPassword.equals(res.getString("Password"))) {
                    sql = "UPDATE USERS SET Password = ? WHERE ID = ?";
                    stmt = conn.prepareStatement(sql);
                    stmt.setNString(1, password);
                    stmt.setInt(2, user.getId());
                    stmt.execute();
                } else {
                    throw new InvalidCredentialsException();
                }                        
            }
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, e.toString(), e);
            throw e;
        } finally {
            conn.close();
        }
    }
    
    public User authenticate(String username, String password) throws Exception {
        DB db = new DB(); 
        Connection conn = db.getConnection(); 
        User user = null; 
        try {
            String sql = "SELECT Username, FirstName, LastName, Password, ID FROM Users WHERE Active = 'Y' AND Username = ? AND Password = ?"; 
            PreparedStatement stmt = conn.prepareStatement(sql); 
            stmt.setNString(1, username);
            stmt.setNString(2, password);
            ResultSet res = stmt.executeQuery(); 
            if (!res.next()) {
                throw new InvalidCredentialsException();
            }
            user = 
                    new User(res.getInt("ID"), res.getString("FirstName"), res.getString("LastName"), res.getString("Username"));
            
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, e.toString(), e);
            throw e;
        } finally {
            conn.close();
        }
        return user;
    }
    
    public User getUser(int id) throws Exception {
        DB db = new DB(); 
        Connection conn = db.getConnection(); 
        User user = null; 
        try {
            String sql 
                    = "SELECT Username, FirstName, LastName, Password, ID FROM Users WHERE Active = 'Y' AND ID = ?"; 
            PreparedStatement stmt = conn.prepareStatement(sql); 
            stmt.setInt(1, id);
            ResultSet res = stmt.executeQuery(); 
            if (!res.next()) {
                throw new InvalidCredentialsException();
            }
            user = new User(res.getInt("ID"), res.getString("FirstName"), res.getString("LastName"), res.getString("Username"));
            
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, e.toString(), e);
            throw e;
        } finally {
            conn.close();
        }
        return user;
    }
    
}
