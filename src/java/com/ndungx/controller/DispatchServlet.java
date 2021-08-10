package com.ndungx.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * @author NDungx
 */
@WebServlet(name = "DispatchServlet", urlPatterns = {"/DispatchServlet"})
public class DispatchServlet extends HttpServlet {

    private static final String LOGIN_PAGE = "index.html";
    private static final String LOGIN_CONTROLLER = "LoginServlet";
    private static final String SEARCH_CONTROLLER = "SearchServlet";
    private static final String LOGOUT_CONTROLLER = "LogoutServlet";
    private static final String DELETE_CONTROLLER = "DeleteServlet";
    private static final String UPDATE_CONTROLLER = "UpdateServlet";
    private static final String CREATE_CONTROLLER = "CreateServlet";
    private static final String ADD_CONTROLLER = "AddServlet";
    private static final String VIEW_CART_PAGE = "viewCart.jsp";
    private static final String REMOVE_CONTROLLER = "RemoveServlet";
    private static final String EDIT_CART_CONTROLLER = "EditServlet";
    private static final String STARTUP_CONTROLLER = "StartupServlet";
    private static final String CHECKOUT_CONTROLLER = "CheckOutServlet";
    private static final String CREATE_GOOGLE_ACCOUNT_CONTROLLER = "CreateGoogleAccountServlet";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String button = request.getParameter("btAction");
        String url = LOGIN_PAGE;

        try {
            if (button == null) {
//                url = STARTUP_CONTROLLER;
            } else if (button.equals("Login")) {
                url = LOGIN_CONTROLLER;
            } else if (button.equals("Search")) {
                url = SEARCH_CONTROLLER;
            } else if (button.equals("Logout")) {
                url = LOGOUT_CONTROLLER;
            } else if (button.equals("Delete")) {
                url = DELETE_CONTROLLER;
            } else if (button.equals("Update")) {
                url = UPDATE_CONTROLLER;
            } else if (button.equals("Create")) {
                url = CREATE_CONTROLLER;
            } else if (button.equals("Add Product To Cart")) {
                url = ADD_CONTROLLER;
            } else if (button.equals("View Cart")) {
                url = VIEW_CART_PAGE;
            } else if (button.equals("Remove")) {
                url = REMOVE_CONTROLLER;
            } else if (button.equals("Edit")) {
                url = EDIT_CART_CONTROLLER;
            } else if (button.equals("Checkout")){
                url = CHECKOUT_CONTROLLER;
            } else if (button.equals("Create Google Account")){
                url = CREATE_GOOGLE_ACCOUNT_CONTROLLER;
            }
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
