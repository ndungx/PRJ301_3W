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
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]>      <html class="no-js"> <![endif]-->
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Employee Management</title>
        <meta name="description" content="CRUD">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/search.css">
        <link href="https://netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </head>
    <body>
        <!--[if lt IE 7]>
            <p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="#">upgrade your browser</a> to improve your experience.</p>
        <![endif]-->
        <div>

        </div>
        <div class="box">
            <h1 style="text-align: center;padding: 1%;">User Management</h1>
            <!-- Upper -->
            <div class="upper">
                <input type="text" placeholder="Search User" 
                       id="search" name="btAction" value="Search">
                <button type="button" class="btn btn-primary btn-block" 
                        id="addButton" data-toggle="modal" 
                        data-target="#addnewModal"><i class="fas fa-plus-circle"></i>&nbsp;&nbsp;Add</button>
            </div>
            
            <!-- Middle -->
            <!-- Create -->
            <div class="modal fade" id="addnewModal" tabindex="-1" role="dialog" aria-labelledby="addnewModalTitle" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="addnewModalTitle">Add Employee</h4>
                        </div>

                        <div class="modal-body">
                            <div class="modal-body">
                                <form id="input_form" onsubmit="createEmployeeInfo(); return false;">
                                    <!-- Full name -->
                                    <div class="form-group">
                                        <label for="full_name">Full Name <span class="required-field">*</span></label>
                                        <input type="text" class="form-control" placeholder="Enter Full Name" id="full_name" required />
                                    </div>

                                    <!-- Age -->
                                    <div class="form-group">
                                        <label for="age">Age<span class="required-field">*</span></label>
                                        <input type="number" min="18" max="60" class="form-control" placeholder="Enter Age" id="age" required />
                                    </div>

                                    <!-- Address -->
                                    <div class="form-group">
                                        <label for="address">Address <span class="required-field">*</span></label>
                                        <input type="address" class="form-control" placeholder="Enter Address" id="address" name="address" required>
                                    </div>

                                    <!-- Year of Experience -->
                                    <div class="form-group">
                                        <label for="y_o_e">Years of Experience (Up to 2 years)<span class="required-field">*</span></label>
                                        <input type="number" min="0.0" max="2.0" step="any" class="form-control" placeholder="Enter Years of Experience" id="y_o_e" required />
                                    </div>

                                    <!-- Phone Number -->
                                    <div class="form-group">
                                        <label for="phone_number">Phone Number <span class="required-field">*</spa></label>
                                        <input type="phoneNumber" class="form-control" placeholder="Enter Phone Number" id="phone_number" minlength="10" maxlength="12" pattern="^\+?(\d.*){10,12}$" required />
                                    </div>

                                    <!-- Email -->
                                    <div class="form-group">
                                        <label for="email">Email <span class="required-field">*</span></label>
                                        <input type="email" class="form-control" placeholder="Enter Email" id="email" required />
                                    </div>

                                    <!-- Date of Joining -->
                                    <div class="form-group">
                                        <label for="d_o_j">Date of Joining (mm/dd/yy) <span class="required-field">*</span></label>
                                        <input type="text" class="form-control" placeholder="Enter Date of Joining" id="d_o_j" required onkeypress="return false;" autocomplete="off" />
                                    </div>

                                    <div class="modal-footer-extended">
                                        <button class="btn btn-primary">Create</button>
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Update -->
            <div class="modal fade" id="update" tabindex="-1" role="dialog" aria-labelledby="editModalTitle" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="editModal">Update Employee Information</h4>
                        </div>
                        <div class="modal-body">
                            <form id="input-form">
                                <!-- Full name -->
                                <div class="form-group">
                                    <label for="edit_full_name">Full Name <span class="required-field">*</span></label>
                                    <input type="text" class="form-control" id="edit_full_name" value="" required />
                                </div>

                                <!-- Age -->
                                <div class="form-group">
                                    <label for="edit_age">Age <span class="required-field">*</span></label>
                                    <input type="number" min="18" max="60" class="form-control" id="edit_age" value="" required />
                                </div>
                                <!-- Address -->
                                <div class="form-group">
                                    <label for="edit_address">Address <span class="required-field">*</span></label>
                                    <input type="address" class="form-control" id="edit_address" value="" name="address" required>
                                </div>


                                <!-- Year of Experience -->
                                <div class="form-group">
                                    <label for="edit_y_o_e">Years of Experience (Up to 2 years)<span class="required-field">*</span></label>
                                    <input type="number" min="0" max="2" step="any" class="form-control" id="edit_y_o_e" value="" required />
                                </div>

                                <!-- Phone Number -->
                                <div class="form-group">
                                    <label for="edit_phone_number">Phone Number <span class="required-field">*</span></label>
                                    <input type="PhoneNumber" class="form-control" id="edit_phone_number" value="" required />
                                </div>

                                <!-- Email -->
                                <div class="form-group">
                                    <label for="edit_email">Email <span class="required-field">*</span></label>
                                    <input type="email" class="form-control" id="edit_email" value="" required />
                                </div>

                                <!-- Date of Joining -->
                                <div class="form-group">
                                    <label for="edit_d_o_j">Date of Joining <span class="required-field" >*</span></label>
                                    <input type="text" class="form-control" id="edit_d_o_j" value="" required onkeypress="return false;" autocomplete="off" />
                                </div>

                                <div class="modal-footer-extended">
                                    <button class="btn btn-success" onclick="editRow();">Update</button>
                                    <button type="button" class="btn btn-danger" data-dismiss="modal">Cancel</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Search -->
            <div class="modal fade" id="search" tabindex="-1" role="dialog" aria-labelledby="searchModalTitle" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h4 class="modal-title" id="search">Search Employee</h4>
                        </div>
                        <div class="modal-body">
                        </div>
                    </div>
                </div>
            </div>


            <!-- Lower -->
            <table id="employee_table" class="table table-bordered table-hover">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Full Name</th>
                        <th>Age</th>
                        <th>Address</th>
                        <th>Year of Experience</th>
                        <th>Phone Number</th>
                        <th>Email</th>
                        <th>Date of Joining</th>
                    </tr>
                </thead>
            </table>

            <div class="show-table-info hide">
                <div class="alert alert-info center">
                    <strong>No Employee Add Yet</strong>
                </div>
            </div>
        </div>
    </body>
</html>
