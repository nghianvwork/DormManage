<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment History</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="navigation.jsp" />
    
    <div class="container mt-4">
        <h2 class="text-center">Payment</h2>
        
        <table class="table table-bordered table-striped text-center">
            <thead class="thead-dark">
                <tr>
                    <th>Bill ID</th>
                    <th>Room ID</th>
                    <th>Guest ID</th>
                    <th>Total Cost</th>
                    <th>Create Date</th>
                    <th>Payment Status</th>
                    <c:if test="${sessionScope.user.role == 'User'}">
                        <th>Action</th>
                    </c:if>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="bill" items="${bills}">
                    <tr>
                        <td>${bill.billID}</td>
                        <td>${bill.roomID}</td>
                        <td>${bill.guestID}</td>
                        <td>${bill.totalCost} $</td>
                        <td>${bill.createDate}</td>
                        <td>
                            <c:choose>
                                <c:when test="${bill.paymentStatus}">
                                    <span class="badge bg-success">Paid</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger">Unpaid</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <c:if test="${sessionScope.user.role == 'User'}">
                            <td>
                                <c:if test="${!bill.paymentStatus}">
                                    <form action="payment-user" method="post">
                                        <input type="hidden" name="billID" value="${bill.billID}">
                                        <input type="hidden" name="amount" value="${bill.totalCost}">
                                        <button type="submit" class="btn btn-primary">Pay Now</button>
                                    </form>
                                </c:if>
                            </td>
                        </c:if>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        
        <div class="text-center mt-3">
          
            <button class="btn btn-secondary" onclick="history.back()">Back</button>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
