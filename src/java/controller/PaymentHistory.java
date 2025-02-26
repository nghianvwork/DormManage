package controller;

import DAO.BillDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Bill;
import model.User;

/**
 * Servlet xử lý lịch sử thanh toán
 */
@WebServlet(name = "PaymentHistoryServlet", urlPatterns = {"/payment-history"})
public class PaymentHistory extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                BillDAO billDAO = new BillDAO();
                List<Bill> bills;

                
                if ("Manager".equals(user.getRole())) {
                    bills = billDAO.getAllBills();
                     request.setAttribute("bills", bills);
                request.getRequestDispatcher("payment-history-admin.jsp").forward(request, response);
                    
                } else {
                    bills = billDAO.getBillsByUserId(user.getUserID());
                     request.setAttribute("bills", bills);
                request.getRequestDispatcher("payment-history-user.jsp").forward(request, response);
                }

                request.getRequestDispatcher("payment-history.jsp").forward(request, response);
            } else {
                response.sendRedirect("login");
            }
        } else {
            response.sendRedirect("login");
        }
    }
    
}
