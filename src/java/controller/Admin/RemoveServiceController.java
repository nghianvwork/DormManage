/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin;

import DAO.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author Legion
 */
@WebServlet(name = "RemoveServiceController", urlPatterns = {"/remove-service"})
public class RemoveServiceController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user.getRole().equals("Manager")) {
                int roomServiceID = Integer.parseInt(request.getParameter("dormServiceID"));
                String roomID = request.getParameter("dormID");
                ServiceDAO roomServiceDAO = new ServiceDAO();
                roomServiceDAO.removeServiceFromDorm(roomServiceID);

                response.sendRedirect("admin-room-detail?dormID=" + roomID);
            } else {
                response.sendError(403);
            }
        } else {
            response.sendRedirect("login");
        }

    }

}
