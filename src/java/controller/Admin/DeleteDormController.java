    /*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.Admin;

import DAO.DepartmentDAO;
import DAO.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import model.DormImage;
import model.Service;
import model.User;

/**
 *
 * @author phand
 */
@WebServlet("/delete-dorm")
public class DeleteDormController extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user.getRole().equals("Manager")) {
              int dormID = Integer.parseInt(request.getParameter("dormID"));
              DepartmentDAO dao = new DepartmentDAO();
              dao.deleteById(dormID);
                response.sendRedirect("manage-department");
            } else {
                response.sendError(403);
            }
        } else {
            response.sendRedirect("login");
        }
    }
    
    
}
