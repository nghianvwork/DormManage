<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Empty Rooms</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <jsp:include page="navigation.jsp" />
    <div class="container mt-4">
        <h2>List of Empty Rooms</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Room ID</th>
                    <th>Room Number</th>
                    <th>Department</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="room" items="${emptyRooms}">
                    <tr>
                        <td>${room.roomID}</td>
                        <td>${room.roomNumber}</td>
                        <td>${room.department.departmentName}</td> 
                        <td>${room.status}</td>
                        <td>
                            <a href="book-room?roomID=${room.roomID}" class="btn btn-success">Book</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
