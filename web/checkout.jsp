<%-- 
    Document   : checkout
    Created on : Apr 26, 2021, 12:00:14 AM
    Author     : NDungx
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html> 
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Check out Successfully</title>
        <link href="https://netdna.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous">
    </head>
    <body style="background-color: #F1F1F1;">
        <c:set var="roleID" value="${sessionScope.LOGIN_USER.roleID}"/>
        <c:if test="${empty roleID or (roleID ne 'AD' and roleID ne 'M')}">
            <c:set var="fullname" value="${sessionScope.LOGIN_USER.fullname}"/>
            <c:set var="orderID" value="${requestScope.ORDER_ID}"/>
            <c:set var="orderDate" value="${requestScope.ORDER_DATE}"/>
            <c:set var="shippingAddress" value="${requestScope.SHIPPING_ADDRESS}"/>
            <c:set var="productName" value="${requestScope.PRODUCT_NAME}"/>
            <c:set var="quantity" value="${requestScope.QUANTITY}"/>
            <c:set var="price" value="${requestScope.PRICE}"/>
            <c:set var="shippingFee" value="${requestScope.SHIPPING_FEE}"/>
            <c:set var="roleID" value="${sessionScope.LOGIN_USER.roleID}"/>

            <c:if test="${empty roleID or roleID ne 'AD'}">
                <jsp:include page="header.jsp"></jsp:include>
                <c:set var="cart" value="${sessionScope.CART}"/>
                <c:set var="map" value="${cart.cart}"/>

                <div style="display: flex; align-items: center; flex-direction: column;margin-bottom: 3%;margin-top: 3%;">
                    <img src="image/lotus-flower-logo-icon-linear-style_126523-708.png" style="max-width: 10%">    
                    <h1><b>Thank You.</b></h1>
                </div>
                <div style="display: flex; flex-direction: column; align-items: center;margin-left: 20%;margin-right: 20%;padding-bottom: 5%;background-color: white;margin-bottom: 10%;">
                    <div style="margin-left: 0px; margin-right: 0px;">
                        <div style="display: flex; flex-direction: column; align-items: center; margin-top: 2rem;">
                            <h5><b>Hi, ${fullname}</b></h5>
                            <p>Thanks for your purchase from Flower Shop</p>
                            <br>
                            <h1><b>INVOICE ID:</b></h1>
                            <h1><b>${orderID}</b></h1>
                            <p class="text-muted">( Please keep a copy of this receipt for your records. )</p>
                        </div>
                        <br>
                        <h6 class="text-uppercase" style="color: #B2B2B2"><b>YOUR ORDER INFORMATION:</b></h6>
                        <hr style="color: #B2B2B2">
                        <div style="display: flex; justify-content: space-between;">
                            <div>
                                <div>
                                    <h5><b>Order ID:</b></h5>
                                    ${orderID}
                                </div>
                                <div style="margin-top: 15px; max-width: 400px; padding-right: 10px;">
                                    <h5><b>Ship To:</b></h5>
                                    ${shippingAddress}
                                </div>
                            </div>
                            <div>
                                <div>
                                    <h5><b>Order Date:</b></h5>
                                    <jsp:useBean id="now" class="java.util.Date" scope="request" />
                                    <fmt:formatDate type="both" dateStyle="medium" 
                                                    timeStyle="medium"
                                                    value="${now}"></fmt:formatDate>
                                    </div>
                                    <div style="margin-top: 15px">
                                        <h5><b>Source:</b></h5>
                                        <p>Flower Shop Website</p>
                                    </div>
                                </div>
                            </div>
                            <h6 class="text-uppercase" style="color: #B2B2B2; margin-top: 15px;"><b>HERE'S WHAT YOU ORDERED:</b></h6>

                            <div class="row border-top border-bottom" style="padding-bottom: 2rem; margin-top: 15px;">
                                <table style="width: 100%;">
                                    <thead>
                                        <tr>
                                            <th style="text-align: start; height: 60px; background-color: #F1F1F1; padding-left: 10px">Product Name</th>
                                            <th style="text-align: center; height: 60px; background-color: #F1F1F1;">Quantity</th>
                                            <th style="text-align: end; height: 60px; background-color: #F1F1F1; padding-right: 10px">Price</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="dto" items="${map}">
                                        <c:set var="total" value="${total = total 
                                                                    + dto.value.price 
                                                                    * dto.value.quantity}"/>
                                        <tr>
                                            <td style="text-align: start; height: 40px; padding-left: 10px">
                                                ${dto.value.productName}
                                            </td>
                                            <td style="text-align: center; height: 40px;">
                                                ${dto.value.quantity}
                                            </td>
                                            <td style="text-align: end; height: 40px; padding-right: 10px">
                                                <fmt:formatNumber maxFractionDigits="3">${dto.value.price}</fmt:formatNumber>&nbsp;₫ 
                                                </td>
                                            </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div>
                            <div style="text-align: end; margin-top: 1.5rem">
                                <h5 class="text-uppercase" >
                                    <b><span class="text-muted">TOTAL [ VND ]: </span><fmt:formatNumber maxFractionDigits="3">${total}</fmt:formatNumber> ₫</b>
                                    </h5>
                                </div>
                            </div>
                            <hr style="color: #B2B2B2">
                            <div style="display: flex; justify-content: space-between">
                                <h6 class="text-uppercase" style="color: #B2B2B2"><b>SHIPPING FEE:</b></h6>
                                <h6>
                                    <b>
                                    <fmt:formatNumber maxFractionDigits="3">${shippingFee}</fmt:formatNumber> ₫
                                    </b>
                                </h6> 
                            </div>
                        </div>
                        <div class="back-to-shop" style="margin-top: 3rem;">
                            <a href="GetProductServlet">
                                &leftarrow;&nbsp;<span style="color: #007bff">Back to shop</span>
                            </a>
                        </div>
                    </div>
                <c:remove var="CART"/>
                <c:set var="SHIPPING_FEE" value="${sessionScope.SHIPPING_FEE}"/>
                <c:remove var="SHIPPING_FEE"/>
            </c:if>
            <c:if test="${roleID eq 'AD'}">
                <div style="display: flex; flex-direction: column; align-items: center">
                    <h1>Administrator Can't Buy</h1>
                    <a href="search.jsp" style="text-decoration: none;">Click here to back to User Management</a>
                </div>
            </c:if>
        </c:if>
        <c:if test="${roleID eq 'AD' or roleID eq 'M'}">
            <div style="display: flex; flex-direction: column; align-items: center">
                <h1>Administrator Can't Buy</h1>
                <a href="search.jsp" style="text-decoration: none;">Click here to back to User Management</a>
            </div>
        </c:if>
    </body>
</html>
