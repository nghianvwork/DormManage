<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" href="img/DỊCH VỤ TRÔNG GIỮ THÚ CƯNG (3).png"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>HOANG GIA BUILDING</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <!-- Custom CSS -->
        <link rel="stylesheet" href="style.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" integrity="sha384-SZXxX4whJ79/gErwcOYfzME9jIK6bqfLOeFw1HA6j9x4AIXLlChybexlW1Bpbx5y" crossorigin="anonymous">
        <style>
            body {
                background-image: url("https://i.giphy.com/media/v1.Y2lkPTc5MGI3NjExN3BlMnFmN3c2NG16M21idzVxdjQ0dXRwcXR0MHQydWY0bjJ0dWp3MSZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/JMcF2Vp0I4Cc91Bl8r/giphy.gif");
                background-size: cover;
                background-repeat: no-repeat;
                background-size: 100%;
                /*    background-position: center;*/
                background-attachment: fixed;
                overflow: hidden;
            }
        </style>
    </head>
    <body>
        <div class="nav-logo">
            <img src="img/DỊCH VỤ TRÔNG GIỮ THÚ CƯNG (1).png" alt style="    width: 250px;
                 height: 255px;border-radius: 20%;margin-left: -20px;margin-top: -20px;"/>

        </div>
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card card-blur">
                        <div class="card-header bg-success text-white">
                            <h3 class="text-center">Login</h3>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <c:choose>
                                    <c:when test="${error == 'password'}">
                                        <div class="alert alert-danger" role="alert">
                                            Incorrect username or password. Please try again!
                                        </div>
                                    </c:when>
                                    <c:when test="${error == 'username'}">
                                        <div class="alert alert-danger" role="alert">
                                            Username not found. Please try again!
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="alert alert-danger" role="alert">
                                            Login failed. Please try again!
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>

                            <form action="login" method="post">
                                <div class="form-group input-box">
                                    <i class="fa fa-user"></i>
                                    <label for="username" style="color: #392467">Username</label>
                                    <input type="text" id="username" name="username" class="form-control input-field" required>
                                </div>
                                <div class="form-group input-box">
                                    <i class="fa fa-lock"></i>
                                    <label for="password" style="color: #392467">Password</label>
                                    <input type="password" id="password" name="password" class="form-control input-field" required>
                                </div>
                                <div class="form-group input-box">
                                    <i class="fa fa-lock"></i>
                                    <label for="password" style="color: #392467">Remember me</label>
                                    <input type="checkbox"  name="rememberme" value="true" >
                                </div>
                                <br>
                                <button type="submit" class="btn btn-success btn-block">&nbsp;&nbsp;Login&nbsp;&nbsp;   </button>
                                <a href="register" class="register-link">Register now</a>
                                <a href="forgotPassword" class="register-link">Forgot your password</a>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS and dependencies (if needed) -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
                integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"
                integrity="sha384-KyZXEAg3QhqLMpG8r+PoA5RO0rTNhQUuTdHW5OoaOD3L+E9yz7+7bDf4Mkhjt7ab"
        crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
                integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+VyC2f3KuF02TCmYZ+X6Z/x6BZpWYRmdiCE"
        crossorigin="anonymous"></script>
    </body>
</html>

