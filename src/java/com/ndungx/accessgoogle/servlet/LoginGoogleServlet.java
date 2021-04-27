package com.ndungx.accessgoogle.servlet;

import com.ndungx.accessgoogle.common.GooglePojo;
import com.ndungx.accessgoogle.common.GoogleUtils;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//@WebServlet(name = "LoginGoogleServlet", urlPatterns = {"/login-google"})
@WebServlet("/login-google")
public class LoginGoogleServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public LoginGoogleServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
            dis.forward(request, response);
        } else {
            String accessToken = GoogleUtils.getToken(code);
            GooglePojo googlePojo = GoogleUtils.getUserInfo(accessToken);
            request.setAttribute("id", googlePojo.getId());
            request.setAttribute("name", googlePojo.getName());
            request.setAttribute("email", googlePojo.getEmail());
            //--------------------------------------------------//
            String userID = googlePojo.getEmail();
            String fullname = googlePojo.getName();
            String roleID = "G";
            String password = googlePojo.getId();
            
            request.setAttribute("USER_ID", userID);
            request.setAttribute("FULLNAME", fullname);
            request.setAttribute("ROLE_ID", roleID);
            request.setAttribute("PASSWORD", password);
            request.setAttribute("IS_LOGIN_GOOGLE", true);
            //-------------------------------------------------//
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}
