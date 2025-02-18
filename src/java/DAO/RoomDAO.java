/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import model.UserRoom;
import dal.DBContext;
import java.util.List;
import model.Room;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import model.DormImage;
import model.DormService;
import model.Service;
import model.User;

/**
 *
 * @author Legion
 */
public class RoomDAO extends DBContext {

    Connection conn;

    public RoomDAO() {
        try {
            conn = getConnection();
        } catch (Exception e) {
            System.out.println("Connect Failed");
        }
    }

    public UserRoom getById(int id) {
        String sql = "select * from UserRooms where UserRoomID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new UserRoom(rs.getInt("UserRoomID"), rs.getInt("UserID"), rs.getInt("RoomID"), rs.getDate("StartDate").toLocalDate(), rs.getDate("EndDate").toLocalDate(), sql);
            }
        } catch (SQLException e) {
            System.out.println("get id: " + e.getMessage());
        }
        return null;
    }

    public UserRoom getByRoomId(int id) {
        String sql = "select * from UserRooms where RoomID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            if (rs.next()) {
                return new UserRoom(rs.getInt("UserRoomID"), rs.getInt("UserID"), rs.getInt("RoomID"), rs.getDate("StartDate").toLocalDate(), rs.getDate("EndDate").toLocalDate(), sql);
            }
        } catch (SQLException e) {
            System.out.println("get id: " + e.getMessage());
        }
        return null;
    }

    public void updateUserRoomStatus(int userRoomID, String status) {
        String query = "UPDATE UserRooms SET status = ? ";
        if (status.equalsIgnoreCase("close")) {
            query += ", endDate = getDate()";
        }
        query += "WHERE UserRoomID = ?";
        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {

            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, userRoomID);

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("updateUserRoomStatus: " + e.getMessage());
        }
    }

    public boolean isRoomOccupied(int roomId) {
        String query = "SELECT COUNT(*) FROM UserRooms WHERE status = 'active' AND RoomID = ?";
        boolean isOccupied = false;

        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {

            preparedStatement.setInt(1, roomId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                int count = resultSet.getInt(1);
                isOccupied = count > 0;
            }

        } catch (SQLException e) {
            System.out.println("isRoomOccupied: " + e.getMessage());
        }

        return isOccupied;
    }

    public String getOccupyingUsername(int roomId) {
        String query = "SELECT u.[UserID], u.[Username], u.[FullName] "
                + "FROM [UserRooms] ur "
                + "JOIN [Users] u ON ur.[UserID] = u.[UserID] "
                + "WHERE ur.[status] = 'active' AND ur.[RoomID] = ?";
        String username = null;

        try (PreparedStatement preparedStatement = conn.prepareStatement(query)) {

            preparedStatement.setInt(1, roomId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                username = resultSet.getString("Username");
            }

        } catch (SQLException e) {
            System.out.println("getOccupyingUsername: " + e.getMessage());
        }

        return username;
    }

    public List<Room> getAllRooms(int userID, int pageNumber, int pageSize) {
        List<Room> rooms = new ArrayList<>();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {

            // Construct the SQL query based on the presence of minPrice and maxPrice
            String sql = "SELECT RoomID, Rooms.DepartmentID,RoomNumber,Status FROM Rooms"
                    + " join Departments on Rooms.DepartmentID = Departments.DepartmentID"
                    + " WHERE 1 = 1 and Departments.ManagerID = ?";
            sql += " ORDER BY RoomID OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userID);
            stmt.setInt(2, (pageNumber)); // Offset calculation for pagination
            stmt.setInt(3, pageSize);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Room room = new Room();
                room.setRoomID(rs.getInt("RoomID"));
                room.setDepartmentID(rs.getInt("DepartmentID"));
                room.setRoomNumber(rs.getString("RoomNumber"));
                room.setStatus(rs.getString("Status"));
                // Set other attributes as needed
                rooms.add(room);
            }
        } catch (SQLException e) {
            System.out.println("getNumberOfRooms: " + e.getMessage());
        }
        return rooms;
    }

    public int getNumberOfRooms(double minPrice, double maxPrice) {
        String query = "SELECT COUNT(*) AS total FROM Rooms WHERE price >= ? AND price <= ?";
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

    private static final String GET_ROOM_BY_ID = "SELECT * FROM Rooms WHERE RoomID = ?";

    public Room getRoomById(int roomID) {
        Room room = null;
        try (
                PreparedStatement preparedStatement = conn.prepareStatement(GET_ROOM_BY_ID);) {
            preparedStatement.setInt(1, roomID);
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                String roomNumber = rs.getString("RoomNumber");
                int departmentID = rs.getInt("departmentID");
                String status = rs.getString("Status");
                room = new Room(roomID, departmentID, roomNumber, status);
            }
        } catch (SQLException e) {
            System.out.println("getRoomById: " + e.getMessage());
        }
        return room;
    }

    private static final String INSERT_BOOKING_SQL = "INSERT INTO UserRooms (UserID, RoomID, StartDate,Enddate, Status) VALUES (?,?, ?, ?, ?)";

    public void bookRoom(UserRoom userRoom) {
        try (
                PreparedStatement preparedStatement = conn.prepareStatement(INSERT_BOOKING_SQL)) {
            preparedStatement.setInt(1, userRoom.getUserID());
            preparedStatement.setInt(2, userRoom.getRoomID());
            preparedStatement.setDate(3, java.sql.Date.valueOf(userRoom.getStartDate()));
            preparedStatement.setDate(4, java.sql.Date.valueOf(userRoom.getEndDate()));
            preparedStatement.setString(5, userRoom.getStatus());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("bookRoom: " + e.getMessage());
        }
    }

    private static final String SELECT_BOOKING_HISTORY_SQL = "SELECT ur.UserRoomID, ur.RoomID, ur.StartDate, ur.EndDate, ur.Status, r.RoomNumber "
            + "FROM UserRooms ur "
            + "JOIN Rooms r ON ur.RoomID = r.RoomID "
            + "WHERE ur.UserID = ?";

    public List<UserRoom> getBookingHistory(int userID) {
        List<UserRoom> bookingHistory = new ArrayList<>();
        try (
                PreparedStatement preparedStatement = conn.prepareStatement(SELECT_BOOKING_HISTORY_SQL)) {
            preparedStatement.setInt(1, userID);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                UserRoom userRoom = new UserRoom();
                userRoom.setUserRoomID(rs.getInt("UserRoomID"));
                userRoom.setRoomID(rs.getInt("RoomID"));
                userRoom.setStartDate(rs.getDate("StartDate").toLocalDate());
                userRoom.setEndDate(rs.getDate("EndDate") != null ? rs.getDate("EndDate").toLocalDate() : null);
                userRoom.setStatus(rs.getString("Status"));
                bookingHistory.add(userRoom);
            }
        } catch (SQLException e) {
            System.out.println("getBookingHistory: " + e.getMessage());
        }
        return bookingHistory;
    }

    private static final String SELECT_BOOKING_REQUEST_SQL = "SELECT ur.UserRoomID, ur.UserID, ur.RoomID, ur.StartDate, ur.EndDate, ur.Status, r.RoomNumber "
            + "FROM UserRooms ur "
            + "JOIN Rooms r ON ur.RoomID = r.RoomID "
            + "join Departments dp on r.DepartmentID = dp.[DepartmentID]"
            + "where dp.[ManagerID] = ?";

    public List<UserRoom> getBookingRequest(int Userid) {
        List<UserRoom> bookingHistory = new ArrayList<>();
        try (
                PreparedStatement preparedStatement = conn.prepareStatement(SELECT_BOOKING_REQUEST_SQL)) {
            preparedStatement.setInt(1, Userid);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                UserRoom userRoom = new UserRoom();
                userRoom.setUserRoomID(rs.getInt("UserRoomID"));
                userRoom.setRoomID(rs.getInt("RoomID"));
                userRoom.setUserID(rs.getInt("UserID"));
                userRoom.setStartDate(rs.getDate("StartDate").toLocalDate());
                userRoom.setEndDate(rs.getDate("EndDate") != null ? rs.getDate("EndDate").toLocalDate() : null);
                userRoom.setStatus(rs.getString("Status"));
                bookingHistory.add(userRoom);
            }
        } catch (SQLException e) {
            System.out.println("getBookingHistory: " + e.getMessage());
        }
        return bookingHistory;
    }

    private static final String SELECT_ACTIVE_BOOKINGS_SQL = "SELECT ur.UserRoomID, ur.RoomID, ur.StartDate, ur.EndDate, ur.Status, r.RoomNumber "
            + "FROM UserRooms ur "
            + "JOIN Rooms r ON ur.RoomID = r.RoomID "
            + "WHERE ur.UserID = ? AND ur.Status = 'Active'";

    public List<UserRoom> getActiveBookings(int userID) {
        List<UserRoom> activeBookings = new ArrayList<>();
        try (
                PreparedStatement preparedStatement = conn.prepareStatement(SELECT_ACTIVE_BOOKINGS_SQL)) {
            preparedStatement.setInt(1, userID);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                UserRoom userRoom = new UserRoom();
                userRoom.setUserRoomID(rs.getInt("UserRoomID"));
                userRoom.setRoomID(rs.getInt("RoomID"));
                userRoom.setStartDate(rs.getDate("StartDate").toLocalDate());
                userRoom.setEndDate(rs.getDate("EndDate") != null ? rs.getDate("EndDate").toLocalDate() : null);
                userRoom.setStatus(rs.getString("Status"));
                activeBookings.add(userRoom);
            }
        } catch (SQLException e) {
            System.out.println("getBookingHistory: " + e.getMessage());
        }
        return activeBookings;
    }

    public int getNumberOfRooms(int userID) {
        int count = 0;
        String query = "SELECT count(*) as Total FROM Rooms"
                + " join Departments on Rooms.DepartmentID = Departments.DepartmentID"
                + " WHERE Departments.ManagerID = ? ";

        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setInt(1, userID);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                count = resultSet.getInt("Total");
            }
        } catch (SQLException e) {
            System.out.println("getNumberOfRoomsByName: " + e.getMessage());
        }
        return count;
    }

    public boolean addRoom(Room room) {
        String query = "INSERT INTO Rooms (DepartmentID, RoomNumber, Status) "
                + "VALUES (?, ?, ?)";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setInt(1, room.getDepartmentID());
            statement.setString(2, room.getRoomNumber());
            statement.setString(3, room.getStatus());
            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.out.println("addRoom: " + e.getMessage());
            return false;
        }
    }

    // Method to update an existing room
    public boolean updateRoom(Room room) {
        String query = "UPDATE Rooms "
                + "SET DepartmentID = ?, RoomNumber = ?, Status = ? "
                + "WHERE RoomID = ?";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setInt(1, room.getDepartmentID());
            statement.setString(2, room.getRoomNumber());
            statement.setString(3, room.getStatus());
            statement.setInt(4, room.getRoomID());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println("updateRoom: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteRoomImage(int roomID, String imageID) {
        String sql = "DELETE FROM DormImage WHERE dormID = ? AND imageID = ?";
        try (
                PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, roomID);
            stmt.setString(2, imageID);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public static void main(String[] args) {
        RoomDAO dao = new RoomDAO();
        System.out.println(dao.getNumberOfRooms(18));
        dao.getAllRooms(18, 0, 3).forEach((r) -> {
            System.out.println(r.getRoomNumber());
        });

        System.out.println(dao.getBookingRequest(18).get(0).getRoomID());
    }

    public void deleteById(int roomID) {
        String sql = "delete from Rooms where RoomID = ?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setInt(1, roomID);
            pre.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
 
}
