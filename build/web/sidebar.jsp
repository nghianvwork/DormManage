<%-- 
    Document   : sidebar
    Created on : Jul 4, 2024, 5:30:15 PM
    Author     : Legion
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
        <style>
            .sidebar {
                width: 200px;
                position: fixed;
                top: 0;
                left: 0;
                height: 100%;
                background-color: #339900;
                padding-top: 20px;
                box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            }
            .sidebar .nav-link {
                color: #ffffff;
                padding: 15px;
                border-radius: 5px;
                transition: background-color 0.3s, color 0.3s;
            }
            .sidebar .nav-link:hover {
                background-color: #495057;
                color: #ffffff;
            }
            .sidebar .nav-link.active {
                /*                background-color: red;*/
                color: #ffffff;
            }
            .sidebar .nav-item + .nav-item {
                margin-top: 10px;
            }
        </style>
    </head>
    <body>



        <div class="sidebar">
            <div class="nav-logo">
                <img src="img/DỊCH VỤ TRÔNG GIỮ THÚ CƯNG (1).png" alt style="    width: 250px;
                     height: 255px;border-radius: 20%;margin-left: -28px;margin-top: -50px;"/>

            </div>
            <ul class="nav flex-column">
                <li class="nav-item">
                    <a class="nav-link active" href="manage-department">DORM MANAGEMENT</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link " href="manage-room">ROOM MANAGEMENT</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="manage-service">SERVICE MANAGEMENT</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="manage-request">ROOM REQUEST</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="manage-bill">MANAGE BILL</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="payment-history">PAYMENT HISTORY</a>
                </li>
            </ul>
        </div>  

        <!-- Optional Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-5zvFH0C2F/pDnlzn/+OPOZsOL28NY2be6t/jrA6WWpSj8bc46l07Fg0S5oJPr5fZ" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+YT3EIQCE4NCptea7G4lB9Bq4Q+qwuSAIf2" crossorigin="anonymous"></script>
    </body>
</html>
