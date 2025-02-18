/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import DAO.ServiceDAO;
import model.Service;

/**
 *
 * @author Legion
 */
public class DormService {

    private int dormServiceID;
    private int dormID;
    private int serviceID;
    private Service service;

    public DormService(int dormServiceID, int dormID, int serviceID) {
        this.dormServiceID = dormServiceID;
        this.dormID = dormID;
        this.serviceID = serviceID;
    }

    public DormService() {
    }

    public int getDormServiceID() {
        return dormServiceID;
    }

    public void setDormServiceID(int dormServiceID) {
        this.dormServiceID = dormServiceID;
    }

    public Service getService() {
        return new ServiceDAO().getServiceById(serviceID);
    }

    // Getters and setters
    public int getRoomServiceID() {
        return dormServiceID;
    }

    public void setRoomServiceID(int dormServiceID) {
        this.dormServiceID = dormServiceID;
    }

    public int getDormID() {
        return dormID;
    }

    public void setDormID(int dormID) {
        this.dormID = dormID;
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }
}
