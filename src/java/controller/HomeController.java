/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.DepartmentDAO;
import DAO.RoomDAO;
import DAO.UserDAO;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
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
@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        DepartmentDAO departmentDAO = new DepartmentDAO();
        int pageNumber = 1; // Default page number
        int pageSize = 9; // Number of rooms per page
        int minPrice = 0; // Default minPrice
        int maxPrice = Integer.MAX_VALUE; // Default maxPrice

        // Retrieve parameters from request
        if (request.getParameter("page") != null) {
            pageNumber = Integer.parseInt(request.getParameter("page"));
        }
        if (request.getParameter("minPrice") != null && !request.getParameter("minPrice").isEmpty()) {
            minPrice = Integer.parseInt(request.getParameter("minPrice"));
        }
        if (request.getParameter("maxPrice") != null && !request.getParameter("maxPrice").isEmpty()) {
            maxPrice = Integer.parseInt(request.getParameter("maxPrice"));
        }

        // Fetch rooms based on pagination and filtering
        List<Department> dorms = departmentDAO.getAllDepartments(pageNumber, pageSize, minPrice, maxPrice);
        int totalRooms = departmentDAO.getNumberOfDorms(minPrice, maxPrice);
        int totalPages = (int) Math.ceil((double) totalRooms / pageSize);
        // Set attributes to be accessed in JSP
        request.setAttribute("departments", dorms);
        request.setAttribute("pageNumber", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        // Forward the request to room.jsp
        request.getRequestDispatcher("home.jsp").forward(request, response);
        
    }

    private boolean validateToken(String token) {
        // Xác thực token, ví dụ kiểm tra token trong cơ sở dữ liệu
        return token.endsWith("_9124_token"); // Ví dụ đơn giản, bạn nên sử dụng cơ chế an toàn hơn
    }

    private String getUsernameFromToken(String token) {
        // Lấy username từ token
        return token.replace("_9124_token", "");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

}
