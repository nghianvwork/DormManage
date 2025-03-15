/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin;

import DAO.DepartmentDAO;
import DAO.RoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Department;
import model.Room;
import model.User;
import model.UserRoom;

/**
 *
 * @author Legion
 */
@WebServlet(name = "UpdateStatusController", urlPatterns = {"/update-status"})
public class UpdateStatusController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userRoomID = Integer.parseInt(request.getParameter("userRoomID"));
        String status = request.getParameter("status");

        RoomDAO userRoomDAO = new RoomDAO();
        if (status.equals("Active")) {
            UserRoom ur = userRoomDAO.getById(userRoomID);
            Room r = ur.getRoom();
            r.setStatus("Occupied");
            userRoomDAO.updateRoom(r);
            Department dp = r.getDepartment();
            dp.setEmptyRoom(dp.getEmptyRoom() - 1);
            DepartmentDAO dpDao = new DepartmentDAO();
            dpDao.updateEmptyRoom(dp);
        }

        if (status.equals("Close")) {
            UserRoom ur = userRoomDAO.getById(userRoomID);
            Room r = ur.getRoom();
            r.setStatus("Available");
            userRoomDAO.updateRoom(r);
            Department dp = r.getDepartment();
            System.out.println(dp.getEmptyRoom());
            dp.setEmptyRoom(dp.getEmptyRoom() + 1);
            System.out.println(dp.getEmptyRoom());
            DepartmentDAO dpDao = new DepartmentDAO();
            dpDao.updateEmptyRoom(dp);
        }
        userRoomDAO.updateUserRoomStatus(userRoomID, status);

        request.getRequestDispatcher("manage-request").forward(request, response);

    }

}
