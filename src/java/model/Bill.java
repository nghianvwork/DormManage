/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;

/**
 *
 * @author phand
 */
public class Bill {
    
    int billID;
   
    int roomID;
    int guestID;
    double totalCost;
    LocalDate createDate;
    Boolean paymentStatus;
    Boolean adminConfirmed;

   
   

    public Bill(int billID, int roomID, int guestID, double totalCost, LocalDate createDate, Boolean paymentStatus, Boolean adminConfirmed) {
        this.billID = billID;
        this.roomID = roomID;
        this.guestID = guestID;
        this.totalCost = totalCost;
        this.createDate = createDate;
        this.paymentStatus = paymentStatus;
        this.adminConfirmed = adminConfirmed;
    }

    public Boolean getAdminConfirmed() {
        return adminConfirmed;
    }

    public void setAdminConfirmed(Boolean adminConfirmed) {
        this.adminConfirmed = adminConfirmed;
    }
    
    public Bill() {
    }

    public Bill( int roomID, int guestID, double totalCost, LocalDate createDate, Boolean paymentStatus) {
        this.roomID = roomID;
        this.guestID = guestID;
        this.totalCost = totalCost;
        this.createDate = createDate;
        this.paymentStatus = paymentStatus;
    }
    
    public Bill(int billID, int roomID, int guestID, double totalCost, LocalDate createDate, Boolean paymentStatus) {
        this.billID = billID;
        this.roomID = roomID;
        this.guestID = guestID;
        this.totalCost = totalCost;
        this.createDate = createDate;
        this.paymentStatus = paymentStatus;
    }

    public int getBillID() {
        return billID;
    }

    public void setBillID(int billID) {
        this.billID = billID;
    }

    public int getRoomID() {
        return roomID;
    }

    public void setRoomID(int roomID) {
        this.roomID = roomID;
    }

    public int getGuestID() {
        return guestID;
    }

    public void setGuestID(int guestID) {
        this.guestID = guestID;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        this.totalCost = totalCost;
    }

    public LocalDate getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDate createDate) {
        this.createDate = createDate;
    }

    public Boolean getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(Boolean paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    @Override
    public String toString() {
        return "Bill{" + "billID=" + billID + ", roomID=" + roomID + ", guestID=" + guestID + ", totalCost=" + totalCost + ", createDate=" + createDate + ", paymentStatus=" + paymentStatus + ", adminConfirmed=" + adminConfirmed + '}';
    }

   
  

   

}
