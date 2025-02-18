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
import model.DormService;
import model.User;

/**
 *
 * @author Legion
 */
@WebServlet(name = "AddRoomServiceController", urlPatterns = {"/add-dorm-service"})
public class AddDormServiceController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user.getRole().equals("Manager")) {
                int dormID = Integer.parseInt(request.getParameter("dormID"));
                int serviceID = Integer.parseInt(request.getParameter("serviceID"));

                DormService roomService = new DormService();
                roomService.setDormID(dormID);
                roomService.setServiceID(serviceID);

                DepartmentDAO dao = new DepartmentDAO();
                dao.addServiceToDorm(roomService);
                response.sendRedirect("admin-room-detail?dormID=" + dormID);
            } else {
                response.sendError(403);
            }
        } else {
            response.sendRedirect("login");
        }
    }

}
