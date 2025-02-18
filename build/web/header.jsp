
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>

            /* Custom styles can be added here */
            .banner {
                background-image: url("img/yellow modern house banner.png"); /* Light gray background for banner */
                padding: 80px 0; /* Adjust padding as needed */
                text-align: center;
                background-repeat: no-repeat;
                background-size: cover;
                height: 400px
            }
            .navbar-nav {
                width: 100%;
                display: flex;
                justify-content: space-around;
            }
        </style>
    </head>
    <body>
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-info bg-gradient"style="
             height: 99px;">
            <div class="container">
                <a class="navbar-brand" href="home">
                    <img src="img/DỊCH VỤ TRÔNG GIỮ THÚ CƯNG (1).png" alt="Logo" style="height: 145px;
                         width: 140px;
                         margin-left: -60px;margin-top: 10px;">
                </a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>


                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mr-auto">
                        <li class="nav-item active ">
                            <a class="nav-link" href="home">HOME <span class="sr-only">(current)</span></a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="booking-history">RENTING PROGRESS</a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="booked-room">RENTED ROOM</a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="get-bill">BILL</a>
                        </li>
                        <li class="nav-item active">
                            <a class="nav-link" href="payment-history">PAYMENT-HISTORY</a>
                        </li>
                    </ul>
                    <!-- You can add login/logout button or user-specific options here -->
                    <form class="form-inline my-2 my-lg-0">
                        <c:if test="${sessionScope.user eq null}">
                            <a class="btn btn-outline-light my-2 my-sm-0" href="login">Login</a>
                        </c:if>
                        <c:if test="${sessionScope.user ne null}">
                            <a class="btn btn-outline-light my-2 my-sm-0" href="logout" style="    margin-right: -80px;">Log out</a>
                        </c:if>

                    </form>
                </div>
            </div>
        </nav>
    </body>
</html>
