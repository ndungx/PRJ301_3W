<%-- 
    Document   : shopping
    Created on : Apr 19, 2021, 11:13:50 AM
    Author     : NDungx
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Flower Shop</title>
        <link href="https://netdna.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous">
        <link rel="stylesheet" href="css/shopping.css">
    </head>
    <body>
        <c:set var="loginUser" value="${sessionScope.LOGIN_USER.fullname}"/>
        <c:set var="roleID" value="${sessionScope.LOGIN_USER.roleID}"/>
        <c:if test="${empty roleID or roleID ne 'AD'}">
            <jsp:include page="header.jsp"></jsp:include>
                <div class="box">
                    <h3 style="padding-left: 15px;padding-top: 15px">All Product</h3>
                    <hr>
                    <div class="product">
                    <c:forEach var="dto" items="${requestScope.PRODUCT_LIST}" varStatus="counter">
                        <div class="col-xl-2 my-2 col-lg-3 col-md-4 col-6">
                            <div class="product-box-2 h-100 bg-white position-relative  " id="product-card">
                                <!--<a class="position-absolute h-100 w-100" style="z-index: 3" href="#"></a> --> <%-- trang này dẫn vào view product --%>

                                <div id="loaded" data-src="${dto.image}" style="padding-bottom: 100%; background: url(${dto.image}) no-repeat center / cover;"></div>
                                <div class="p-3 border-top">
                                    <h2 class="product-title p-0">
                                        ${dto.productName}
                                    </h2>
                                    <div class="clearfix  d-flex w-100 align-items-end">
                                        <div class="price-box float-left flex-grow-1" style="flex-grow: 1 !important">
                                            <span><del class="old-product-price strong-400 text-md"><fmt:formatNumber maxFractionDigits="3">${dto.price + 100000}</fmt:formatNumber> ₫ </del></span>
                                            <div class="d-lg-block product-price strong-600" style="font-size: 1.1rem"><b><fmt:formatNumber maxFractionDigits="3">${dto.price}</fmt:formatNumber> ₫</b></div>
                                        </div>
                                        <div class="float-right d-lg-block">
                                            <div class="add-to-cart btn url_product">
                                                <form action="DispatchServlet">
                                                    <input type="hidden" name="productID" value="${dto.productID}" />
                                                    <input type="hidden" name="productName" value="${dto.productName}" />
                                                    <input type="hidden" name="price" value="${dto.price}" />
                                                    <input type="hidden" name="quantity" value="1" />
                                                    <input type="hidden" name="categoryID" value="${dto.categoryID}" />
                                                    <input type="hidden" name="image" value="${dto.image}" />
                                                    <button class="btn btn-outline-danger" type="submit" value="Add Product To Cart" name="btAction">
                                                        <i class="fa fa-shopping-basket"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
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
