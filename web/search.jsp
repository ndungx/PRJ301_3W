<%-- 
    Document   : search
    Created on : Apr 13, 2021, 1:40:57 PM
    Author     : NDungx
--%>

<%@page import="java.util.List"%>
<%@page import="com.ndungx.dtos.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search</title>
    </head>
    <body>
        <c:set var="loginUser" value="${sessionScope.LOGIN_USER.fullname}"/>

        <c:if test="${empty loginUser}">
            <a href="index.html">Please Login First</a>
        </c:if>
        <c:if test="${not empty loginUser}">
            <font color="red">
            Welcome ${loginUser}
            </font>
            <form action="DispatchServlet">
                <input type="submit" value="Logout" name="btAction" />
            </form><br>

            <form action="DispatchServlet">
                Search <input type="text" name="Search" 
                              value="${param.Search}" /><br><br>
                <input type="submit" value="Search" name="btAction" />
            </form><br>
            <c:set var="searchValue" value="${param.Search}"/>
            <c:if test="${not empty searchValue}">
                <c:set var="searchResult" value="${requestScope.LIST_USER}"/>
                <c:if test="${empty searchResult}">
                    <h1>no record found!</h1>
                </c:if>
                <c:if test="${not empty searchResult}">
                    <table border="1">
                        <thead>
                            <tr>
                                <th>no</th>
                                <th>user id</th>
                                <th>full name</th>
                                <th>role id</th>
                                <th>password</th>
                                <th>delete</th>
                                <th>update</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${searchResult}" varStatus="counter">
                            <form action="DispatchServlet">
                                <tr>
                                    <td>${counter.count}</td>
                                    <td>${user.userID}</td>
                                    <td>
                                        <input type="text" name="fullname" value="${user.fullname}"/>
                                    </td>
                                    <td>
                                        <input type="text" name="roleID" value="${user.roleID}"/>
                                    </td>
                                    <td>${user.password}</td>
                                    <td>
                                        <c:url var="deleteLink" value="DispatchServlet">
                                            <c:param name="btAction" value="Delete"/>
                                            <c:param name="userID" value="${user.userID}"/>
                                            <c:param name="Search" value="${searchValue}"/>
                                        </c:url>
                                        <a href="${deleteLink}">Delete</a>
                                    </td>
                                    <td>
                                        <input type="hidden" name="userID" 
                                               value="${user.userID}" />
                                        <input type="hidden" name="Search" 
                                               value="${searchValue}" />
                                        <input type="submit" value="Update" name="btAction" />
                                    </td>
                                </tr>
                            </form>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </c:if>
    </c:if>


    <%-- <%
         UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
         if (loginUser != null) {
     %>  
     <h1>Welcome, <%= loginUser.getFullname()%></h1>
     <%
         }
     %>
     <form action="DispatchServlet">
         <input type="submit" value="Logout" name="btAction" />
     </form><br>

        <form action="DispatchServlet">
            <%
                String lastSearch = request.getParameter("Search");
                if (lastSearch == null) {
                    lastSearch = "";
                }
            %>
            Search <input type="text" name="Search" 
                          value="<%= lastSearch%>" /><br><br>
            <input type="submit" value="Search" name="btAction" />
        </form><br>

        <%
            String searchValue = request.getParameter("Search");
            if (searchValue != null) {
                List<UserDTO> list
                        = (List<UserDTO>) request.getAttribute("LIST_USER");
                if (list != null) {
        %>

        <table border="1">
            <thead>
                <tr>
                    <th>no</th>
                    <th>user</th>
                    <th>full name</th>
                    <th>role id</th>
                    <th>password</th>
                    <th>delete</th>
                    <th>update</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int count = 0;
                    for (UserDTO user : list) {
                        String urlRewriting = "DispatchServlet"
                                + "?btAction=Delete"
                                + "&userID=" + user.getUserID()
                                + "&searchValue=" + searchValue;
                %>
            <form action="DispatchServlet">
                <tr>
                    <td><%= ++count%></td>
                    <td>
                        <%= user.getUserID()%>
                    </td>
                    <td>
                        <input type="text" name="fullname" 
                               value="<%= user.getFullname()%>" />
                    </td>
                    <td>
                        <input type="text" name="roleID" 
                               value="<%= user.getRoleID()%>" />
                    </td>
                    <td>
                        <%= user.getPassword()%>
                    </td>
                    <td>
                        <a href="<%= urlRewriting%>">Delete</a>
                    </td>
                    <td>
                        <input type="hidden" name="userID" 
                               value="<%= user.getUserID()%>" />
                        <input type="hidden" name="Search" 
                               value="<%= searchValue%>" />
                        <input type="submit" value="Update" name="btAction" />
                    </td>
                </tr>
            </form>
            <%
                }
            %>
        </tbody>
    </table>
    <%
    } else {
    %> 
    <h1>no record found</h1> 
    <%
            }
        }
    %>--%>
</body>
</html>
