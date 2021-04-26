<%-- 
    Document   : viewCart
    Created on : Apr 19, 2021, 12:49:59 PM
    Author     : NDungx
--%>

<%@page import="com.ndungx.product.ProductDTO"%>
<%@page import="com.ndungx.controller.CartObj"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Shopping Cart</title>
        <link rel="stylesheet" href="css/cart.css">
        <link href="https://netdna.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous">
    </head>
    <body>
        <c:set var="loginUser" value="${sessionScope.LOGIN_USER.fullname}"/>
        <c:set var="roleID" value="${sessionScope.LOGIN_USER.roleID}"/>
        <c:set var="address" value="${sessionScope.LOGIN_USER.address}"/>
        <c:if test="${empty roleID or roleID ne 'AD'}">
            <jsp:include page="header.jsp"></jsp:include>
            <c:set var="cart" value="${sessionScope.CART}"/>
            <c:if test="${empty cart.cart}">
                <div class="container-fluid mt-100">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="col-sm-12 empty-cart-cls text-center" style="box-shadow: 0px 5px 50px rgba(153, 153, 153, .3); padding-top: 5%; padding-bottom: 5%"> 
                                    <img src="https://i.imgur.com/dCdflKN.png" width="130" height="130" class="img-fluid mb-4 mr-3">
                                    <h3><strong>Your Cart is Empty</strong></h3>
                                    <h4>Add something to make me happy :)</h4> <a href="GetProductServlet" class="btn btn-primary cart-btn-transform m-3">continue shopping</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>    
            </c:if>

            <c:if test="${not empty cart.cart}">
                <c:set var="map" value="${cart.cart}"/>
                <div class="card">
                    <div class="row">
                        <div class="col-md-8 cart">
                            <div class="title">
                                <div class="row">
                                    <div class="col">
                                        <h4><b>Shopping Cart</b></h4>
                                    </div>
                                    <div class="col align-self-center text-right text-muted"><c:out value="${fn:length(map)}" /> items</div>
                                </div>
                            </div>
                            <div class="row border-top border-bottom">
                                <c:forEach var="dto" items="${map}">
                                    <form action="DispatchServlet" style="display: flex;">
                                        <c:set var="total" value="${total 
                                                                    = total 
                                                                    + dto.value.price 
                                                                    * dto.value.quantity}"/>
                                        <div class="row main align-items-center">
                                            <div class="col-2"><img class="img-fluid" src="${dto.value.image}"></div>
                                            <div class="col">
                                                <div class="row text-muted">${dto.value.categoryID}</div>
                                                <div class="row">${dto.value.productName}</div>
                                            </div>
                                            <div class="col" style="display: flex"> 
                                                <input type="number" name="quantity" value="${dto.value.quantity}" min="1" placeholder="Quantity" style="width: 100%">
                                            </div>
                                            <div class="col"style="display: flex; flex-direction: row; justify-content: space-between;">
                                                <div class="price">
                                                    <fmt:formatNumber maxFractionDigits="3">${dto.value.price}</fmt:formatNumber>&nbsp;₫ 
                                                    </div>

                                                    <input type="hidden" name="productID" value="${dto.value.productID}" />
                                                <div class="deleteProductButton" style="margin-right: 5%; margin-left: 2%" >
                                                    <button class="btn btn-primary" type="submit" value="Edit" name="btAction">
                                                        <span style="color: white;"><i class="fas fa-edit" style="font-size: 15px"></i></span>
                                                    </button>
                                                </div>
                                                <div class="deleteProductButton">
                                                    <button class="btn btn-danger" type="submit" value="Remove" name="btAction">
                                                        <span style="color: white;"><i class="fas fa-trash" style="font-size: 15px"></i></span>
                                                    </button>
                                                </div>
                                            </div>
                                            <div style="margin-left: 4%; margin-top: 2%; color: red">
                                                <c:if test="${not empty requestScope.OUT_OF_STOCK and dto.value.productID eq requestScope.PRODUCT_ID}">
                                                    ${OUT_OF_STOCK}
                                                </c:if>
                                            </div>
                                        </div>
                                    </form>
                                </c:forEach>
                            </div>
                            <div class="back-to-shop">
                                <a href="GetProductServlet">
                                    &leftarrow;&nbsp;<span style="color: #007bff">Back to shop</span>
                                </a>
                            </div>
                        </div>
                        <div class="col-md-4 summary">
                            <div>
                                <h5><b>Summary</b></h5>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col">ITEMS <c:out value="${fn:length(map)}" /></div>
                                <div class="col text-right"><fmt:formatNumber maxFractionDigits="3">${total}</fmt:formatNumber> ₫</div>
                                </div>

                                <form action="DispatchServlet">
                                    <input type="hidden" name="userID" value="${sessionScope.LOGIN_USER.userID}" />
                                <input type="hidden" name="address" value="${address}" />
                                <input type="hidden" name="total" value="${total}" />
                                <p style="margin-bottom: 2%">SHIPPING METHOD</p> 
                                <select name="cmbShippingMethod">
                                    <option class="text-muted" value="30000" selected>Standard Delivery - 30.000 ₫</option>
                                    <!--<option class="text-muted" value="50000">Express Delivery - 50.000 ₫</option>-->
                                </select>
                                <p style="margin-top: 5%; margin-bottom: 2%">SHIPPING ADDRESS</p> 
                                <b>${address}</b>
                                <br>
                                <br>
                                <div class="row" style="border-top: 1px solid rgba(0,0,0,.1); padding: 2vh 0;">
                                    <div class="col">TOTAL PRICE</div>
                                    <div class="col text-right"><fmt:formatNumber maxFractionDigits="3">${total + 30000}</fmt:formatNumber> ₫</div>
                                    </div> 
                                <c:if test="${not empty loginUser}">
                                    <button class="checkoutButton" style="cursor: pointer" type="submit" name="btAction" value="Checkout">CHECKOUT</button>
                                </c:if>
                                <c:if test="${empty loginUser}">
                                    <div style="display: flex; justify-content: center">
                                        <a href="index.html" style="text-decoration: none;">Please log in to check out</a>
                                    </div>
                                </c:if>
                            </form>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:if>
        <c:if test="${roleID eq 'AD'}">
            <div style="display: flex; flex-direction: column; align-items: center">
                <h1>Administrator Can't Buy</h1>
                <a href="search.jsp" style="text-decoration: none;">Click here to back to User Management</a>
            </div>
        </c:if>
    </body>
</html>
