/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Legion
 */
public class DormImage {
    private int imageID;
    private int dormID; // Foreign key to Room
    private String imageURL;

    public DormImage() {
    }

    public DormImage(int imageID, int dormID, String imageURL) {
        this.imageID = imageID;
        this.dormID = dormID;
        this.imageURL = imageURL;
    }

    public int getImageID() {
        return imageID;
    }

    public void setImageID(int imageID) {
        this.imageID = imageID;
    }

    public int getDormID() {
        return dormID;
    }

    public void setDormID(int dormID) {
        this.dormID = dormID;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }
    
}
