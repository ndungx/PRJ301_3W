package com.ndungx.controller;

import com.ndungx.dtos.CartDTO;
import com.ndungx.dtos.TeaDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/*
 * @author NDungx
 */
@WebServlet(name = "AddServlet", urlPatterns = {"/AddServlet"})
public class AddServlet extends HttpServlet {

    private static final String ERROR_PAGE = "error.jsp";
    private static final String SHOPPING_PAGE = "shopping.jsp";

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

        String url = ERROR_PAGE;
        String teaStr = request.getParameter("cmbTea");
        String tmp[] = teaStr.split("-");
        String id = tmp[0];
        String name = tmp[1];
        double price = Double.parseDouble(tmp[2]);
        int quantity = 1;
        TeaDTO tea = new TeaDTO(id, name, quantity, price);

        try {
            HttpSession session = request.getSession();
            CartDTO cart = (CartDTO) session.getAttribute("CART");
            if (cart == null) {
                cart = new CartDTO();
            }
            cart.add(tea);
            session.setAttribute("CART", cart);
            request.setAttribute("MESSAGE", "You bought " + name + " Successfully");
            url = SHOPPING_PAGE;
        } catch (Exception e) {
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
