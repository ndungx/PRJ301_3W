
import com.ndungx.controller.CreateServlet;
import com.ndungx.user.UserCreateErrorDTO;
import com.ndungx.user.UserDAO;
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
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/*
 * @author NDungx
 */
@WebServlet(urlPatterns = {"/CreateGoogleAccountServlet"})
public class CreateGoogleAccountServlet extends HttpServlet {

    private static final String LOGIN_WITH_GOOGLE_CONTROLLER = "LoginWithGoogleServlet";
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
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String url = CREATE_PAGE;

        try {
            HttpSession session = request.getSession();

            String userID = (String) session.getAttribute("USER_ID");
            String fullname = (String) session.getAttribute("FULLNAME");
            String roleID = "G";
            String password = (String) session.getAttribute("PASSWORD");
            String phone = request.getParameter("phone");
            String email = (String) session.getAttribute("USER_ID");
            String address = request.getParameter("address");

            UserDAO dao = new UserDAO();
            UserCreateErrorDTO error = new UserCreateErrorDTO("", "", "", "", "", "", "", "", "");
            boolean foundErr = false;

            if (!Validation.isValidPhoneNumber(phone)) {
                foundErr = true;
                error.setPhoneError("phone number invalid");
            }
            if (phone.length() < 10 || phone.length() > 12) {
                foundErr = true;
                error.setPhoneError("phone must be > 10 and < 12");
            }
            if (address.length() < 4 || address.length() > 100) {
                foundErr = true;
                error.setAddressError("address must be > 4 and < 100");
            }
            if (foundErr) {
                request.setAttribute("ERROR", error);
            } else {
                UserDTO dto = new UserDTO(userID, fullname, roleID, password, phone, email, address);
                dao.createAccount(dto);
                url = LOGIN_WITH_GOOGLE_CONTROLLER;
            }
        } catch (SQLException e) {
            LOGGER.error(e.getMessage());
            log("CreateGoogleAccountServlet _ SQL: " + e.getMessage());
        } catch (NamingException e) {
            LOGGER.error(e.getMessage());
            log("CreateGoogleAccountServlet _ Naming: " + e.getMessage());
        } catch(Exception e){
            LOGGER.error(e.getMessage());
            log("CreateGoogleAccountServlet _ Exception: " + e.getMessage());
        }finally {
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
