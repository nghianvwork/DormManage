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
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Department;
import model.Room;
import model.User;

/**
 *
 * @author phand
 */
@WebServlet(name = "ManageBill", urlPatterns = {"/manage-bill"})
public class ManageBill extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User us = (User) session.getAttribute("user");
            if (us.getRole().equals("Manager")) {
                //Body here
                int page = 1;
                int recordsPerPage = 5; // Number of records per page
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }

                RoomDAO roomDAO = new RoomDAO();
                List<Room> rooms = roomDAO.getAllRooms(us.getUserID(), (page - 1) * recordsPerPage, recordsPerPage);
                int numberOfRooms = roomDAO.getNumberOfRooms(us.getUserID()); // Get total count for pagination
                int numberOfPages = (int) Math.ceil((double) numberOfRooms / recordsPerPage);
                List<Department> departments = new DepartmentDAO().getAllByManagerID1(us.getUserID());
                request.setAttribute("rooms", rooms);
                request.setAttribute("departments", departments);
                request.setAttribute("numberOfPages", numberOfPages);
                request.setAttribute("currentPage", page);
                request.getRequestDispatcher("manage-bill.jsp").forward(request, response);
            } else {
                response.sendError(403);
            }
        } else {
            response.sendRedirect("login");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
