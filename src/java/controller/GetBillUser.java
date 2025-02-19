/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import DAO.BillDAO;
import DAO.DepartmentDAO;
import DAO.RoomDAO;
import DAO.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import model.Bill;
import model.BillService;
import model.Department;
import model.DormService;
import model.Room;

/**
 *
 * @author admin
 */
@WebServlet(name="GetBillUser", urlPatterns={"/getBillUser"})
public class GetBillUser extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GetBillUser</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GetBillUser at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("userBill.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
     int roomId = Integer.parseInt(req.getParameter("roomID"));
        int guestId =  Integer.parseInt(req.getParameter("guestID"));
        double totalAmount = Double.parseDouble(req.getParameter("totalAmount"));
        RoomDAO rDao = new RoomDAO();
        Room r = rDao.getRoomById(roomId);
        Department dp = r.getDepartment();
        DepartmentDAO dDao = new DepartmentDAO();
        BillDAO bDao = new BillDAO();
        ServiceDAO sDao = new ServiceDAO();
        int id = bDao.insertBill(new Bill(roomId, guestId, totalAmount, LocalDate.now(), Boolean.FALSE));
        List<DormService> dormService = dDao.getAllRoomServices2(dp.getDepartmentID());
        for(DormService ds : dormService){
            int oldRecord = Integer.parseInt(req.getParameter("oldReading_"+ds.getServiceID()));
            int newRecord = Integer.parseInt(req.getParameter("newReading_"+ds.getServiceID()));
            int usage = newRecord - oldRecord;
            double price = sDao.getServiceById(ds.getServiceID()).getPrice();
            double total = usage * price;
            bDao.insertBillService(new BillService(id, ds.getServiceID(), oldRecord, newRecord, total, price, usage));
        }
       resp.sendRedirect("userBill.jsp");
    
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    

}
