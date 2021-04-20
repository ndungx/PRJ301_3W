<%-- 
    Document   : shopping
    Created on : Apr 19, 2021, 11:13:50 AM
    Author     : NDungx
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ITea</title>
    </head>
    <body>
        <h1>Select Your Favorite Tea</h1>
        <form action="DispatchServlet">
            <select name="cmbTea">
                <option value="T01-Peach Tea-15">Peach Tea</option>
                <option value="T02-Pink Tea-50">Pink Tea</option>
                <option value="T03-Black Tea-45">Black Tea</option>
                <option value="T04-Classic Tea-10">Classic Tea</option>
            </select>
            <input type="submit" value="Add" name="btAction" />
            <br>
            <br>
            <a href="viewCart.jsp">View Cart</a>
        </form>
        <c:set var="message" value="${requestScope.MESSAGE}"/>
        <c:if test="${empty message}">
            <c:set var="message" value=""/>
        </c:if>
        <h1>${message}</h1>

        <%--<%
              String message = (String) request.getAttribute("MESSAGE");
              if (message == null) {
                  message = "";
              }
          %>
          <h1><%= message%></h1>--%>
    </body>
</html>
