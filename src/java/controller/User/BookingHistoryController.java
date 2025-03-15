/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.User;

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
import model.User;
import model.UserRoom;

/**
 *
 * @author Legion
 */
@WebServlet(name = "BookingHistoryController", urlPatterns = {"/booking-history"})
public class BookingHistoryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");

            if (user != null && user.getRole().equals("User")) {
                RoomDAO roomDAO = new RoomDAO();
                int userID = ((User) request.getSession().getAttribute("user")).getUserID();
                List<UserRoom> bookingHistory = roomDAO.getBookingHistory(userID);
                request.setAttribute("bookingHistory", bookingHistory);
                request.getRequestDispatcher("booking-history.jsp").forward(request, response);
            } else if (user == null) {
                response.sendRedirect("login");
            } else {
                response.sendError(403);
            }
        } else {
            response.sendRedirect("login");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
