/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.Admin
;

import DAO.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Service;

/**
 *
 * @author Legion
 */
@WebServlet(name="UpdateServiceController", urlPatterns={"/update-service"})
public class UpdateServiceController extends HttpServlet {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int serviceID = Integer.parseInt(request.getParameter("serviceID"));
        String serviceName = request.getParameter("serviceName");
        String serviceDescription = request.getParameter("serviceDescription");
        double price = Double.parseDouble(request.getParameter("price"));

        ServiceDAO serviceDAO = new ServiceDAO();
        serviceDAO.updateService(new Service(serviceID, serviceName, serviceDescription, price));

        response.sendRedirect("manage-service");
    }


}
