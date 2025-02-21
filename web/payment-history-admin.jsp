<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin - Payment History</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body class="container mt-4">

    <h2 class="text-center mb-4">Payment History</h2>

    <div class="table-responsive">
        <table class="table table-bordered table-striped text-center">
            <thead class="table-dark">
                <tr>
                    <th>Bill ID</th>
                    <th>Room ID</th>
                    <th>Guest ID</th>
                    <th>Total Cost</th>
                    <th>Create Date</th>
                    <th>Status</th>
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
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
