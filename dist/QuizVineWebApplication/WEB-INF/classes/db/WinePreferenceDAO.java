/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;


public class WinePreferenceDAO {
    
    public void insertWinePreference(UserWinePreference preference) throws Exception {
        DB db = new DB(); 
        Connection conn = db.getConnection();
        try {
            String sql = "INSERT INTO USER_WINE_PREFERENCES (UserID, WineID, `Order`) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE UserID = ?, WineID = ?, `Order` = ?";
            PreparedStatement stmt = conn.prepareStatement(sql); 
            stmt.setInt(1, preference.getUserId());
            stmt.setInt(2, preference.getWineId());
            stmt.setInt(3, preference.getOrder());
            stmt.setInt(4, preference.getUserId());
            stmt.setInt(5, preference.getWineId());
            stmt.setInt(6, preference.getOrder());
            stmt.execute();
         
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, e.toString(), e);
            throw e;
        } finally {
            conn.close();
        }
    }
    
}
