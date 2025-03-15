/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.Admin;

import DAO.DepartmentDAO;
import DAO.RoomDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.Department;
import model.Room;
import model.User;

/**
 *
 * @author phand
 */
@WebServlet("/add-room")
public class AddRoomController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
        
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user.getRole().equals("Manager")) {
                    String roomNum = req.getParameter("roomNumber");
                    int dormID = Integer.parseInt(req.getParameter("departmentID"));
                    String status = req.getParameter("status");
                    Room room = new Room();
                    room.setDepartmentID(dormID);
                    room.setRoomNumber(roomNum);
                    room.setStatus(status);
                    RoomDAO dao = new RoomDAO();
                    dao.addRoom(room);
                    Department dp = room.getDepartment();
                    dp.setEmptyRoom(dp.getEmptyRoom()+1);
                    DepartmentDAO dDao = new DepartmentDAO();
                    dDao.updateEmptyRoom(dp);
                    resp.sendRedirect("manage-room");
            } else {
                resp.sendError(403);
            }
        } else {
            resp.sendRedirect("login");
        }
    }

}
