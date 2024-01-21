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

public class WineDAO {
    public ArrayList<Wine> getAllWines() throws Exception {
        ArrayList<Wine> wines = new ArrayList<Wine>();
        DB db = new DB();
        Connection conn = db.getConnection(); 
        try {
            String sql 
                    = "SELECT ID, Name, Description, ImagePath FROM wines";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet res = stmt.executeQuery(); 
            while(res.next()) {
                Wine wine 
                        = new Wine(res.getInt("ID"), res.getString("Name"), res.getString("Description"), res.getString("ImagePath"));
                wines.add(wine);
            }
        } catch (Exception e) {
            throw e;
        } finally {
            conn.close();
        }
        return wines;
    }
    
    public ArrayList<Wine> getRecommendedUserWines(User user) throws Exception {
        ArrayList<Wine> wines = new ArrayList<Wine>();
        DB db = new DB(); 
        Connection conn = db.getConnection();
        try {
            String sql = "SELECT DISTINCT w.ID, w.Name, w.Description, w.ImagePath FROM wines w JOIN user_wine_preferences uwp ON uwp.WineID = w.ID WHERE uwp.UserID = ? ORDER BY uwp.`Order` ASC";
            PreparedStatement stmt = conn.prepareStatement(sql); 
            stmt.setInt(1, user.getId());
            ResultSet res = stmt.executeQuery(); 
            while (res.next()) {
                wines.add(new Wine(res.getInt("ID"), res.getString("Name"), res.getString("Description"), res.getString("ImagePath")));
            }
        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, e.toString(), e);
            throw e;
        } finally {
            conn.close();
        }
        return wines;
    }
}
