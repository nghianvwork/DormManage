/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import DAO.DepartmentDAO;
import java.util.List;

/**
 *
 * @author Legion
 */
public class Department {
    private int departmentID;
    private String departmentName;
    private String address;
    private int emptyRoom;
    private int price;
    private int managerID; 
    
    
    private List<String> listImage;
    // Constructors, getters, and setters

    public List<String> getListImage() {
        return new DepartmentDAO().getRoomLinkImagesByDormID(this.departmentID);
    }

    public void setListImage(List<String> listImage) {
        this.listImage = listImage;
    }
    
    public Department() {
    }

    public Department(int departmentID, String departmentName, String address, int emptyRoom, int price, int managerID) {
        this.departmentID = departmentID;
        this.departmentName = departmentName;
        this.address = address;
        this.emptyRoom = emptyRoom;
        this.price = price;
        this.managerID = managerID;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    
    
    public int getEmptyRoom() {
        return emptyRoom;
    }

    public void setEmptyRoom(int emptyRoom) {
        this.emptyRoom = emptyRoom;
    }

    
    public int getDepartmentID() {
        return departmentID;
    }

    public void setDepartmentID(int departmentID) {
        this.departmentID = departmentID;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getManagerID() {
        return managerID;
    }

    public void setManagerID(int managerID) {
        this.managerID = managerID;
    }

   
    
    
    
}

