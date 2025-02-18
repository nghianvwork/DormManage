/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.DepartmentDAO;
import DAO.RoomDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Department;
import model.Room;
import model.User;

/**
 *
 * @author Legion
 */
@WebServlet(name = "MangeRoomController", urlPatterns = {"/manage-room"})
public class MangeRoomController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession ss = request.getSession(false);
        if (ss != null) {
            User us = (User) ss.getAttribute("user");
            int page = 1;
            int recordsPerPage = 5; // Number of records per page
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }

           
            
            RoomDAO roomDAO = new RoomDAO();
            List<Room> rooms = roomDAO.getAllRooms(us.getUserID(), (page-1) * recordsPerPage, recordsPerPage);
            int numberOfRooms = roomDAO.getNumberOfRooms(us.getUserID()); // Get total count for pagination
            int numberOfPages = (int) Math.ceil((double) numberOfRooms / recordsPerPage);
            List<Department> departments = new DepartmentDAO().getAllByManagerID1(us.getUserID());
            request.setAttribute("rooms", rooms);
            request.setAttribute("departments", departments);
            request.setAttribute("numberOfPages", numberOfPages);
            request.setAttribute("currentPage", page);

            request.getRequestDispatcher("manage-room.jsp").forward(request, response);
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
