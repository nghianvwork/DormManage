<!-- manager.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="icon" href="img/D?CH V? TRÔNG GI? THÚ C?NG (3).png"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VAN NGHIA BUILDING</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="styles.css">
    </head>
    <body>
        <jsp:include page="navigation.jsp" />
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2">
                    <jsp:include page="sidebar.jsp" />
                </div>
                <div class="col-md-10">
                    <!-- Room List -->
                    <h2>MANAGE REQUEST</h2>
                    
                    <br><br>
                    <table id="table" class="table table-striped">
                        <thead>
                            <tr>
                                <th>Room Number</th>
                                <th>User</th>
                                <th>Dorm</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="booking" items="${bookingRequest}">
                                <tr>
                                    <td>${booking.room.roomNumber}</td>
                                    <td>${booking.user.fullName}</td>
                                    <td>${booking.room.department.departmentName}</td>
                                    <td>${booking.startDate}</td>
                                    <td>${booking.endDate != null ? booking.endDate : "N/A"}</td>
                                    <td>${booking.status}</td>
                                    <td>
                                        <c:if test="${booking.status eq 'Pending'}">
                                            <a href="update-status?userRoomID=${booking.userRoomID}&status=Active" class="btn btn-success">Active</a>
                                            <a href="update-status?userRoomID=${booking.userRoomID}&status=Reject" class="btn btn-danger">Reject</a>
                                        </c:if>
                                            <c:if test="${booking.status eq 'Active'}">
                                            <a href="update-status?userRoomID=${booking.userRoomID}&status=Close" class="btn btn-danger">Close</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>




        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>

        <script>
            $(document).ready(function () {
                $('#table').DataTable({
                    "pageLength": 5,
                    "lengthChange": false
                });
            });
        </script>
    </body>
</html>
