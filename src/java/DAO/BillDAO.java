/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import java.sql.PreparedStatement;
import dal.DBContext;
import java.sql.Connection;
import java.sql.SQLException;
import model.Bill;
import model.BillService;
import java.sql.ResultSet;
import java.time.LocalDateTime;

/**
 *
 * @author phand
 */
public class BillDAO extends DBContext {

    Connection conn;

    public BillDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect Failed");
        }
    }

    public int insertBill(Bill bill) {
        String generatedColumns[] = {"BillID"};
        String sql = "insert into Bill (RoomID,GuestID,TotalCost,CreateDate,PaymentStatus) values (?,?,?,?,?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql, generatedColumns);
            pre.setInt(1, bill.getRoomID());
            pre.setInt(2, bill.getGuestID());
            pre.setDouble(3, bill.getTotalCost());
            pre.setDate(4, java.sql.Date.valueOf(bill.getCreateDate()));
            pre.setBoolean(5, false);
            int add = pre.executeUpdate();
            ResultSet rs = pre.getGeneratedKeys();
            if (rs.next()) {
                int id = rs.getInt(1);
                return id;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public void insertBillService(BillService billService) {
        String sql = "insert into Bill (billID,serviceID,oldRecord,newRecord,total,price,usage) values (?,?,?,?,?,?,?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, billService.getBillID());
            pre.setInt(2, billService.getServiceId());
            pre.setInt(3, billService.getOldRecord());
            pre.setInt(4, billService.getNewRecord());
            pre.setInt(5, billService.getUsage());
            pre.setDouble(6, billService.getPrice());
            pre.setDouble(7, billService.getTotal());

            int add = pre.executeUpdate();
            if(add > 0){
                System.out.println("Add successfully");
            }
            else{
                System.out.println("no");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
   
   public double getRoomPrice(int roomID) throws SQLException {
    String sql = "SELECT d.Price FROM Rooms r JOIN Departments d ON r.DepartmentID = d.DepartmentID WHERE r.RoomID = ?";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, roomID);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            return rs.getDouble("Price");
        }
    }
    return 0; 
}


public void createBill( int roomID, int userID, double price) throws SQLException {
    String sql = "INSERT INTO Bill (RoomID, GuestID, TotalCost, CreateDate, PaymentStatus) VALUES (?, ?, ?, ?, ?)";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, roomID);
        stmt.setInt(2, userID);
        stmt.setDouble(3, price);
        stmt.setObject(4, LocalDateTime.now());
        stmt.setString(5, "Unpaid");
        stmt.executeUpdate();
    }
}
}
