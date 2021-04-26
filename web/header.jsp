<%-- 
    Document   : header
    Created on : Apr 22, 2021, 4:00:09 PM
    Author     : NDungx
--%>

<%@page import="com.ndungx.controller.CartObj"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Kaushan%20Script:wght@200;300;400;500;600;700;800;900&display=swap');
            header {
                background-color: #E4E6E8;
            }

            .HeaderBox {
                display: flex;
                justify-content: space-between;
                padding: 0.5% 5%;  
            }

            .searchBar {
                display: flex;
                align-items: center;
            }

            .logoAD {
                font-family: 'Kaushan Script';
                font-weight: 700;
                font-size: 30px;
            }

            .logo img {
                width: 10%;
            }

            .user {
                display: flex;
                align-items: center;
                font-size: 15px;
            }

            .user p{
                display: flex;
                align-items: center;
            }

            .navbar-right a {
                transition: .5s;
            }

            .navbar a {
                float: left;
                color: var(--white);
                text-decoration: none;
                font-size: 14px;
                font-weight: 900;
                padding: 12px;
                text-transform: uppercase;
            }

            .cart {
                position: relative;
            }

            .cart i {
                font-size: x-large;
            }

            .badge {
                position: absolute;
                top: -17px;
                right: -10px;
                font-size: 12px;
                background-color: var(--red);
                width: 20px;
                height: 20px;
                padding: 4px;
                text-align: center;
                justify-content: center;
                border-radius: 50%;
                color: white;
            }
        </style>
        <c:set var="loginUser" value="${sessionScope.LOGIN_USER.fullname}"/>
        <c:set var="roleID" value="${sessionScope.LOGIN_USER.roleID}"/>
        <c:set var="cart" value="${sessionScope.CART}"/>
        <header>
            <div class="HeaderBox">
                <div class="logo">
                    <c:if test="${roleID eq 'AD'}">
                        <p class="logoAD">NDungx</p>
                    </c:if>
                    <c:if test="${empty roleID or roleID eq 'G'}">
                        <img src="image/lotus-flower-logo-icon-linear-style_126523-708.png"
                             alt="Logo Bubble Tea" style="width: 70px">
                    </c:if>
                </div>
                <div class="searchBar">
                    <c:if test="${roleID eq 'AD'}">
                        <form action="DispatchServlet">
                            <input type="text" placeholder="Search User" id="search" 
                                   name="Search" value="${param.Search}"/>
                            <button class="btn btn-primary" type="submit" 
                                    name="btAction" value="Search"
                                    style="margin-top: -4px; padding: 9px 12px">
                                <i class="fas fa-search"></i>
                            </button>
                        </form>
                    </c:if>
                </div>
                <c:if test="${not empty loginUser }">
                    <div class="user">
                        <c:if test="${roleID ne 'AD'}">
                            <c:set var="map" value="${cart.cart}"/>
                            <div class="navbar-right">
                                <a href="viewCart.jsp" class="cart" style="text-decoration: none">
                                    View Cart
                                    <i class="fa fa-shopping-cart"></i>
                                    <span class="badge"><c:out value="${fn:length(map)}" /></span>
                                </a>
                            </div>
                        </c:if>
                        <p style="margin-top: 17px;padding-right: 5px; padding-left: 20px">Welcome,&nbsp;<b>${loginUser}</b></p>
                        <div class="logout">
                            <form action="DispatchServlet">
                                <button class="btn btn-secondary" 
                                        type="submit" value="Logout" name="btAction">
                                    <i class="fas fa-sign-out-alt">&nbsp;&nbsp;Sign out</i>
                                </button>
                            </form> 
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty loginUser}">
                    <div class="user">
                        <c:if test="${roleID ne 'AD'}">
                        <c:set var="map" value="${cart.cart}"/>
                        <div class="navbar-right">
                            <a href="viewCart.jsp" class="cart" style="text-decoration: none">
                                View Cart
                                <i class="fa fa-shopping-cart"></i>
                                <span class="badge"><c:out value="${fn:length(cart.cart)}" /></span>
                            </a>
                        </div>
                    </c:if>
                        <p style="margin-top: 17px;padding-right: 5px; padding-left: 20px">Welcome,&nbsp;<b>Guest</b></p>
                        <div class="logout">
                            <a href="index.html">Login to check out</a>
                        </div>
                    </div>
                </c:if>
            </div>
        </header>
    </body>
</html>
