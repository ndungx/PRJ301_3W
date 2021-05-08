package com.ndungx.controller;

import com.ndungx.user.UserDAO;
import com.ndungx.user.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/*
 * @author NDungx
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private static final String ERROR_PAGE = "loginfail.html";
    private static final String SEARCH_PAGE = "search.jsp";
    private static final String SHOPPING_PAGE = "GetProductServlet";
    static final Logger LOGGER = Logger.getLogger(LoginServlet.class);

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

        String userID = request.getParameter("userID");
        String password = request.getParameter("password");
        UserDAO dao = new UserDAO();

        String url = ERROR_PAGE;

        try {
            UserDTO dto = dao.checkLogin(userID, password);
            HttpSession session = request.getSession();

            Cookie cookie = new Cookie(userID, password);
            cookie.setMaxAge(60 * 3);
            response.addCookie(cookie);

            if (dto != null) {
                session.setAttribute("LOGIN_USER", dto);
                url = SEARCH_PAGE;
                if (dto.getRoleID().equals("AD") || dto.getRoleID().equals("M")) {
                    url = SEARCH_PAGE;
                }
                if (dto.getRoleID().equals("G")) {
                    url = SHOPPING_PAGE;
                }
            }
        } catch (SQLException e) {
            LOGGER.error(e.getMessage());
            log("LoginServlet _ SQL: " + e.getMessage());
        } catch (NamingException e) {
            LOGGER.error(e.getMessage());
            log("LoginServlet _ Naming: " + e.getMessage());
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
