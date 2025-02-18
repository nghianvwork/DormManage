/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Service;

/**
 *
 * @author Legion
 */
public class ServiceDAO extends DBContext {
    
    Connection conn;

    public ServiceDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect Failed");
        }
    }
    
    public Service getServiceById(int serviceID) {
        Service service = null;
        String query = "SELECT ServiceID, ServiceName, ServiceDescription, Price FROM Services WHERE ServiceID = ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {

            preparedStatement.setInt(1, serviceID);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                service = new Service();
                service.setServiceID(resultSet.getInt("ServiceID"));
                service.setServiceName(resultSet.getString("ServiceName"));
                service.setServiceDescription(resultSet.getString("ServiceDescription"));
                service.setPrice(resultSet.getDouble("Price"));
            }
        } catch (SQLException e) {
            System.out.println("getServiceById: " + e.getMessage());
        }
        return service;
    }
    
    
    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String query = "SELECT ServiceID, ServiceName, ServiceDescription, Price FROM Services";
        
        try (PreparedStatement preparedStatement = conn.prepareStatement(query);
             ResultSet resultSet = preparedStatement.executeQuery()) {
            
            while (resultSet.next()) {
                int serviceID = resultSet.getInt("ServiceID");
                String serviceName = resultSet.getString("ServiceName");
                String serviceDescription = resultSet.getString("ServiceDescription");
                double price = resultSet.getDouble("Price");
                
                Service service = new Service(serviceID, serviceName, serviceDescription, price);
                services.add(service);
            }
        } catch (SQLException e) {
            System.out.println("getAllServices: " + e.getMessage());
        }
        
        return services;
    }
    
    
    public void addService(Service service) {
        String query = "INSERT INTO Services (ServiceName, ServiceDescription, Price) VALUES (?, ?, ?)";
        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            
            preparedStatement.setString(1, service.getServiceName());
            preparedStatement.setString(2, service.getServiceDescription());
            preparedStatement.setDouble(3, service.getPrice());
            
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("addService: " + e.getMessage());
        }
    }

    public void updateService(Service service) {
        String query = "UPDATE Services SET ServiceName = ?, ServiceDescription = ?, Price = ? WHERE ServiceID = ?";
        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            
            preparedStatement.setString(1, service.getServiceName());
            preparedStatement.setString(2, service.getServiceDescription());
            preparedStatement.setDouble(3, service.getPrice());
            preparedStatement.setInt(4, service.getServiceID());
            
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("updateService: " + e.getMessage());
        }
    }
    
    
    public void removeServiceFromDorm(int dormServiceID) {
        String query = "DELETE FROM DormService WHERE dormServiceID = ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {

            preparedStatement.setInt(1, dormServiceID);

            int rowsAffected = preparedStatement.executeUpdate();
            System.out.println(rowsAffected);
        } catch (SQLException e) {
            System.out.println("removeServiceFromRoom: " + e.getMessage());
        }
    }
    public static void main(String[] args) {
        new ServiceDAO().removeServiceFromDorm(12);
    }
}
