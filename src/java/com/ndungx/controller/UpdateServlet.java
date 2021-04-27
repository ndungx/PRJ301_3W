package com.ndungx.controller;

import com.ndungx.user.UserDAO;
import com.ndungx.user.UserDTO;
import com.ndungx.user.UserUpdateErrorsDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
@WebServlet(name = "UpdateServlet", urlPatterns = {"/UpdateServlet"})
public class UpdateServlet extends HttpServlet {

    private static final String ERROR_PAGE = "error.jsp";
    private static final String SEARCH_CONTROLLER = "SearchServlet";
    static final Logger LOGGER = Logger.getLogger(UpdateServlet.class);

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
        String fullname = request.getParameter("fullname");
        String roleID = request.getParameter("roleID");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String password = "";
        UserDTO dto = new UserDTO(userID, fullname, roleID, phone, email, address, password);
        UserDAO dao = new UserDAO();
        UserUpdateErrorsDTO error = new UserUpdateErrorsDTO();
        boolean foundErr = false;

        String url = ERROR_PAGE;

        try {
            HttpSession session = request.getSession();

            if (fullname.length() < 5 || fullname.length() > 20) {
                foundErr = true;
                error.setFullnameLengthErr("full name must be > 5 and < 20");
            }
            if (roleID.length() < 1 || roleID.length() > 10) {
                foundErr = true;
                error.setRoleIDLengthErr("role ID must be > 1 and < 10");
            }
            if (foundErr) {
                session.setAttribute("UPDATE_ERROR", error);
                session.setAttribute("UPDATE_ERROR_FULLNAME", fullname);
                url = SEARCH_CONTROLLER;
            } else {
                UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");

                boolean check = dao.updateAccount(dto);
                if (check) {
                    if (loginUser != null) {
                        if (loginUser.getUserID().equals(userID)) {
                            loginUser.setFullname(fullname);
                            loginUser.setRoleID(roleID);
                            request.setAttribute("LOGIN_USER", loginUser);
                        }
                    }
                    url = SEARCH_CONTROLLER;
                }
            }
        } catch (SQLException e) {
            LOGGER.error(e.getMessage());
            log("UpdateServlet _ SQL: " + e.getMessage());
        } catch (NamingException e) {
            LOGGER.error(e.getMessage());
            log("UpdateServlet _ Naming: " + e.getMessage());
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
