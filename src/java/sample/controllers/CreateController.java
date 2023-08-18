/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.users.UserDAO;
import sample.users.UserDTO;
import sample.users.UserError;


/**
 *
 * @author hoang
 */
@WebServlet(name = "CreateController", urlPatterns = {"/CreateController"})
public class CreateController extends HttpServlet {
    private static final String ERROR = "login.jsp";
    private static final String SUCCESS = "index.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        UserError userError = new UserError();
        try {
            boolean checkValidation = true;
            String userID = request.getParameter("userID");
            String fullName = request.getParameter("fullName");
            String roleID = "US";
            String mail =request.getParameter("mail");
            String password = request.getParameter("password");
            String confirm = request.getParameter("repassword");
            UserDAO userDAO = new UserDAO();
            if (userID.length() < 2 || userID.length() > 30) {
                userError.setUserIDError("User ID must be in {2,30}");
                checkValidation = false;
            }
            boolean checkDuplicate = userDAO.checkDuplicate(userID);
            if (checkDuplicate) {
                userError.setUserIDError("Duplicate User ID !");
                checkValidation = false;
            }
             boolean checkDuplicateMail = userDAO.checkDuplicateMail(mail);
            if (checkDuplicate) {
                userError.setMailError("Duplicate mail !");
                checkValidation = false;
            }
            if (fullName.length() < 5 || fullName.length() > 30) {
                userError.setFullNameError("Full Name must be in {5,20}");
                checkValidation = false;
            }
            if (!password.equals(confirm)) {
                userError.setConfirmError("Hai password khong giong nhau!");
                checkValidation = false;
            }
            if (checkValidation) {
                UserDTO user = new UserDTO( userID,  fullName,  mail,  roleID,  password);
//                boolean checkInsert = userDAO.insert(user);
                boolean checkInsert = userDAO.insertV2(user);
                if (checkInsert) {
                    url = SUCCESS;
                    HttpSession session = request.getSession();
                    session.setAttribute("LOGIN_USER", user);
                } else {
                    request.setAttribute("ERROR", "Unknow error!");
                }
            } else {
                request.setAttribute("USER_ERROR", userError);
            }
        } catch (Exception e) {
            System.out.println("Error at CreateController: " + e.toString());
            log("Error at CreateController: " + e.toString());
            if (e.toString().contains("duplicate")) {
                userError.setUserIDError("Trung khoa chinh roi kia");
                request.setAttribute("USER_ERROR", userError);
            }
        } finally {
              
            request.getRequestDispatcher(url).forward(request, response);
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
