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
                    <h2>DORM MANAGEMENT</h2>
                    <br><br>

                    <!-- Search Form -->
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="Search by dorm Name" id="searchInput">
                        <div class="input-group-append">
                            <button class="btn btn-outline-secondary" type="button" onclick="searchDorms()">Search</button>
                        </div>
                    </div>

                    <!-- Room List -->
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Dorm ID</th>
                                <th>Name</th>
                                <th>Address</th>
                                <th> Empty room></th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Iterate over rooms -->
                            <c:forEach var="dorm" items="${departments}">
                                <tr>
                                    <td>${dorm.departmentID}</td>
                                    <td>${dorm.departmentName}</td>
                                    <td>${dorm.address}</td>
                                    <td><a href="empty-room?dormid=${dorm.departmentID}">${dorm.emptyRoom}</a></td>
                                    <td>
                                        <!-- Update Button with Modal -->
                                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#updateModal${dorm.departmentID}">
                                            Update
                                        </button>
                                        <a href="admin-room-detail?dormID=${dorm.departmentID}" class="btn btn-primary" >
                                            Detail
                                        </a>
                                        <a href="delete-dorm?dormID=${dorm.departmentID}" onclick="return confirmDelete()"  class="btn btn-danger">Delete</a>    
                                        <!-- Update Modal -->
                                        <div class="modal fade" id="updateModal${dorm.departmentID}" tabindex="-1" role="dialog" aria-labelledby="updateModalLabel${dorm.departmentID}" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="updateModalLabel${dorm.departmentID}">Update Room</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <!-- Form for updating room -->
                                                        <form action="update-dorm" method="POST">
                                                            <input type="hidden" name="dormID" value="${dorm.departmentID}">
                                                            <div class="form-group">
                                                                <label for="roomNumber">Dorm Name</label>
                                                                <input type="text" class="form-control" id="departmentName" name="departmentName" value="${dorm.departmentName}" required>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="price">Price</label>
                                                                <input type="number" class="form-control" id="price" name="price" value="${dorm.price}" required>
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="description">Address</label>
                                                                <input class="form-control" id="address" name="address" value="${dorm.address}">
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
                            <a class="page-link" href="manage-department?page=${currentPage - 1}">Previous</a>
                        </li>
                        <c:forEach begin="1" end="${numberOfPages}" var="i">
                            <li class="page-item${currentPage == i ? ' active' : ''}">
                                <a class="page-link" href="manage-department?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item${currentPage == numberOfPages ? ' disabled' : ''}">
                            <a class="page-link" href="manage-department?page=${currentPage + 1}">Next</a>
                        </li>
                    </ul>

                    <!-- Add Button with Modal -->
                    <button type="button" class="btn btn-success mt-3" data-toggle="modal" data-target="#addModal">
                        Add Dorm
                    </button>

                    <!-- Add Room Modal -->
                    <div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
                        <div class="modal-dialog" role="document">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="addModalLabel">Add Dorm</h5>
                                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                                <div class="modal-body">
                                    <!-- Form for adding room -->
                                    <form action="add-dorm" method="POST">
                                        <div class="form-group">
                                            <label for="roomNumber">Dorm Name</label>
                                            <input type="text" class="form-control" id="departmentName" name="departmentName" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="price">Price</label>
                                            <input type="number" class="form-control" id="price" name="price" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="Address">Address</label>
                                            <input type="text" class="form-control" id="address" name="address">
                                        </div>
                                        <div class="form-group">
                                            <label for="EmptyRoom">Empty Room</label>
                                            <input type="number" min="0" value="0" name="emptyRoom" class="form-control">
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

            // Thêm hàm tìm ki?m
            function searchDorms() {
                let input, filter, table, tr, td, i, txtValue;
                input = document.getElementById("searchInput");
                filter = input.value.toUpperCase();
                table = document.querySelector("table");
                tr = table.getElementsByTagName("tr");

                for (i = 0; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName("td")[1]; // C?t th? 2 ch?a tên Dorm
                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }

            // Thêm event listener cho input tìm ki?m
            document.getElementById("searchInput").addEventListener("keyup", searchDorms);
            function confirmDelete() {
                return confirm("Do you want to delete this?");
            }

        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
