package controller.User;

import DAO.BillDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet xử lý thanh toán của User
 */
@WebServlet(name = "PaymentUserServlet", urlPatterns = {"/payment-user"})
public class PaymentUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object userObj = session.getAttribute("user");
            if (userObj != null) {
                int billID = Integer.parseInt(request.getParameter("billID"));
                double amount = Double.parseDouble(request.getParameter("amount"));

                
                boolean paymentSuccess = processPayment(amount);

                if (paymentSuccess) {
                    BillDAO billDAO = new BillDAO();
                    billDAO.updatePaymentStatus(billID, true);
                    response.sendRedirect("payment-history?success=true");
                } else {
                    response.sendRedirect("payment-history?error=failed");
                }
            } else {
                response.sendRedirect("login");
            }
        } else {
            response.sendRedirect("login");
        }
    }

    private boolean processPayment(double amount) {
       
        return amount > 0;
    }
}
