<!-- manager.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="icon" href="img/D?CH V? TRÔNG GI? THÚ C?NG (3).png"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>HOANG GIA BUILDING</title>
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
                                    <td>

                                        <c:if test="${room.status == 'Occupied'}">   
                                            <a href="create-bill?roomID=${room.roomID}" class="btn btn-primary" >
                                                Create bill
                                            </a>
                                        </c:if>
                                        <c:if test="${room.status == 'Available'|| room.status == 'On repairing'}">   
                                            <a style="pointer-events: none;color: grey">
                                                Create bill
                                            </a>
                                        </c:if>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <!-- Pagination -->
                    <!-- Pagination -->
                    <ul class="pagination justify-content-center">
                        <li class="page-item${currentPage == 1 ? ' disabled' : ''}">
                            <a class="page-link" href="manage-bill?page=${currentPage - 1}">Previous</a>
                        </li>
                        <c:forEach begin="1" end="${numberOfPages}" var="i">
                            <li class="page-item${currentPage == i ? ' active' : ''}">
                                <a class="page-link" href="manage-bill?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item${currentPage == numberOfPages ? ' disabled' : ''}">
                            <a class="page-link" href="manage-bill?page=${currentPage + 1}">Next</a>
                        </li>
                    </ul>
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
