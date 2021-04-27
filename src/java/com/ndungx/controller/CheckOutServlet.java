package com.ndungx.controller;

import com.ndungx.log4j.TestLog4jServlet;
import com.ndungx.order.OrderDAO;
import com.ndungx.orderdetail.OrderDetailDAO;
import com.ndungx.product.ProductDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Map;
import java.util.Map.Entry;
import javax.naming.NamingException;
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
@WebServlet(name = "CheckOutServlet", urlPatterns = {"/CheckOutServlet"})
public class CheckOutServlet extends HttpServlet {

    private final String ERROR_PAGE = "error.jsp";
    private static final String OUT_OF_STOCK_PAGE = "viewCart.jsp";
    private final String CHECKOUT_SUCCESS = "checkout.jsp";
    static final Logger LOGGER = Logger.getLogger(CheckOutServlet.class);

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
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String userID = request.getParameter("userID");
        String address = request.getParameter("address");
        String total = request.getParameter("total");
        String shippingMethod = request.getParameter("cmbShippingMethod");

        OrderDAO orderDAO = new OrderDAO();
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();

        String url = ERROR_PAGE;

        try {
            HttpSession session = request.getSession(false);
            CartObj cart = (CartObj) session.getAttribute("CART");
            Map<Integer, ProductDTO> items = cart.getCart();

            boolean orderResult = orderDAO.addOrder(userID, Float.parseFloat(total) + Integer.parseInt(shippingMethod), address);

            int index = 0; //biến đếm số lượng hàng trong cart
            for (Entry<Integer, ProductDTO> product : items.entrySet()) {
                int orderID = orderDAO.getLastOrderID(userID);
                int productID = product.getKey();
                int quantity = product.getValue().getQuantity();
                int quantityDB = orderDetailDAO.getQuantity(productID);

                index++;
                if (quantityDB - quantity > 0) {
                    boolean orderDetailResult = orderDetailDAO.addOrderDetail(orderID, productID, quantity);
                    if (orderResult && orderDetailResult) {
                        orderDetailDAO.updateQuantity(productID, quantityDB - quantity);
                        url = CHECKOUT_SUCCESS;
                        request.setAttribute("ORDER_ID", orderID);
                        String orderDate = orderDAO.getOrderDate(orderID);
                        request.setAttribute("ORDER_DATE", orderDate);
                        request.setAttribute("SHIPPING_ADDRESS", address);
                        String productName = orderDAO.getProductName(productID);
                        request.setAttribute("PRODUCT_NAME", productName);
                        request.setAttribute("QUANTITY", quantity);
                        request.setAttribute("PRICE", product.getValue().getPrice());
                        request.setAttribute("SHIPPING_FEE", shippingMethod);
                    }
                } else {
                    request.setAttribute("OUT_OF_STOCK", "Stock just have: " + quantityDB + " items! Please take less.");
                    request.setAttribute("PRODUCT_ID", productID);
                    //nếu là món hàng đầu lố quantity trong DB thì bỏ qua dòng if 
                    // ở dưới và rollback order luôn vì chưa trừ quantity trong DB
                    if (index > 1) {
                        int indexRollBack = 0; //biến đếm để roll back lại quantity
                        for (Entry<Integer, ProductDTO> productRollBack : items.entrySet()) {
                            if (indexRollBack < items.size() - 1) {
                                if (indexRollBack < index - 1) {
                                    int productIDRollback = productRollBack.getKey();
                                    int quantityRollBack = productRollBack.getValue().getQuantity();
                                    int quantityDBRollBack = orderDetailDAO.getQuantity(productIDRollback);
                                    orderDetailDAO.rollBackQuantity(productIDRollback, quantityDBRollBack + quantityRollBack);
                                }
                            }
                            indexRollBack++;
                        }
                    }
                    orderDetailDAO.rollBackOrderDetail(orderDAO.getLastOrderID(userID));
                    orderDAO.rollBackOrder(orderDAO.getLastOrderID(userID));
                    url = OUT_OF_STOCK_PAGE;
                    break;
                }
            }
        } catch (SQLException e) {
            LOGGER.error(e.getMessage());
            log("CheckOutServlet _ SQL: " + e.getMessage());
            try {
                orderDetailDAO.rollBackOrderDetail(orderDAO.getLastOrderID(userID));
            } catch (NamingException ex) {
                LOGGER.error(ex.getMessage());
                log("CheckOutServlet _ Rollback _ Naming: " + ex.getMessage());
            } catch (SQLException ex) {
                LOGGER.error(ex.getMessage());
                log("CheckOutServlet _ Rollback _ SQL: " + ex.getMessage());
            }
            try {
                orderDAO.rollBackOrder(orderDAO.getLastOrderID(userID));
            } catch (NamingException ex) {
                LOGGER.error(ex.getMessage());
                log("CheckOutServlet _ Rollback _ Naming: " + ex.getMessage());
            } catch (SQLException ex) {
                LOGGER.error(ex.getMessage());
                log("CheckOutServlet _ Rollback _ SQL: " + ex.getMessage());
            }
        } catch (NamingException e) {
            LOGGER.error(e.getMessage());
            log("CheckOutServlet _ Naming: " + e.getMessage());
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
