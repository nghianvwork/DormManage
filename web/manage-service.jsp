
<!-- manager.jsp -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <link rel="icon" href="img/Blue Minimalist Clean House Service Logo (7).png"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>HOANG GIA BUILDING</title>
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
                    <h2>MANAGE SERVICES</h2>
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addServiceModal">Add Service</button>
                    <br><br>
                    <table id="table" class="table table-bordered">
                        <thead>
                            <tr>
                                <th>ServiceID</th>
                                <th>ServiceName</th>
                                <th>ServiceDescription</th>
                                <th>Price</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="service" items="${services}">
                                <tr>
                                    <td>${service.serviceID}</td>
                                    <td>${service.serviceName}</td>
                                    <td>${service.serviceDescription}</td>
                                    <td>${service.price}</td>
                                    <td>
                                        <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#updateServiceModal${service.serviceID}" 
                                                data-serviceid="${service.serviceID}" data-servicename="${service.serviceName}"
                                                data-servicedescription="${service.serviceDescription}" data-price="${service.price}">
                                            Update
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>


                    <!-- Add Service Modal -->
                    <div class="modal" id="addServiceModal">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">Add Service</h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>
                                <div class="modal-body">
                                    <form action="add-service" method="post">
                                        <div class="form-group">
                                            <label for="serviceName">Service Name:</label>
                                            <input type="text" class="form-control" id="serviceName" name="serviceName" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="serviceDescription">Service Description:</label>
                                            <input type="text" class="form-control" id="serviceDescription" name="serviceDescription" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="price">Price:</label>
                                            <input type="number" class="form-control" id="price" name="price" required>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Add Service</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <c:forEach var="service" items="${services}">
            <!-- Update Service Modal -->
            <div class="modal" id="updateServiceModal${service.serviceID}">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title">Update Service</h4>
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                        </div>
                        <div class="modal-body">
                            <form action="update-service" method="post">
                                <input type="hidden" id="updateServiceID" name="serviceID" value="${service.serviceID}">
                                <div class="form-group">
                                    <label for="updateServiceName">Service Name:</label>
                                    <input type="text" class="form-control" id="updateServiceName" name="serviceName" value="${service.serviceName}" required>
                                </div>
                                <div class="form-group">
                                    <label for="updateServiceDescription">Service Description:</label>
                                    <input type="text" class="form-control" id="updateServiceDescription" name="serviceDescription" value="${service.serviceDescription}" required>
                                </div>
                                <div class="form-group">
                                    <label for="updatePrice">Price:</label>
                                    <input type="number" class="form-control" id="updatePrice" name="price" value="${service.price}" required>
                                </div>
                                <button type="submit" class="btn btn-primary">Update Service</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        
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
