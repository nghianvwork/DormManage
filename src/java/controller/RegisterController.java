/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import model.User;

/**
 *
 * @author Legion
 */
@WebServlet(name="RegisterController", urlPatterns={"/register"})
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String role = request.getParameter("role");
        UserDAO userDAO = new UserDAO();

        // Check if username or email already exists
        if (userDAO.getUserByUsername(username) != null) {
            // Username already exists, redirect back to register page with error message
            response.sendRedirect("register.jsp?error=username");
            return;
        }

        if (userDAO.getUserByEmail(email) != null) {
            // Email already exists, redirect back to register page with error message
            response.sendRedirect("register.jsp?error=email");
            return;
        }

        // Create new User object
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setPasswordHash(password); // Ensure to hash the password securely
        newUser.setEmail(email);
        newUser.setFullName(fullName);
        newUser.setRole(role);
        newUser.setRegistrationDate(LocalDateTime.now());

        // Save user to database
        userDAO.addUser(newUser);
        
        // Redirect to login page after successful registration
        response.sendRedirect("login.jsp");
    }

}
