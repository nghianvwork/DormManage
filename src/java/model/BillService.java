/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class BillService {
    int billID;
    int serviceId;
    int oldRecord;
    int newRecord;
    double total;
    double price;
    int usage;

    public BillService() {
    }

    public BillService(int billID, int serviceId, int oldRecord, int newRecord, double total, double price, int usage) {
        this.billID = billID;
        this.serviceId = serviceId;
        this.oldRecord = oldRecord;
        this.newRecord = newRecord;
        this.total = total;
        this.price = price;
        this.usage = usage;
    }

    public int getBillID() {
        return billID;
    }

    public void setBillID(int billID) {
        this.billID = billID;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public int getOldRecord() {
        return oldRecord;
    }

    public void setOldRecord(int oldRecord) {
        this.oldRecord = oldRecord;
    }

    public int getNewRecord() {
        return newRecord;
    }

    public void setNewRecord(int newRecord) {
        this.newRecord = newRecord;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getUsage() {
        return usage;
    }

    public void setUsage(int usage) {
        this.usage = usage;
    }
    
    
}
