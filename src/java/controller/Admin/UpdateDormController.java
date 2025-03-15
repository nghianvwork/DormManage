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
import model.Department;
import model.Room;

/**
 *
 * @author Legion
 */
@WebServlet(name="UpdateRoomController", urlPatterns={"/update-dorm"})
public class UpdateDormController extends HttpServlet {
   


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         // Retrieve parameters from the form
        int dormID = Integer.parseInt(request.getParameter("dormID"));
        String departmentname = request.getParameter("departmentName");
        int price =Integer.parseInt(request.getParameter("price"));
        String address = request.getParameter("address");
        System.out.println("contrller:"+departmentname);
        DepartmentDAO dao = new DepartmentDAO();
        // Create a new Room object
        Department room = new Department();
        room.setDepartmentID(dormID);
        room.setDepartmentName(departmentname);
        room.setAddress(address);
        room.setPrice(price);

        // Call RoomDAO to update the room
        dao.updateDepartment(room);
        response.sendRedirect("manage-department");
    }

}
