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
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
             body {
                background-image: linear-gradient(rgba(255, 255, 255, 0.7), rgba(255, 255, 255, 0.7)), url("img/history-head.png");
                background-size: cover;
                background-repeat: no-repeat;
                background-attachment: fixed;
            }z
            .thumbnail-images img {
                cursor: pointer;
                max-height: 100px;
            }
            .main-image {
                width: 100%;
                max-height: 400px;
                object-fit: cover;
            }
            .contact-buttons {
            position: fixed;
            bottom: 80px;
            right: 20px;
            display: flex;
            justify-content: center;
            flex-direction: column;
            gap: 10px;
            z-index: 1000; /* Ensure buttons are on top */
        }
        .contact-buttons a {
            text-decoration: none;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }
        .contact-buttons .zalo { background-color: #0084ff; }
        .contact-buttons .facebook { background-color: #4267B2; }
        .contact-buttons .hotline { background-color: #d9534f; }

        /* Hover effects */
        .contact-buttons a:hover {
            opacity: 0.8;
        }

        .contact-buttons i {
            margin-right: 10px;
        }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <!-- Main Content Section -->
        <div class="container mt-4">
            <h1 class="my-4">${room.roomNumber}</h1>
            <div class="row">
                <div class="container mt-5">
                    <h2 style="margin-top: -35px;margin-bottom: 25px;">RENTING PROGRESS</h2>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Room Number</th>
                                <th>Dorm</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="booking" items="${bookingHistory}">
                                <tr>
                                    <td>${booking.room.roomNumber}</td>
                                    <td>${booking.room.department.departmentName}</td>
                                    <td>${booking.startDate}</td>
                                    <td>${booking.endDate != null ? booking.endDate : "N/A"}</td>
                                    <td>${booking.status}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
            <div class="contact-buttons">
    <a href="https://zalo.me/0388964889" class="zalo" target="_blank">
        <i></i>Zalo
    </a>
    <a href="https://www.facebook.com/profile.php?id=61562444391001" class="facebook" target="_blank">
        <i class="fab fa-facebook-f"></i>
    </a>
    <a href="tel:+0388964889" class="hotline">
        <i class="fas fa-phone-alt"></i> 
    </a>
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
        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-5zvFH0C2F/pDnlzn/+OPOZsOL28NY2be6t/jrA6WWpSj8bc46l07Fg0S5oJPr5fZ" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+YT3EIQCE4NCptea7G4lB9Bq4Q+qwuSAIf2" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/js/all.min.js"></script>
    </body>
</html>
