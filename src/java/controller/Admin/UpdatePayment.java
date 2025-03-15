package controller.Admin;

import DAO.BillDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.User;

/**
 * Servlet xử lý cập nhật trạng thái thanh toán
 */
@WebServlet(name = "UpdatePaymentServlet", urlPatterns = {"/update-payment"})
public class UpdatePayment extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Object userObj = session.getAttribute("user");
            if (userObj != null && ((User) userObj).getRole().equals("Admin")) {
                int billID = Integer.parseInt(request.getParameter("billID"));
                BillDAO billDAO = new BillDAO();
                billDAO.updatePaymentStatus(billID, true);
                response.sendRedirect("payment-history");
            } else {
                response.sendError(403);
            }
        } else {
            response.sendRedirect("login");
        }
    }
}
