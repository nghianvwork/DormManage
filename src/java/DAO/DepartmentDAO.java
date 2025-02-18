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
import model.Department;
import model.DormImage;
import model.DormService;
import model.Service;
import model.Room;

/**
 *
 * @author Legion
 */
public class DepartmentDAO extends DBContext {

    Connection conn;

    public DepartmentDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect Failed");
        }
    }

    public void addDepartment(Department dp) {
        String sql = "insert into  Departments (DepartmentName,ManagerID,Address,Emptyroom,Price) values(?,?,?,?,?)";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, dp.getDepartmentName());
            pre.setInt(2, dp.getManagerID());
            pre.setString(3, dp.getAddress());
            pre.setInt(4, dp.getEmptyRoom());
            pre.setInt(5, dp.getPrice());
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public List<Room> getRoomByDormAndStatus(int dormID, String status) {
        String sql = "select * from Rooms where DepartmentID = ? and Status = ?";
        List<Room> list = new ArrayList<>();
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, dormID);
            pre.setString(2, status);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new Room(rs.getInt("RoomID"), rs.getInt("DepartmentID"), rs.getString("RoomNumber"), rs.getString("Status")));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public List<DormService> getDormServices(int id) {
        String sql = "select * from DormService where dormID = ?";
        List<DormService> list = new ArrayList<>();
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                list.add(new DormService(rs.getInt("dormServiceID"), rs.getInt("dormID"), rs.getInt("serviceID")));
            }
        } catch (SQLException e) {

        }
        return list;
    }

    public List<Service> getServicesByDormId(int roomID) {
        String GET_SERVICES_BY_ROOM_ID = "SELECT s.ServiceID, s.ServiceName, s.ServiceDescription, s.Price "
                + "FROM Services s JOIN DormService rs ON s.ServiceID = rs.ServiceID WHERE rs.dormID = ?";
        List<Service> services = new ArrayList<>();
        try (
                PreparedStatement preparedStatement = conn.prepareStatement(GET_SERVICES_BY_ROOM_ID);) {
            preparedStatement.setInt(1, roomID);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int serviceID = rs.getInt("ServiceID");
                String serviceName = rs.getString("ServiceName");
                String serviceDescription = rs.getString("ServiceDescription");
                double price = rs.getDouble("Price");
                services.add(new Service(serviceID, serviceName, serviceDescription, price));
            }
        } catch (SQLException e) {
            System.out.println("getServicesByRoomId: " + e.getMessage());
        }
        return services;
    }

    public List<DormService> getAllRoomServices2(int dormID) {
        List<DormService> roomServices = new ArrayList<>();
        String query = "SELECT dormServiceID, dormID, serviceID FROM DormService where dormID = ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setInt(1, dormID);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                DormService roomService = new DormService();
                roomService.setRoomServiceID(resultSet.getInt("dormServiceID"));
                roomService.setDormID(resultSet.getInt("dormID"));
                roomService.setServiceID(resultSet.getInt("serviceID"));
                roomServices.add(roomService);
            }
        } catch (SQLException e) {
            System.out.println("getAllRoomServices: " + e.getMessage());
        }
        return roomServices;
    }

    public void addRoomImage(int roomID, String imageURL) {
        String query = "INSERT INTO DormImage (dormID, imageURL) VALUES (?, ?)";

        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {

            preparedStatement.setInt(1, roomID);
            preparedStatement.setString(2, imageURL);

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("addRoomImage: " + e.getMessage());
        }
    }

    public boolean deleteDormImage(int dormID, String imageID) {
        String sql = "DELETE FROM DormImage WHERE dormID = ? AND imageID = ?";
        try (
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, dormID);
            stmt.setString(2, imageID);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void updateRoomImage(int imageID, String imageURL) {
        String query = "UPDATE DormImage SET imageURL = ? WHERE imageID = ?";

        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {
            preparedStatement.setString(1, imageURL);
            preparedStatement.setInt(2, imageID);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("updateRoomImage: " + e.getMessage());
        }
    }

    public int countDepartByManagerID(int id) {
        String sql = "SELECT count(*) as Total FROM Departments where ManagerID = ?";

        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                return resultSet.getInt("Total");
            }
        } catch (SQLException e) {
            System.out.println("getAllDepartments: " + e.getMessage());
        }
        return 0;
    }

    public List<Department> getAllByManagerID1(int id) {
        List<Department> departments = new ArrayList<>();
        String sql = "SELECT * FROM Departments where ManagerID = ?";
               

        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int departmentID = resultSet.getInt("DepartmentID");
                String departmentName = resultSet.getString("DepartmentName");
                int managerID = resultSet.getInt("ManagerID");
                String address = resultSet.getString("Address");
                int emptyroom = resultSet.getInt("Emptyroom");
                int price = resultSet.getInt("Price");
                Department department = new Department(departmentID, departmentName, address, emptyroom, price, managerID);
                departments.add(department);
            }
        } catch (SQLException e) {
            System.out.println("getAllDepartments1: " + e.getMessage());
        }
        return departments;
    }

    public List<Department> getAllByManagerID(int id, int pageNum, int pageSize) {
        List<Department> departments = new ArrayList<>();
        String sql = "SELECT * FROM Departments where ManagerID = ? and 1 = 1"
                + "ORDER BY DepartmentID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement statement = conn.prepareStatement(sql);
            statement.setInt(1, id);
            statement.setInt(2, pageNum); // Offset calculation for pagination
            statement.setInt(3, pageSize);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int departmentID = resultSet.getInt("DepartmentID");
                String departmentName = resultSet.getString("DepartmentName");
                int managerID = resultSet.getInt("ManagerID");
                String address = resultSet.getString("Address");
                int emptyroom = resultSet.getInt("Emptyroom");
                int price = resultSet.getInt("Price");
                Department department = new Department(departmentID, departmentName, address, emptyroom, price, managerID);
                departments.add(department);
            }
        } catch (SQLException e) {
            System.out.println("getAllDepartments: " + e.getMessage());
        }
        return departments;
    }

    public List<Department> getAllDepartments(int pageNumber, int pageSize, Integer minPrice, Integer maxPrice) {
        List<Department> departments = new ArrayList<>();

        PreparedStatement stmt = null;
        try {
            // Construct the SQL query based on the presence of minPrice and maxPrice
            String sql = "SELECT * FROM Departments WHERE 1 = 1";
            if (minPrice != null) {
                sql += " AND Price >= ?";
            }
            if (maxPrice != null) {
                sql += " AND Price <= ?";
            }
            sql += " ORDER BY DepartmentID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

            stmt = conn.prepareStatement(sql);

            int parameterIndex = 1;

            // Set parameters based on the presence of minPrice and maxPrice
            if (minPrice != null) {
                stmt.setInt(parameterIndex++, minPrice);
            }
            if (maxPrice != null) {
                stmt.setInt(parameterIndex++, maxPrice);
            }

            stmt.setInt(parameterIndex++, (pageNumber - 1) * pageSize); // Offset calculation for pagination
            stmt.setInt(parameterIndex++, pageSize);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Department room = new Department();
                room.setDepartmentID(rs.getInt("DepartmentID"));
                room.setDepartmentName(rs.getString("DepartmentName"));
                room.setAddress(rs.getString("Address"));
                room.setEmptyRoom(rs.getInt("Emptyroom"));
                room.setManagerID(rs.getInt("ManagerID"));
                room.setPrice(rs.getInt("Price"));
                // Set other attributes as needed
                departments.add(room);
            }
        } catch (SQLException e) {
            System.out.println("getNumberOfRooms: " + e.getMessage());
        }
        return departments;
    }

    public Department getDepartmentById(int departmentId) {
        Department department = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // SQL query to retrieve department details by ID
            String query = "SELECT * FROM Departments WHERE DepartmentID = ?";

            // Prepare statement
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, departmentId);

            // Execute query
            rs = stmt.executeQuery();

            // Process result set
            if (rs.next()) {
                // Retrieve department details from result set
                int id = rs.getInt("DepartmentID");
                String name = rs.getString("DepartmentName");
                int managerId = rs.getInt("ManagerID");
                String address = rs.getString("Address");
                int emptyroom = rs.getInt("Emptyroom");
                int price = rs.getInt("Price");
                // Create Department object
                department = new Department(id, name, address, emptyroom, price, managerId); // Assuming Department constructor exists
            }

        } catch (SQLException e) {
            System.out.println("getDepartmentById: " + e.getMessage());
        }

        return department;
    }

    public List<String> getRoomLinkImagesByDormID(int dormID) {
        List<String> imageUrls = new ArrayList<>();
        String query = "SELECT imageURL FROM DormImage WHERE dormID = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, dormID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String imageUrl = rs.getString("imageURL");
                imageUrls.add(imageUrl);
            }
        } catch (SQLException ex) {
            System.out.println("getRoomImagesByRoomID: " + ex.getMessage());
        }

        return imageUrls;
    }

    public List<DormImage> getRoomImagesByDormID(int dormID) {
        List<DormImage> imageUrls = new ArrayList<>();
        String query = "SELECT * FROM DormImage WHERE dormID = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, dormID);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("imageID");
                int dorm = rs.getInt("dormID");
                String imageUrl = rs.getString("imageURL");
                imageUrls.add(new DormImage(id, dormID, imageUrl));
            }
        } catch (SQLException ex) {
            System.out.println("getRoomImagesByRoomID: " + ex.getMessage());
        }

        return imageUrls;
    }

    public int getNumberOfDorms(int minPrice, int maxPrice) {
        String query = "SELECT COUNT(*) AS total FROM Departments WHERE price >= ? AND price <= ?";
        int count = 0;

        try (
                PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setDouble(1, minPrice);
            stmt.setDouble(2, maxPrice);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException ex) {
            System.out.println("getNumberOfRooms: " + ex.getMessage());
        }

        return count;
    }

    public static void main(String[] args) {
        DepartmentDAO dao = new DepartmentDAO();
        System.out.println(dao.getAllDepartments(1, 3, 0, 100000000).get(0).getDepartmentID());
        System.out.println(dao.getAllByManagerID(18, 0, 5).get(0).getDepartmentName());
    }

    public void updateEmptyRoom(Department room) {
        String sql = "update Departments set EmptyRoom = ? where DepartmentID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, room.getEmptyRoom());
            pre.setInt(2, room.getDepartmentID());
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void updateDepartment(Department room) {
        String sql = "update Departments set DepartmentName = ?, Address = ?, Price = ? where DepartmentID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, room.getDepartmentName());
            pre.setString(2, room.getAddress());
            pre.setInt(3, room.getPrice());
            pre.setInt(4, room.getDepartmentID());
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println("updaye:" + e.getMessage());
        }
    }

    public boolean addServiceToDorm(DormService roomService) {
        boolean added = false;
        String query = "INSERT INTO DormService (dormID, serviceID) VALUES (?, ?)";

        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {

            preparedStatement.setInt(1, roomService.getDormID());
            preparedStatement.setInt(2, roomService.getServiceID());

            int rowsAffected = preparedStatement.executeUpdate();
            added = rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println("addServiceToRoom: " + e.getMessage());
        }
        return added;
    }

    public void deleteById(int dormID) {
        String sql = "delete from Departments where DepartmentID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, dormID);
            pre.executeLargeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

}
