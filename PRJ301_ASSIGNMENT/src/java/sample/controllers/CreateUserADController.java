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
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import sample.users.UserDAO;
import sample.users.UserDTO;
import sample.users.UserError;

/**
 *
 * @author Acer
 */
@WebServlet(name = "CreateUserADController", urlPatterns = {"/CreateUserADController"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 100, // 1 MB
        maxFileSize = 1024 * 1024 * 100, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class CreateUserADController extends HttpServlet {

    private static final String ERROR = "clients_admin.jsp";
    private static final String SUCCESS = "clients_admin.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        UserError userError = new UserError();
        
        try {
            UserDAO userDAO = new UserDAO();
            // Gọi phương thức getAllProduct() để lấy danh sách sản phẩm

            List<UserDTO> users2 = userDAO.getAllUser();
            request.setAttribute("LIST_USER", users2);

            Part filePart = request.getPart("file");
            String fileName = filePart.getSubmittedFileName();
             String fileExtension = fileName.substring(fileName.lastIndexOf('.')).toLowerCase();   
           
            
            boolean checkValidation = true;
            String userID = request.getParameter("userID");
            String part = "./images/client/"+userID+fileExtension;
            String saveImage =userID+fileExtension;
            String fullName = request.getParameter("fullName");
            String roleID = request.getParameter("roleID");;
            String mail = request.getParameter("mail");
            String password = request.getParameter("password");
            String confirm = request.getParameter("repassword");
        
            if (userID.length() < 2 || userID.length() > 30) {
                userError.setUserIDError("User ID must be in {2,30}");
                request.setAttribute("message_erorr", "ERORR");
                request.setAttribute("message", "User ID must be in {2,30}");
                checkValidation = false;
            }
            boolean checkDuplicate = userDAO.checkDuplicate(userID);
            if (checkDuplicate) {
                userError.setUserIDError("Duplicate User ID !");
                request.setAttribute("message_erorr", "ERORR");
                request.setAttribute("message", "Duplicate User ID !");
                checkValidation = false;
            }
            boolean checkDuplicateMail = userDAO.checkDuplicateMail(mail);
            if (checkDuplicateMail) {
                userError.setMailError("Duplicate mail !");
                request.setAttribute("message_erorr", "ERORR");
                request.setAttribute("message", "Duplicate mail !");
                checkValidation = false;
            }
            if (fullName.length() < 5 || fullName.length() > 30) {
                userError.setFullNameError("Full Name must be in {5,20}");
                request.setAttribute("message_erorr", "ERORR");
                request.setAttribute("message", "Full Name must be in {5,20}");
                checkValidation = false;
            }
            if (checkValidation) {
                UserDTO user = new UserDTO(userID, fullName, mail, roleID, password, part);
//                boolean checkInsert = userDAO.insert(user);
                boolean checkInsert = userDAO.insertV2(user);
                
                if (checkInsert) {
                     filePart.write("C:\\Users\\Acer\\Desktop\\prj301\\ASSIGNMENT\\PRJ301_ASSIGNMENT\\web\\images\\client\\" + saveImage);
                    url = SUCCESS;
                    // Gọi phương thức getAllProduct() để lấy danh sách sản phẩm
                    List<UserDTO> users = userDAO.getAllUser();
                    request.setAttribute("LIST_USER", users);
                    request.setAttribute("message_erorr", "SUCCESS");
                    request.setAttribute("message", "Create user successful");
                } else {
                    request.setAttribute("ERROR", "Unknow error!");
                }
            } else {
                request.setAttribute("USER_ERRORR", userError);
            }
        } catch (Exception e) {
            System.out.println("Error at CreateUserADController: " + e.toString());
            log("Error at CreateController: " + e.toString());
            if (e.toString().contains("duplicate")) {
                userError.setUserIDError("Trung khoa chinh roi kia");
                request.setAttribute("USER_ERRORR", userError);
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
