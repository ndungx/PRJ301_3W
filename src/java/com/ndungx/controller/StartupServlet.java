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
@WebServlet(name = "StartupServlet", urlPatterns = {"/StartupServlet"})
public class StartupServlet extends HttpServlet {

    private final String LOGIN_PAGE = "index.html";
    private final String SEARCH_PAGE = "search.jsp";
    private static final String SHOPPING_PAGE = "GetProductServlet";
    static final Logger LOGGER = Logger.getLogger(StartupServlet.class);

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

        String url = LOGIN_PAGE;

        try {
            //1. Check cookie existed
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                System.out.println("Cookies found.");
                //2. Get username and password
                for (Cookie cookie : cookies) {
                    String userID = cookie.getName();
                    String password = cookie.getValue();
                    //3. Check if username & password is correct
                    UserDAO dao = new UserDAO();
                    UserDTO dto = dao.checkLogin(userID, password);
                    if (dto != null) {
                        HttpSession session = request.getSession(true);
                        session.setAttribute("LOGIN_USER", dto);
                        url = SEARCH_PAGE;
                        if (dto.getRoleID().equals("AD")) {
                            url = SEARCH_PAGE;
                        }
                        if (dto.getRoleID().equals("G")) {
                            url = SHOPPING_PAGE;
                        }
                    }//end if user valid
                }//end for
            }//end if cookies existed
        } catch (SQLException ex) {
            LOGGER.error(ex.getMessage());
            log("StartupServlet _ SQL: ", ex.getCause());
        } catch (NamingException ex) {
            LOGGER.error(ex.getMessage());
            log("StartupServlet _ Naming: ", ex.getCause());
        } finally {
            //dung rd hay redirect cung dc
            //gia tri luu tru trong cookie k bi mat khi tra response
//            response.sendRedirect(url);
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
