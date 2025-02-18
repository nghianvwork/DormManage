<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" href="img/DỊCH VỤ TRÔNG GIỮ THÚ CƯNG (3).png"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>VAN NGHIA BUILDING</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <!-- Custom styles -->
        <style>
            .thumbnail-images img {
                cursor: pointer;
                width: 100px; /* Set a fixed width */
                height: 100px; /* Set a fixed height */
                object-fit: cover; /* Ensure the image covers the area */
                margin: 5px; /* Add some margin for spacing */
            }
            .main-image {
                width: 100%;
                max-height: 400px;
                object-fit: cover;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <!-- Main Content Section -->
        <div class="container mt-4">
            <h1 class="my-4">Nhà Trọ: ${dorm.departmentName}</h1>
            <div class="row">
                <div class="col-md-8">
                    <div class="main-image-container">
                        <img id="mainImage" class="main-image" src="${dormImages[0].imageURL}" alt="Main Image">
                    </div>
                    <div class="thumbnail-images mt-3">
                        <c:forEach var="image" items="${dormImages}">
                            <img src="${image.imageURL}" class="img-thumbnail" alt="Dorm Image">
                        </c:forEach>
                    </div>
                </div>
                <div class="col-md-4">
                    <h2>${dorm.departmentName}</h2>
                    <p>${dorm.address}</p>
                    <h4>Price: ${dorm.price} VND</h4>
                    <h5>Services:</h5>
                    <ul>
                        <c:forEach var="service" items="${dormServices}">
                            <li>${service.serviceName} - ${service.price} VND</li>
                            </c:forEach>
                    </ul>
                    <h5>Empty room: ${dorm.emptyRoom}</h5>
                </div>
            </div>

            <!-- Booking Form -->
            <div class="mt-5">
                <h3>BOOK THIS ROOM !</h3>
                <form action="booking" method="post">
                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input type="text" id="fullName" name="fullName" class="form-control" value="${sessionScope.user.fullName}" readonly>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" class="form-control" value="${sessionScope.user.email}" readonly >
                    </div>
                    <div class="form-group">
                        <label for="startDate">Start Date</label>
                        <input type="date" id="startDate" name="startDate" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="endDate">End Date</label>
                        <input type="date"  id="dateInput" name="endDate" class="form-control" required>
                    </div>
                    <div class="form-group">
                        <label for="room">Choose your room: &nbsp;</label>
                        <select name="roomID">
                            <c:forEach items="${listRoomAvailable}" var="room">
                                <option value="${room.roomID}">${room.roomNumber}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <c:if test="${dorm.emptyRoom == 0}">
                        <button type="submit" class="btn btn-primary" disabled="true">Book Now</button>
                    </c:if>
                    <c:if test="${dorm.emptyRoom != 0}">
                        <button type="submit" class="btn btn-primary">Book Now</button>
                    </c:if>
                </form>
            </div>        
        </div>

        <!-- Bootstrap JS (Optional for some components) -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-5zvFH0C2F/pDnlzn/+OPOZsOL28NY2be6t/jrA6WWpSj8bc46l07Fg0S5oJPr5fZ" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+YT3EIQCE4NCptea7G4lB9Bq4Q+qwuSAIf2" crossorigin="anonymous"></script>
        <script>
            // JavaScript to handle thumbnail click and update main image
            $(document).ready(function () {
                $('.thumbnail-images img').click(function () {
                    var mainImageSrc = $(this).attr('src');
                    $('#mainImage').attr('src', mainImageSrc);
                });
            });
            function validateDate() {
                const dateInput = document.getElementById('dateInput').value;
                const date = new Date(dateInput);

                if (isNaN(date.getTime())) {
                    alert("Invalid date. Please enter a valid date.");
                    return false;
                }



                return true;
            }
            F
        </script>
        <jsp:include page="footer.html"/>
    </body>
</html>