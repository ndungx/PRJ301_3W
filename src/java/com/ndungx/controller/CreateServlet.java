package com.ndungx.controller;

import com.ndungx.log4j.TestLog4jServlet;
import com.ndungx.user.UserDAO;
import com.ndungx.user.UserCreateErrorDTO;
import com.ndungx.user.UserDTO;
import com.ndungx.valivation.Validation;
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
import org.apache.log4j.Logger;

/*
 * @author NDungx
 */
@WebServlet(name = "CreateServlet", urlPatterns = {"/CreateServlet"})
public class CreateServlet extends HttpServlet {

    private static final String LOGIN_PAGE = "index.html";
    private static final String CREATE_PAGE = "createAccount.jsp";
    static final Logger LOGGER = Logger.getLogger(CreateServlet.class);

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
        String roleID = "G";
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirm");
        String url = CREATE_PAGE;
        UserDAO dao = new UserDAO();
        UserCreateErrorDTO error = new UserCreateErrorDTO("", "", "", "", "", "", "", "", "");
        boolean check = false;

        try {
            if (userID.length() < 3 || userID.length() > 10) {
                check = true;
                error.setUserIDError("userID must be > 3 and < 10");
            }
            if (fullname.length() < 5 || fullname.length() > 50) {
                check = true;
                error.setFullnameError("full name must be > 5 and < 50");
            }
            if (!Validation.isValidPhoneNumber(phone)) {
                check = true;
                error.setPhoneError("phone number invalid");
            }
            if (phone.length() < 10 || phone.length() > 12) {
                check = true;
                error.setPhoneError("phone must be > 10 and < 12");
            }
            if (!Validation.isValidEmail(email)) {
                check = true;
                error.setEmailError("email invalid");
            }
            if (email.length() < 2 || email.length() > 10) {
                check = true;
                error.setEmailError("email must be > 2 and < 10");
            }
            if (address.length() < 4 || address.length() > 50) {
                check = true;
                error.setAddressError("address must be > 4 and < 50");
            }
            if (password.length() < 4 || password.length() > 20) {
                check = true;
                error.setPasswordError("password must be > 4 and < 20");
            } else if (!confirm.equals(password)) {
                check = true;
                error.setConfirmError("confirm does not match password");
            }
            if (check) {
                request.setAttribute("ERROR", error);
            } else {
                boolean checkDuplicate = dao.checkDuplicate(userID);
                if (checkDuplicate) {
                    error.setUserIDError("user ID is duplicate");
                    request.setAttribute("ERROR", error);
                } else {
                    UserDTO dto = new UserDTO(userID, fullname, roleID, phone, email, address, password);
                    dao.createAccount(dto);
                    url = LOGIN_PAGE;
                }
            }
        } catch (SQLException e) {
            String errMsg = e.getMessage();
            LOGGER.error(e.getMessage());
            log("CreateServlet _ SQL: " + errMsg);
            if (errMsg.contains("duplicate")) {
                error.setUserIDDuplicateError(userID + " is existed");
                request.setAttribute("CREATE_ERROR", error);
            }
        } catch (NamingException e) {
            LOGGER.error(e.getMessage());
            log("CreateServlet _ Naming: " + e.getMessage());
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
