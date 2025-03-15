/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin;

import DAO.DepartmentDAO;
import DAO.RoomDAO;
import DAO.ServiceDAO;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.DormImage;
import model.DormService;
import model.Service;
import model.User;

/**
 *
 * @author Legion
 */
@WebServlet(name = "AdminRoomDetailController", urlPatterns = {"/admin-room-detail"})
public class AdminDormDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user.getRole().equals("Manager")) {
                int dormID = Integer.parseInt(request.getParameter("dormID"));

                DepartmentDAO rdao = new DepartmentDAO();
                ServiceDAO sDao = new ServiceDAO();
                List<DormImage> roomImages = rdao.getRoomImagesByDormID(dormID);
                List<DormService> roomAllServices = rdao.getAllRoomServices2(dormID);
                List<Service> allServicees = sDao.getAllServices();
//                List<Service> roomAllServices = rdao.getServicesByDormId(dormID);

                request.setAttribute("allServices", allServicees);
                request.setAttribute("dormAllServices", roomAllServices);

                request.setAttribute("dormImages", roomImages);
                request.setAttribute("dormID", dormID);
                request.getRequestDispatcher("admin-room-detail.jsp").forward(request, response);
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
