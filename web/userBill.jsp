<%-- 
    Document   : userBill
    Created on : Feb 19, 2025, 10:34:02 PM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Bill Management</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="navigation.jsp" />
    <div class="container">
        <h2 class="mt-4">Your Bills</h2>
        
        <table class="table table-striped mt-3">
            <thead>
                <tr>
                    <th>Bill ID</th>
                    <th>Room Number</th>
                    <th>Total Cost</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="bill" items="${userBills}">
                    <tr>
                        <td>${bill.billID}</td>
                        <td>${bill.room.roomNumber}</td>
                        <td>${bill.totalCost} VND</td>
                        <td>${bill.paymentStatus}</td>
                        <td>
                            <c:if test="${bill.paymentStatus == 'Unpaid'}">
                                <a href="pay-bill?billID=${bill.billID}" class="btn btn-success">Pay Now</a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
