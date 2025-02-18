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
                    <h2>ROOM MANAGEMENT</h2>
                    <br><br>

                    <!-- Search Form -->
                    <!-- Department Filter Dropdown -->
                    <div class="form-group mb-3">
                        <h4 style="color:blue"><b>Filter by department</b></h4>
                        <select id="departmentFilter" class="form-control">
                            <option value="">All Departments</option>
                            <c:forEach var="department" items="${departments}">
                                <option value="${department.departmentName}">${department.departmentName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Room List -->
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
                            <!-- Iterate over rooms -->
                            <c:forEach var="room" items="${rooms}">
                                <tr>
                                    <td>${room.roomID}</td>
                                    <td>${room.roomNumber}</td>
                                    <td>${room.department.departmentName}</td>
                                    <td>${room.status}</td>
                                    <td>
                                        <!-- Update Button with Modal -->
                                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#updateModal${room.roomID}">
                                            Update
                                        </button>
                                        <c:if test="${room.status == 'Available'}">   
                                            <a href="delete-room?roomID=${room.roomID}" onclick="return confirmDelete()" class="btn btn-warning" >
                                                Delete
                                            </a>
                                        </c:if>
                                        <c:if test="${room.status != 'Available'}">   
                                            <a style="pointer-events: none;color: grey" href="delete-room?roomID=${room.roomID}">
                                                Delete
                                            </a>
                                        </c:if>
                                        <!-- Update Modal -->
                                        <div class="modal fade" id="updateModal${room.roomID}" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel${room.roomID}" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="updateModalLabel${room.roomID}">Update Room</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <!-- Form for updating room -->
                                                        <form action="update-room" method="POST">
                                                            <input type="hidden" name="roomID" value="${room.roomID}">
                                                            <div class="form-group">
                                                                <label for="roomNumber">Room Number</label>
                                                                <input type="text" class="form-control" id="roomNumber" name="roomNumber" value="${room.roomNumber}" required>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="price">Status</label>
                                                                <input type="text" class="form-control" id="status" name="status" value="${room.status}" required>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="departmentSelect">Department</label>
                                                                <select class="form-control" id="departmentSelect" name="departmentID">
                                                                    <c:forEach var="department" items="${departments}">
                                                                        <option value="${department.departmentID}" ${room.departmentID == department.departmentID ? 'selected' : ''}>
                                                                            ${department.departmentName}
                                                                        </option>
                                                                    </c:forEach>
                                                                </select>
                                                            </div>
                                                            <button type="submit" class="btn btn-primary">Update Room</button>
                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <!-- Pagination -->
                    <ul class="pagination justify-content-center">
                        <li class="page-item${currentPage == 1 ? ' disabled' : ''}">
                            <a class="page-link" href="manage-room?page=${currentPage - 1}">Previous</a>
                        </li>
                        <c:forEach begin="1" end="${numberOfPages}" var="i">
                            <li class="page-item${currentPage == i ? ' active' : ''}">
                                <a class="page-link" href="manage-room?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item${currentPage == numberOfPages ? ' disabled' : ''}">
                            <a class="page-link" href="manage-room?page=${currentPage + 1}">Next</a>
                        </li>
                    </ul>
                    <!-- Add Button with Modal -->
                    <button type="button" class="btn btn-success mt-3" data-toggle="modal" data-target="#addModal">
                        Add Room
                    </button>

                    <!-- Add Room Modal -->
                    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addModalLabel">Add Room</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <!-- Form for adding room -->
                                    <form action="add-room" method="POST">
                                        <div class="form-group">
                                            <label for="roomNumber">Room Number</label>
                                            <input type="text" class="form-control" id="roomNumber" name="roomNumber" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="departmentSelect">Department</label>
                                            <select class="form-control" id="departmentSelect" name="departmentID">
                                                <c:forEach var="department" items="${departments}">
                                                    <option value="${department.departmentID}">
                                                        ${department.departmentName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <label for="description">Status</label>
                                            <input class="form-control" id="status" name="status" value="Available" readonly></input>
                                        </div>
                                        <button type="submit" class="btn btn-success">Add Room</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>

            function confirmDelete() {
                return confirm("Do you want to delete this?");
            }

            // Department filtering
            document.getElementById('departmentFilter').addEventListener('change', function () {
                const selectedDepartment = this.value.toLowerCase();
                const tableRows = document.querySelectorAll('table tbody tr');

                tableRows.forEach(row => {
                    const departmentCell = row.cells[2].textContent.toLowerCase();
                    if (selectedDepartment === '' || departmentCell === selectedDepartment) {
                        row.style.display = '';
                    } else {
                        row.style.display = 'none';
                    }
                });
            });
        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
