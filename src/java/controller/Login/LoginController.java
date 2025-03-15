/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Login;

import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author Legion
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        // Retrieve user from database based on username
        User user = new UserDAO().getUserByUsername(username);

        if (user != null && user.getPasswordHash().equals(password)) {
            request.getSession().setAttribute("user", user);
            if (user.getRole().equalsIgnoreCase("user")) {

                response.sendRedirect("home");

            } else {
                response.sendRedirect("manage-department");
            }
        } else {
            // Authentication failed, redirect back to login page with appropriate error message
            if (user == null) {
                // Username not found
                request.setAttribute("error", "username");
            } else {
                // Incorrect password
                request.setAttribute("error", "password");
            }
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

}
