/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.users.UserDAO;
import sample.users.UserDTO;

/**
 *
 * @author hoang
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {
    private static final String LOGIN_PAGE = "login.jsp";
    private static final String ADMIN_PAGE = "dashboard_admin.jsp";
    private static final String USER_PAGE = "index.jsp";
    private static final String US = "US";
    private static final String AD = "AD";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE;
        boolean check = false;
        try {
            String userID = request.getParameter("userID");
            String password = request.getParameter("password");
            UserDAO userDAO = new UserDAO();
            UserDTO loginUser = userDAO.checkLogin(userID, password);
            if (loginUser != null) {
                String roleID = loginUser.getRoleID();

            List<UserDTO> users = userDAO.getAllUser();
               for(UserDTO Users : users) {
                   if(userID.trim().equals(Users.getUserID().trim())){
                       loginUser = new UserDTO(userID, Users.getFullName() , Users.getMail(), Users.getRoleID(), Users.getPassword(), Users.getImageURL());
                   }
               }
                HttpSession session = request.getSession();
                if (AD.equals(roleID)) {
                    session.setAttribute("LOGIN_USER", loginUser);
                    url = ADMIN_PAGE;
                } else if (US.equals(roleID)) {
                    session.setAttribute("LOGIN_USER", loginUser);
                    url = USER_PAGE;
                } else {
                    request.setAttribute("ERROR", "Your role is not supported yet.");
                }
            } else {
                request.setAttribute("ERROR", "Khum dung userID or password!");
            }
        } catch (Exception e) {
            log("Error at LoginController: " + e.toString());
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
