
<!-- manager.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="icon" href="img/D?CH V? TR�NG GI? TH� C?NG (3).png"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VAN NGHIA BUILDING</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap4.min.css">
        <link rel="stylesheet" href="styles.css">
        <style>
            .loading-overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 9999;
            }
            .spinner {
                position: absolute;
                top: 50%;
                left: 50%;
                border: 4px solid #f3f3f3;
                border-top: 4px solid #3498db;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                animation: spin 1s linear infinite;
            }
            @keyframes spin {
                0% {
                    transform: translate(-50%, -50%) rotate(0deg);
                }
                100% {
                    transform: translate(-50%, -50%) rotate(360deg);
                }
            }
        </style>
    </head>
    <body>
<!--        <script>
            $(window).on('load', function () {
                $('.loading-overlay').hide();
            });
        </script>-->
        <jsp:include page="navigation.jsp" />
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2">
                    <jsp:include page="sidebar.jsp" />
                </div>
                <div class="col-md-10">
                    <!-- Room List -->
                    <h2>MANAGE ROOM</h2>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addImageModal">Add Image</button>
                    <br><br>
                    <table id="table" class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ImageID</th>
                                <th>ImageURL</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="image" items="${dormImages}">
                                <tr>
                                    <td style="width: 20%">${image.imageID}</td>
                                    <td><img src="${image.imageURL}" alt="Dorm Image" width="100"></td>
                                    <td style="width: 20%">
                                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#updateImageModal${image.imageID}" 
                                                data-imageid="${image.imageID}" data-imageurl="${image.imageURL}">
                                            Update Image
                                        </button>
                                        <a href="delete-image?imageID=${image.imageID}&dormID=${image.dormID}" onclick="return confirmDelete()" class="btn btn-danger" >
                                            Delete
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <div style="margin: 50px 0"></div>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addServiceModal">Add Service</button>
                    <table id="table2" class="table table-bordered ">
                        <thead>
                            <tr>
                                <th>RoomServiceID</th>
                                <th>Service Name</th>
                                <th>Price</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${dormAllServices}">
                                <tr>
                                    <td style="width: 20%">${s.dormServiceID}</td>
                                    <td>${s.service.serviceName}</td>
                                    <td>${s.service.price}</td>
                                    <td style="width: 20%">
                                        <!-- Button to Open the Update Service Modal -->
                                        <a href="remove-service?dormServiceID=${s.dormServiceID}&dormID=${dormID}" onclick="return confirmDelete()" class="btn btn-danger">
                                            Remove Service
                                        </a>
                                    </td>
                                </tr>

                                <!-- Update Service Modal -->
                            <div class="modal" id="updateServiceModal${roomService.roomServiceID}">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h4 class="modal-title">Update Service for RoomServiceID: ${roomService.roomServiceID}</h4>
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="updateRoomService" method="post">
                                                <input type="hidden" name="roomServiceID" value="${roomService.roomServiceID}">
                                                <div class="form-group">
                                                    <label for="roomID">Dorm ID:</label>
                                                    <input type="text" class="form-control" name="roomID" value="${roomService.roomID}" required>
                                                </div>
                                                <div class="form-group">
                                                    <label for="serviceID">Service ID:</label>
                                                    <input type="text" class="form-control" name="serviceID" value="${roomService.serviceID}" required>
                                                </div>
                                                <button type="submit" class="btn btn-primary">Update</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div style="margin: 50px 0"></div>
                </div>
            </div>

        </div>

        <div class="modal" id="addImageModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Add Image</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form action="add-image" method="post" id="addImageForm" enctype="multipart/form-data">
                            <div class="form-group">
                                <input type="hidden" class="form-control"  id="dormID" name="dormID" value="${dormID}">
                            </div>
                            <div class="form-group">
                                <label for="image">Image:</label>
                                <input type="file" class="form-control" id="image" name="image" required>
                            </div>
                            <button type="submit" class="btn btn-primary">Add</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <c:forEach var="image" items="${dormImages}">
            <!-- Update Image Modal -->
            <div class="modal" id="updateImageModal${image.imageID}">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Update Image</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <form action="update-image" id="addImageForm" method="post" enctype="multipart/form-data">
                                <input type="hidden" class="form-control"  id="dormID" name="dormID" value="${dormID}">
                                <input type="hidden" class="form-control"  id="roomID" name="imageID" value="${image.imageID}">
                                <div class="form-group">
                                    <label for="image">Image :</label>
                                    <input type="file" class="form-control" id="image" name="image"  required>
                                </div>
                                <button type="submit" class="btn btn-primary">Update</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- Add Service Modal -->
        <div class="modal" id="addServiceModal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title">Add Service</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <form action="add-dorm-service" method="post">
                            <div class="form-group">
                                <label for="dormID">Dorm ID:</label>
                                <input type="text" class="form-control" name="dormID" value="${dormID}" readonly>
                            </div>
                            <div class="form-group">
                                <label for="serviceID">Service ID:</label>
                                <select type="text" class="form-control" name="serviceID" required>
                                    <c:forEach items="${allServices}" var="service">
                                        <option value="${service.serviceID}">${service.serviceName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary">Add</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="loading-overlay">
            <div class="spinner"></div>
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
                                            function confirmDelete() {
                                                return confirm("Do you want to delete this?");
                                            }
                                            $(document).ready(function () {
                                                $('#table').DataTable({
                                                    "pageLength": 5,
                                                    "lengthChange": false
                                                });
                                            });

                                            $(document).ready(function () {
                                                $('#table2').DataTable({
                                                    "pageLength": 5,
                                                    "lengthChange": false
                                                });
                                            });
                                            $(document).ready(function () {
                                                $('#addImageForm').on('submit', function () {
                                                    $('.loading-overlay').show();
                                                });
                                            });
        </script>
    </body>
</html>
