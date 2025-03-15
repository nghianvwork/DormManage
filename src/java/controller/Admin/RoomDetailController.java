/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.Admin;

import DAO.DepartmentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Service;
import model.Department;
import model.DormImage;
import model.Room;
/**
 *
 * @author Legion
 */
@WebServlet(name="RoomDetailController", urlPatterns={"/dorm-detail"})
public class RoomDetailController extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int roomID = Integer.parseInt(request.getParameter("dormID"));

        DepartmentDAO roomDAO = new DepartmentDAO();
        Department room = roomDAO.getDepartmentById(roomID);
        List<DormImage> roomImages = roomDAO.getRoomImagesByDormID(roomID);
        List<Service> roomServices = roomDAO.getServicesByDormId(roomID);
        List<Room> listRoomAvailable = roomDAO.getRoomByDormAndStatus(roomID, "Available");
        System.out.println(listRoomAvailable);
        request.setAttribute("dorm", room);
        request.setAttribute("dormImages", roomImages);
        request.setAttribute("dormServices", roomServices);
        request.setAttribute("listRoomAvailable", listRoomAvailable);
        request.getRequestDispatcher("roomDetail.jsp").forward(request, response);
    } 

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }


}
