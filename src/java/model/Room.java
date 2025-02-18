/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import DAO.DepartmentDAO;
import DAO.RoomDAO;
import java.util.List;

/**
 *
 * @author Legion
 */
public class Room {

    private int roomID;
    private int departmentID; // Foreign key to Department
    private String roomNumber;
    private String status;
    
    private Department department;
    public Room() {
    }

    public Room(int roomID, int departmentID, String roomNumber, String status) {
        this.roomID = roomID;
        this.departmentID = departmentID;
        this.roomNumber = roomNumber;
        this.status = status;
    }

    public Department getDepartment() {
        return new DepartmentDAO().getDepartmentById(departmentID);
    }

    public void setDepartment(Department department) {
        this.department = department;
    }
    
    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public int getDepartmentID() {
        return departmentID;
    }

    public void setDepartmentID(int departmentID) {
        this.departmentID = departmentID;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
    
}
