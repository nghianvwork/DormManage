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
import model.Room;

import model.User;

/**
 *
 * @author phand
 */
@WebServlet("/delete-room")
public class DeleteRoomController extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user.getRole().equals("Manager")) {
                int roomID = Integer.parseInt(request.getParameter("roomID"));
                RoomDAO dao = new RoomDAO();
                Room r = dao.getRoomById(roomID);
                dao.deleteById(roomID);
                DepartmentDAO dDao = new DepartmentDAO();
                Department dp = r.getDepartment();
                dp.setEmptyRoom(dp.getEmptyRoom()-1);
                dDao.updateEmptyRoom(dp);
                response.sendRedirect("manage-room");
            } else {
                response.sendError(403);
            }
        } else {
            response.sendRedirect("login");
        }
    }
    
}
