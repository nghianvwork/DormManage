/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.DepartmentDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Department;
import model.User;

/**
 *
 * @author phand
 */
@WebServlet(name = "AddDormController", urlPatterns = {"/add-dorm"})
public class AddDormController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user.getRole().equals("Manager")) {
                DepartmentDAO dao = new DepartmentDAO();
                String name = request.getParameter("departmentName");
                String address = request.getParameter("address");
                int empty = Integer.parseInt(request.getParameter("emptyRoom"));
                int price = Integer.parseInt(request.getParameter("price"));
                Department dp = new Department();
                dp.setAddress(address);
                dp.setDepartmentName(name);
                dp.setManagerID(user.getUserID());
                dp.setEmptyRoom(empty);
                dp.setPrice(price);
                dao.addDepartment(dp);

                response.sendRedirect("manage-department");
            } else {
                response.sendError(403);
            }
        } else {
            response.sendRedirect("login");
        }

    }

}
