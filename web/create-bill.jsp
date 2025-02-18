<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" href="img/D?CH V? TRÔNG GI? THÚ C?NG (3).png"/>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>HOANG GIA BUILDING</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            table {
                border-collapse: collapse;
                width: 100%;
                max-width: 800px;
                margin: 20px auto;
            }
            th, td {
                border: 1px solid #ddd;
                padding: 8px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            input[type="number"] {
                width: 100%;
                box-sizing: border-box;
            }
            .total-row {
                font-weight: bold;
                background-color: #e6e6e6;
            }
        </style>
    </head>
    <body>
        <jsp:include page="navigation.jsp" />
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-2">
                    <jsp:include page="sidebar.jsp" />
                </div>
                <div class="col-md-10">
                    <h2 style="z-index:1001">Create bill</h2>
                    <form action="create-bill" method="post">
                        <input name="roomID" value="${roomID}" type="hidden">
                        <input name="guestID" value="${guestID}" type="hidden">
                        <table class="col-md-12">
                            <thead>
                                <tr>
                                    <th>Service Name</th>
                                    <th>Price</th>
                                    <th>Old Reading</th>
                                    <th>New Reading</th>
                                    <th>Usage</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="s" items="${dormServices}">
                                    <tr>
                                        <td>${s.service.serviceName}</td>
                                        <td>${s.service.price}</td>
                                        <td>
                                            <input class="old" type="number" name="oldReading_${s.service.serviceID}" 
                                                   id="oldReading_${s.service.serviceID}" placeholder="Input old number..."
                                                   min="0"  class="form-control reading-input">
                                        </td>
                                        <td>
                                            <input class="new" type="number" name="newReading_${s.service.serviceID}" 
                                                   id="newReading_${s.service.serviceID}" placeholder="Input new number..."
                                                   min="0" class="form-control reading-input">
                                        </td>
                                        <td>
                                            <span class="usage">0</span>
                                        </td>
                                        <td>
                                            <span class="total">0</span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="form-group">
                            <label for="totalAmount">Total Amount:</label>
                            <input type="text" id="totalAmount" name="totalAmount" readonly class="form-control">
                        </div>
                        <button class="btn btn-warning" type="submit">Create bill</button>
                    </form>
                </div>
            </div>
        </div>

        <script>
            var grandTotal = 0;
            const rows = document.querySelectorAll('tbody tr');
            const inputs = document.querySelectorAll('input[type="number"]');
            console.log(inputs);
            rows.forEach(row => {
                const serviceId = row.querySelector('input').name.split('_')[1];
                const old = row.querySelector(`.old`);
                const newR = row.querySelector(`.new`);
                console.log(old)
                old.onchange = function () {
                    let oldReading = parseInt(row.querySelector(`.old`).value) || 0;
                    console.log(oldReading)
                    let price = parseFloat(row.cells[1].textContent.replace(/[^0-9.-]+/g, ""));
                    console.log("old", oldReading);
                    newR.onchange = function () {
                        let newReading = parseInt(row.querySelector(`.new`).value) || 0;
                        if (newReading < oldReading) {
                            alert("New record must be greater than or equal to old record !!!!!");
                        }
                        let usage = Math.max(0, newReading - oldReading);
                        console.log("us", usage)
                        let total = usage * price;
                        console.log("tt", total)
                        row.querySelector(`.usage`).innerText = usage;
                        row.querySelector(`.total`).textContent = total.toFixed(2);
                        grandTotal += total;
                        document.getElementById('totalAmount').value = grandTotal.toFixed(2);
                        console.log("gr", grandTotal)
                    }
                }
            });
        </script>
    </body>
</html>