<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Payment</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    </head>
    <body>
        <jsp:include page="navigation.jsp" />
        <div class="container mt-4">
            <h2>Payment History</h2>
            <table class="table table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>Bill ID</th>
                        <th>Room ID</th>
                        <th>Guest ID</th>
                        <th>Total Cost</th>
                        <th>Create Date</th>
                        <th>Payment Status</th>
                            <c:if test="${sessionScope.user.role == 'Manager'}">
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
                            <td>${bill.totalCost}</td>
                            <td>${bill.createDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${bill.paymentStatus}"><span class="text-success">Paid</span></c:when>
                                    <c:otherwise><span class="text-danger">Unpaid</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${!bill.paymentStatus}">
                                    <form action="payment-user" method="post">
                                        <input type="hidden" name="billID" value="${bill.billID}">
                                        <input type="hidden" name="amount" value="${bill.totalCost}">
                                        <button type="submit" class="btn btn-primary">Pay Now</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>

                </tbody>
            </table>
        </div>
    </body>
</html>