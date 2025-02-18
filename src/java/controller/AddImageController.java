/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DAO.DepartmentDAO;
import DAO.RoomDAO;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import config.CloudinaryConfig;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Map;
import model.User;
import org.apache.commons.io.IOUtils;

/**
 *
 * @author Legion
 */
@MultipartConfig
@WebServlet(name = "AddImageController", urlPatterns = {"/add-image"})
public class AddImageController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user.getRole().equals("Manager")) {
                CloudinaryConfig cloud = new CloudinaryConfig();
                Cloudinary cloudinary = cloud.getCloudinary();
                Part imageURL = request.getPart("image");
                File tempFile = File.createTempFile("upload", null);
                try (InputStream input = imageURL.getInputStream(); OutputStream output = new FileOutputStream(tempFile)) {
                    IOUtils.copy(input, output);
                }
                Map uploadRs = cloudinary.uploader().upload(tempFile, ObjectUtils.emptyMap());
                String url = (String) uploadRs.get("secure_url");
                System.out.println(request.getParameter("dormID"));
                int dormID = Integer.parseInt(request.getParameter("dormID"));
                DepartmentDAO dao = new DepartmentDAO();
                dao.addRoomImage(dormID, url);
                response.sendRedirect("admin-room-detail?dormID=" + dormID);
            } else {
                response.sendError(403);
            }
        } else {
            response.sendRedirect("login");
        }
    }

}
