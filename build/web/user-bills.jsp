<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Bills</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="navigation.jsp" />
    <div class="container mt-4">
        <h2>Your Bills</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Bill ID</th>
                    <th>Room ID</th>
                    <th>Total Cost</th>
                    <th>Create Date</th>
                    <th>Payment Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="bill" items="${bills}">
                    <tr>
                        <td>${bill.billID}</td>
                        <td>${bill.roomID}</td>
                        <td>${bill.totalCost}</td>
                        <td>${bill.createDate}</td>
                        <td>
                            <c:choose>
                                <c:when test="${bill.paymentStatus}">Paid</c:when>
                                <c:otherwise>Unpaid</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
