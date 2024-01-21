/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package db;


public class UserWinePreference {
    private final int userId; 
    private final int wineId; 
    private final int order;

    public UserWinePreference(int userId, int wineId, int order) {
        this.userId = userId;
        this.wineId = wineId;
        this.order = order;
    }

    public int getUserId() {
        return userId;
    }

    public int getWineId() {
        return wineId;
    }

    public int getOrder() {
        return order;
    }
    
    
}
