<%-- 
    Document   : viewProduct
    Created on : Apr 28, 2021, 6:33:13 PM
    Author     : NDungx
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/viewProduct.css">
        <link href="https://netdna.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous">
        <title>View Product</title>
    </head>
    <body>
        <c:set var="loginUser" value="${sessionScope.LOGIN_USER.fullname}"/>
        <c:set var="roleID" value="${sessionScope.LOGIN_USER.roleID}"/>
        <c:if test="${empty roleID or roleID ne 'AD'}">
            <jsp:include page="header.jsp"></jsp:include>
            <div class="box">
                <div class="row fullheight slide">
                    <div class="col-6 fullheight">
                        <!-- PRODUCT IMAGE -->
                        <div class="product-img">
                            <div class="img-wrapper right-to-left">
                                <div class="bounce">
                                    <img src="image/hoa.png" alt="placeholder+image">
                                </div>
                            </div>
                        </div>
                        <!-- END PRODUCT IMAGE -->
                    </div>
                    <div class="col-6 fullheight img-col">
                        <!-- PRODUCT INFO -->
                        <div class="product-info">
                            <div class="info-wrapper">
                                <div class="product-name">
                                    <h2>
                                        Beautiful You
                                    </h2>
                                </div>
                                <div class="product-price">
                                    <h5>Price: </h5><del>230 ₫</del>
                                </div>
                                <div class="product-price">
                                    <h5>Sale price: </h5>230 ₫
                                </div>
                                <div class="product-description">
                                    <p>
                                       A simple bouquet of red roses in a youthful and elegant package is one of our Best Seller models. 
                                       <br>
                                       <br>
                                       Perfect for Valentine's Day or any special occasion.
                                    </p>
                                </div>
                                <!--<div class="button">-->
                                <button class="btn btn-primary btn-lg">
                                        Add to cart
                                    </button>
                                <!--</div>-->
                            </div>
                        </div>
                        <!-- END PRODUCT INFO -->
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${roleID eq 'AD'}">
            <div style="display: flex; flex-direction: column; align-items: center">
                <h1>Administrator Can't Buy</h1>
                <a href="search.jsp" style="text-decoration: none;">Click here to back to User Management</a>
            </div>
        </c:if>
    </body>
</html>
