/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin;

import DAO.DepartmentDAO;
import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Department;
import model.User;

/**
 *
 * @author phand
 */
@WebServlet(name = "manage-dorm", urlPatterns = {"/manage-department"})
public class ManageDormController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
        Cookie cookies[] = request.getCookies();
        String authToken = null;

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("auth_token".equals(cookie.getName())) {
                    authToken = cookie.getValue();
                }
            }
        }
        if (authToken != null && validateToken(authToken)) {
            // Nếu token hợp lệ, đăng nhập tự động
            String username = getUsernameFromToken(authToken);
            UserDAO dao = new UserDAO();
            User u = dao.getUserByUsername(username);
            HttpSession session = request.getSession();
            if (u.getRole().equals("Manager")) {
                session.setAttribute("user", u);
            }

        } else {
        }

        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user.getRole().equals("Manager")) {
                int page = 1;
                int recordsPerPage = 5; // Number of records per page
                if (request.getParameter("page") != null) {
                    page = Integer.parseInt(request.getParameter("page"));
                }

                String roomName = request.getParameter("dormName"); // Get search parameter
                if (roomName == null) {
                    roomName = ""; // Default empty search
                }

                DepartmentDAO departmentDAO = new DepartmentDAO();

                int numberOfRooms = departmentDAO.countDepartByManagerID(user.getUserID()); // Get total count for pagination
                int numberOfPages = (int) Math.ceil((double) numberOfRooms / recordsPerPage);
                List<Department> departments = new DepartmentDAO().getAllByManagerID(user.getUserID(), (page - 1) * recordsPerPage, recordsPerPage);
                System.out.println(departments.isEmpty());
                request.setAttribute("departments", departments);
                request.setAttribute("numberOfPages", numberOfPages);
                request.setAttribute("currentPage", page);

                request.getRequestDispatcher("manage-dorm.jsp").forward(request, response);
            } else {
                response.sendError(403);
            }
        } else {
            response.sendRedirect("login");
        }
    }

    private boolean validateToken(String token) {
        // Xác thực token, ví dụ kiểm tra token trong cơ sở dữ liệu
        return token.endsWith("_9124_token"); // Ví dụ đơn giản, bạn nên sử dụng cơ chế an toàn hơn
    }

    private String getUsernameFromToken(String token) {
        // Lấy username từ token
        return token.replace("_9124_token", "");
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
}
