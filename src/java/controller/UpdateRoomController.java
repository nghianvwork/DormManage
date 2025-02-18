/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

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
import model.User;
import model.Room;
/**
 *
 * @author phand
 */
@WebServlet("/update-room")
public class UpdateRoomController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        if(session != null){
            User us = (User) session.getAttribute("user");
            if(us.getRole().equals("Manager")){
                String roomNum = req.getParameter("roomNumber");
                String status = req.getParameter("status");
                int departmentId = Integer.parseInt(req.getParameter("departmentID"));
                int roomID = Integer.parseInt(req.getParameter("roomID"));
                Room room = new Room(roomID, departmentId, roomNum, status);
                RoomDAO dao = new RoomDAO();
                if(!room.getStatus().equals("Available")){
                    Department dp = room.getDepartment();
                    dp.setEmptyRoom(dp.getEmptyRoom()-1);
                    DepartmentDAO dpDao = new DepartmentDAO();
                    dpDao.updateEmptyRoom(dp);
                }
                dao.updateRoom(room);
                resp.sendRedirect("manage-room");
            }else{
                resp.sendError(403);
            }
        }else{
            resp.sendRedirect("login");
        }
    }
    
}
