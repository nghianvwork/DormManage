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
import java.util.ArrayList;
import java.util.List;

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
            if (add > 0) {
                System.out.println("Add successfully");
            } else {
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

    public boolean updatePaymentStatus(int billID, boolean status) {
        String sql = "UPDATE Bill SET PaymentStatus = ? WHERE BillID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBoolean(1, status);
            stmt.setInt(2, billID);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public List<Bill> getBillsByUserId(int userId) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM Bill WHERE GuestID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill(
                        rs.getInt("BillID"),
                        
                        rs.getInt("RoomID"),
                        rs.getInt("GuestID"),
                        rs.getDouble("TotalCost"),
                        rs.getDate("CreateDate").toLocalDate(),
                        rs.getBoolean("PaymentStatus")
                );
                bills.add(bill);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return bills;
    }

    public List<Bill> getAllBills() {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM Bill";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill(
                        
                        rs.getInt("BillID"),
                      
                        rs.getInt("RoomID"),
                        rs.getInt("GuestID"),
                        rs.getDouble("TotalCost"),
                        rs.getDate("CreateDate").toLocalDate(),
                        rs.getBoolean("PaymentStatus"),
                        rs.getBoolean("AdminConfirmed")
                );
                bills.add(bill);
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return bills;
    }
    public List<Bill> getBillsByAdmin(int managerID) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT \n"
                + "    b.BillID,\n"
                + "    b.RoomID,\n"
                + "    r.RoomNumber,\n"
                + "    b.GuestID,\n"
                + "    u.FullName AS GuestName,\n"
                + "    b.TotalCost,\n"
                + "    b.CreateDate,\n"
                + "    b.PaymentStatus,\n"
                + "    b.AdminConfirmed,\n"
                + "    d.DepartmentID,\n"
                + "    d.DepartmentName\n"
                + "FROM Bill b\n"
                + "JOIN Rooms r ON b.RoomID = r.RoomID\n"
                + "JOIN Departments d ON r.DepartmentID = d.DepartmentID\n"
                + "JOIN Users u ON b.GuestID = u.UserID\n"
                + "WHERE d.ManagerID = ?;";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, managerID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill(
                        rs.getInt("BillID"),
                        rs.getInt("RoomID"),
                        rs.getInt("GuestID"),
                        rs.getDouble("TotalCost"),
                        rs.getDate("CreateDate").toLocalDate(),
                        rs.getBoolean("PaymentStatus"),
                        rs.getBoolean("AdminConfirmed")
                );
                bills.add(bill);
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }
        return bills;
    }
    public boolean confirmPaymentByAdmin(int billID, boolean status) {
        String sql = "UPDATE Bill SET AdminConfirmed = ? WHERE BillID = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setBoolean(1, status);
            stmt.setInt(2, billID);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    public static void main(String[] args) {
        BillDAO list = new BillDAO();
        List<Bill> l = list.getBillsByAdmin(5);
        for(Bill i : l){
             System.out.println(i.toString());
        }
       
    }
    
}
