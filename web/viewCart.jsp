<%-- 
    Document   : viewCart
    Created on : Apr 19, 2021, 12:49:59 PM
    Author     : NDungx
--%>

<%@page import="com.ndungx.dtos.TeaDTO"%>
<%@page import="com.ndungx.dtos.CartDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Shopping Cart</title>
    </head>
    <body>
        <c:set var="cart" value="${sessionScope.CART}"/>
        <c:if test="${empty cart.cart}">
            <h1>nothing in your cart</h1>
        </c:if>
        <c:if test="${not empty cart.cart}">
            <h1>You selected:</h1>
            <table border="1">
                <thead>
                    <tr>
                        <th>no</th>
                        <th>id</th>
                        <th>name</th>
                        <th>quantity</th>
                        <th>price</th>
                        <th>total</th>
                        <th>delete</th>
                        <th>update</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="map" value="${cart.cart}"/>
                    <c:forEach var="tea" items="${map}" varStatus="counter">
                        <c:set var="total" value="${total 
                                                    = total 
                                                    + tea.value.price 
                                                    * tea.value.quantity}"/>
                    <form action="DispatchServlet">
                        <tr>
                            <td>
                                ${counter.count}
                            </td>
                            <td>
                                ${tea.key}
                                <input type="hidden" name="id" value="${tea.key}" />
                            </td>
                            <td>
                                ${tea.value.name}
                            </td>
                            <td>
                                <input type="number" name="quantity" 
                                       value="${tea.value.quantity}" />
                            </td> 
                            <td>
                                ${tea.value.price}
                            </td>
                            <td>
                                ${tea.value.price * tea.value.quantity}
                            </td>
                            <td>
                                <input type="submit" value="Remove" name="btAction" />
                            </td>
                            <td>
                                <input type="submit" value="Edit" name="btAction" />
                            </td>
                        </tr>
                    </form>
                </c:forEach>
            </tbody>
        </table>
        <h1>total: ${total}</h1>
    </c:if>
    <a href="shopping.jsp">Click here to add</a>



    <%--<h1>You selected:</h1>
            <%
                CartDTO cart = (CartDTO) session.getAttribute("CART");
                if (cart != null) {
            %>
            <table border="1">
                <thead>
                    <tr>
                        <th>no</th>
                        <th>id</th>
                        <th>name</th>
                        <th>quantity</th>
                        <th>price</th>
                        <th>total</th>
                        <th>delete</th>
                        <th>update</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        int count = 0;
                        double total = 0;
                        for (TeaDTO tea : cart.getCart().values()) {
                            total += tea.getQuantity() * tea.getPrice();

                %>
            <form action="DispatchServlet">
                <tr>
                    <td>
                        <%= ++count%>

                    </td>
                    <td>
                        <%= tea.getId()%>
                        <input type="hidden" name="id" value="<%= tea.getId()%>" />
                    </td>
                    <td>
                        <%= tea.getName()%>
                    </td>
                    <td>
                        <input type="number" name="quantity" value="<%= tea.getQuantity()%>" />
                    </td>
                    <td>
                        <%= tea.getPrice()%>
                    </td>
                    <td>
                        <%= tea.getQuantity() * tea.getPrice()%>
                    </td>
                    <td>
                        <input type="submit" value="Remove" name="btAction" />
                    </td>
                    <td>
                        <input type="submit" value="Edit" name="btAction" />
                    </td>
                </tr>
            </form>
            <%
                }
            %>
        </tbody>
    </table>
    <h1>total: <%= total%></h1>
    <%
        }
    %>
    <a href="shopping.jsp">Add more</a>--%>
</body>
</html>
