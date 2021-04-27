package com.ndungx.controller;

import com.ndungx.log4j.TestLog4jServlet;
import com.ndungx.product.ProductDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/*
 * @author NDungx
 */
@WebServlet(name = "AddServlet", urlPatterns = {"/AddServlet"})
public class AddServlet extends HttpServlet {

    private static final String ERROR_PAGE = "error.jsp";
    private static final String SHOPPING_PAGE = "GetProductServlet";
    static final Logger LOGGER = Logger.getLogger(AddServlet.class);

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
        String productID = request.getParameter("productID");
        String productName = request.getParameter("productName");
        String price = request.getParameter("price");
        String quantity = request.getParameter("quantity");
        String categoryID = request.getParameter("categoryID");
        String image = request.getParameter("image");
        ProductDTO dto
                = new ProductDTO(
                        Integer.parseInt(productID),
                        productName,
                        Float.parseFloat(price),
                        Integer.parseInt(quantity),
                        Integer.parseInt(categoryID),
                        image);

        try {
            HttpSession session = request.getSession();
            CartObj cart = (CartObj) session.getAttribute("CART");
            if (cart == null) {
                cart = new CartObj();
            }
            cart.add(dto);
            session.setAttribute("CART", cart);
            request.setAttribute("MESSAGE", "You bought " + productName + " Successfully");
            url = SHOPPING_PAGE;
        } catch (Exception e) {
            LOGGER.error(e.getMessage());
            log("CreateServlet: " + e.getMessage());
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
