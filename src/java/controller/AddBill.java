/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

import DAO.BillDAO;
import DAO.DepartmentDAO;
import DAO.RoomDAO;
import DAO.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import model.Bill;
import model.BillService;
import model.Department;
import model.DormService;
import model.Room;
import model.UserRoom;

/**
 *
 * @author phand
 */
@WebServlet("/create-bill")
public class AddBill extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int roomId = Integer.parseInt(req.getParameter("roomID"));
        RoomDAO rDao = new RoomDAO();
        UserRoom uRoom = rDao.getByRoomId(roomId);
        int userId = uRoom.getUserID();
        Room r = uRoom.getRoom();
        Department dp = r.getDepartment();
        DepartmentDAO dDao = new DepartmentDAO();
        List<DormService> dormService = dDao.getAllRoomServices2(dp.getDepartmentID());
        req.setAttribute("guestID", userId);
        req.setAttribute("roomID", r.getRoomID());
        req.setAttribute("dormServices", dormService);
        req.getRequestDispatcher("create-bill.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
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
       resp.sendRedirect("manage-bill");
    }
    
    
}
