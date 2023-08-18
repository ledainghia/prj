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
 * @author Acer
 */
@WebServlet(name = "UpdateUserController", urlPatterns = {"/UpdateUserController"})
public class UpdateUserController extends HttpServlet {

    private static final String ERROR = "clients_admin.jsp";
    private static final String SUCCESS = "clients_admin.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String userID = request.getParameter("usersID1");
            String fullName = request.getParameter("fullName2");
            String roleID = request.getParameter("roleID3");
            String password = request.getParameter("password4");
            String mail = request.getParameter("email_user");
            UserDAO userDAO = new UserDAO();
            UserDTO userDTO = new UserDTO(userID, fullName, mail, roleID, password);
            System.out.println(userDTO);
            boolean checkUpdate = userDAO.update(userDTO);
            HttpSession session = request.getSession();
            if (checkUpdate) {
                UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
                if (loginUser.getUserID().equals(userID)) {
                    loginUser = new UserDTO(userID, fullName, mail, roleID, password);
                    session.setAttribute("LOGIN_USER", loginUser);
                }
                List<UserDTO> users = userDAO.getAllUser();
                request.setAttribute("LIST_USER", users);
                url = SUCCESS;
                 request.setAttribute("message_erorr", "SUCCESS");
                    request.setAttribute("message", "Update user " + fullName + " successfully");
            }
            else
            {
                request.setAttribute("message_erorr", "ERORR");
                    request.setAttribute("message", "Update user " + fullName + " fail"); 
            }
        } catch (Exception e) {
            log("Error at DeleteController: " + e.toString());
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
