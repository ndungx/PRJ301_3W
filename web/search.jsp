<%-- 
    Document   : search
    Created on : Apr 13, 2021, 1:40:57 PM
    Author     : NDungx
--%>

<%@page import="java.util.List"%>
<%@page import="com.ndungx.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]>      <html class="no-js"> <![endif]-->
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>User Management</title>
        <meta name="description" content="CRUD">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/search.css">
        <link href="https://netdna.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous">
    </head>
    <body>
        <!--[if lt IE 7]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="#">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
        <c:set var="cookies" value="${cookie}"/>
        <c:if test="${not empty cookies}">
            <c:set var="username" value=""/>
            <c:forEach var="cookie" items="${cookies}" >
                <c:set var="temp" value="${cookie.value.name}" />
                <c:if test="${temp != 'JSESSIONID'}">
                    <c:set var="username" value="${temp}"/>
                </c:if>
            </c:forEach>
            <c:if test="${username == ''}">
                <jsp:forward page="StartupServlet" />
            </c:if>
        </c:if>
        
        <c:set var="loginUser" value="${sessionScope.LOGIN_USER.fullname}"/>
        <c:set var="roleID" value="${sessionScope.LOGIN_USER.roleID}"/>

        <c:if test="${roleID ne 'AD'}">
            <a href="index.html">Permission Denied</a>
        </c:if>
        <c:if test="${empty loginUser}">
            <a href="index.html">Please Login First</a>
        </c:if>

        <c:if test="${not empty loginUser and roleID eq 'AD'}">
            <jsp:include page="header.jsp"></jsp:include>
                <div class="box">
                    <!-- Upper -->
                    <div class="upper">
                        <h1>User Management</h1>

                    </div>
                    <!-- Table -->
                <c:set var="searchValue" value="${param.Search}"/>
                <c:if test="${not empty searchValue}">
                    <c:set var="searchResult" value="${requestScope.LIST_USER}"/>
                    <c:if test="${not empty searchResult}">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>User ID</th>
                                    <th>Full name</th>
                                    <th>Role ID</th>
                                    <th>Password</th>
                                    <th>Phone Number</th>
                                    <th>Email</th>
                                    <th>Address</th>
                                    <th>Delete</th>
                                    <th>Update</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${searchResult}" 
                                           varStatus="counter">
                                <form action="DispatchServlet">
                                    <tr>
                                        <td>
                                            ${counter.count}
                                        </td>
                                        <td>
                                            ${user.userID}
                                        </td>
                                        <td>
                                            <input type="text" name="fullname" 
                                                   value="${user.fullname}" autocomplete="off"/>
                                            <br>
                                            <c:if test="${(not empty sessionScope.UPDATE_ERROR.fullnameLengthErr) and (user.fullname eq sessionScope.UPDATE_ERROR_FULLNAME)}">
                                                <font color="red">
                                                ${sessionScope.UPDATE_ERROR.fullnameLengthErr}
                                                </font>
                                            </c:if>
                                        </td>
                                        <td>
                                            <input type="text" name="roleID" 
                                                   value="${user.roleID}" autocomplete="off"/>
                                            <br>
                                            <c:if test="${(not empty sessionScope.UPDATE_ERROR.roleIDLengthErr) and (user.fullname eq sessionScope.UPDATE_ERROR_FULLNAME)}">
                                                <font color="red">
                                                ${sessionScope.UPDATE_ERROR.roleIDLengthErr}
                                                </font>
                                            </c:if>
                                            <c:remove var="UPDATE_ERROR"/>
                                            <c:remove var="UPDATE_ERROR_USERNAME"/>
                                        </td>
                                        <td>
                                            ${user.password}
                                        </td>
                                        <td>
                                            ${user.phone}
                                        </td>
                                        <td>
                                            ${user.email}
                                        </td>
                                        <td>
                                            ${user.address}
                                        </td>
                                        <td>
                                            <c:url var="deleteLink" value="DispatchServlet">
                                                <c:param name="btAction" 
                                                         value="Delete"/>
                                                <c:param name="userID" 
                                                         value="${user.userID}"/>
                                                <c:param name="Search" 
                                                         value="${searchValue}"/>
                                            </c:url>
                                            <a class="btn btn-danger" href="${deleteLink}">Delete</a>
                                            <br>
                                            <c:if test="${(not empty requestScope.DELETE_USER) and (loginUser eq user.fullname)}">
                                                <font color="red">
                                                ${requestScope.DELETE_USER}
                                                </font>
                                                <c:remove var="DELETE_USER"/>
                                            </c:if>
                                        </td>
                                        <td>
                                            <input type="hidden" name="userID" 
                                                   value="${user.userID}" />
                                            <input type="hidden" name="Search" 
                                                   value="${searchValue}" />
                                            <input type="submit" value="Update" 
                                                   name="btAction"  class="btn btn-warning"/>
                                        </td>
                                    </tr>
                                </form>
                            </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                    <c:if test="${empty searchResult}">
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>User ID</th>
                                    <th>Full name</th>
                                    <th>Role ID</th>
                                    <th>Password</th>
                                    <th>Phone Number</th>
                                    <th>Email</th>
                                    <th>Address</th>
                                    <th>Delete</th>
                                    <th>Update</th>
                                </tr>
                            </thead>
                        </table>
                        <div class="show-table-info">
                            <div class="alert alert-info center">
                                <strong>No User Found</strong>
                            </div>
                        </div>
                    </c:if>
                </c:if>
            </div>
        </c:if>
    </body>
</html>
