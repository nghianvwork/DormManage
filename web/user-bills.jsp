<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
     <jsp:include page="header.jsp"/>
    <div class="container mt-5">
        <h2 class="text-center">Payment History</h2>
        <table class="table table-bordered text-center">
            <thead class="thead-dark">
                <tr>
                    <th>Bill ID</th>
                    <th>Room ID</th>
                    <th>Guest ID</th>
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
                        <td>${bill.guestID}</td>
                        <td>${bill.totalCost} $</td>
                        <td>${bill.createDate}</td>
                        <td>
                            <c:choose>
                                <c:when test="${bill.paymentStatus}">
                                    <span class="badge badge-success">Paid</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-danger">Unpaid</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div class="text-center">
            <button class="btn btn-secondary" onclick="history.back()">Back</button>
        </div>
    </div>
</body>
</html>
