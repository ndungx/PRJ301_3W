<%-- 
    Document   : createAccount
    Created on : Apr 19, 2021, 12:11:41 AM
    Author     : NDungx
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
              crossorigin="anonymous">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" 
              integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" 
              crossorigin="anonymous">
        <link rel="stylesheet" href="css/login.css">
        <title>Create New Account Page</title>
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-sm-9 col-md-7 col-lg-5 mx-auto">
                    <div class="card card-signin my-5">
                        <div class="card-body">
                            <h5 class="card-title text-center">Create New Account</h5>
                            <form class="form-signin" action="DispatchServlet" method="POST">
                                <c:set var="error" value="${requestScope.ERROR}"/>
                                <div class="form-label-group">
                                    <input type="text" id="inputUserID" 
                                           name="userID" class="form-control" 
                                           placeholder="User ID" required autofocus>
                                    <label for="inputUserID">User ID</label>
                                </div>
                                <c:if test="${not empty error.userIDError}">
                                    <font color="red">
                                    ${error.userIDError}<br>
                                    </font>
                                </c:if>

                                <div class="form-label-group">
                                    <input type="text" id="inputFullName" 
                                           name="fullname" class="form-control" 
                                           placeholder="Full Name" required autofocus>
                                    <label for="inputFullName">Full name</label>
                                </div>
                                <c:if test="${not empty error.fullnameError}">
                                    <font color="red">
                                    ${error.fullnameError}<br>
                                    </font>
                                </c:if>

                                <div class="form-label-group">
                                    <input type="text" id="inputRoleID" 
                                           name="roleID" class="form-control" 
                                           placeholder="Role ID" required autofocus>
                                    <label for="inputRoleID">Role ID</label>
                                </div>
                                <c:if test="${not empty error.roleIDError}">
                                    <font color="red">
                                    ${error.roleIDError}<br>
                                    </font>
                                </c:if>

                                <div class="form-label-group">
                                    <input type="phone" id="inputPhone" 
                                           name="phone" class="form-control" 
                                           placeholder="Phone" required>
                                    <label for="inputPhone">Phone</label>
                                </div>
                                <c:if test="${not empty error.phonedError}">
                                    <font color="red">
                                    ${error.phoneError}<br>
                                    </font>
                                </c:if>

                                <div class="form-label-group">
                                    <input type="email" id="inputEmail" 
                                           name="email" class="form-control" 
                                           placeholder="Email" required>
                                    <label for="inputEmail">Password</label>
                                </div>
                                <c:if test="${not empty error.emailError}">
                                    <font color="red">
                                    ${error.emaildError}<br>
                                    </font>
                                </c:if>

                                <div class="form-label-group">
                                    <input type="address" id="inputAddress" 
                                           name="address" class="form-control" 
                                           placeholder="Address" required>
                                    <label for="inputAddress">Address</label>
                                </div>
                                <c:if test="${not empty error.addressError}">
                                    <font color="red">
                                    ${error.addressError}<br>
                                    </font>
                                </c:if>

                                <div class="form-label-group">
                                    <input type="password" id="inputPassword" 
                                           name="password" class="form-control" 
                                           placeholder="Password" required>
                                    <label for="inputPassword">Password</label>
                                </div>
                                <c:if test="${not empty error.passwordError}">
                                    <font color="red">
                                    ${error.passwordError}<br>
                                    </font>
                                </c:if>

                                <div class="form-label-group">
                                    <input type="password" id="inputConfirmPassword" 
                                           name="confirm" class="form-control" 
                                           placeholder="Confirm password" required>
                                    <label for="inputConfirmPassword">Confirm password</label>
                                </div>
                                <c:if test="${not empty error.confirmError}">
                                    <font color="red">
                                    ${error.confirmError}<br>
                                    </font>
                                </c:if>

                                <button class="btn btn-lg btn-primary btn-block text-uppercase" style="margin-top: 1rem" 
                                        type="submit" value="Create" name="btAction">Create</button>
                                <hr class="my-4">
                            </form>
                            <div>
                                <div class="btn-google">
                                    <a class="button" href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8084/PRJ301_3W/login-google&response_type=code
                                       &client_id=225456220013-28j92le9f9urd61mjsc1vd8khnc1vuad.apps.googleusercontent.com&approval_prompt=force" 
                                       class="fb-btn" style="text-decoration: none"><i class="fab fa-google mr-2"></i> Sign in with Google</a> 
                                </div>
                                <br>
                                <span class="createNewAccount">
                                    Already have account?
                                    <a href="index.html"><b>&nbsp;Sign in here</b></a>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
