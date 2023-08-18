/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Form;
import sample.users.UserDAO;
import sample.users.UserDTO;
import sample.users.UserGoogleDTO;

/**
 *
 * @author Acer
 */
@WebServlet(urlPatterns = {"/GoogleController"})
public class GoogleController extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";
    private static final String USER_PAGE = "MainController";
    private static final String US = "US";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        String code = request.getParameter("code");
        String url = LOGIN_PAGE;
        try {
            String accessToken = getToken(code);
            System.out.println(accessToken);
            UserGoogleDTO user = getUserInfo(accessToken);
            HttpSession session = request.getSession();
            System.out.println(user);
            UserDAO userDAO = new UserDAO();

            UserDTO loginUser = userDAO.checkLoginGoogle(user.getId());
            UserDTO loginUsers = new UserDTO(user.getId(), user.getName(), user.getEmail(), "US", "");
            if (loginUser == null) {
                userDAO.insertGoogle(user);
            }
            List<UserDTO> users = userDAO.getAllUser();
            for (UserDTO Users : users) {
                if (user.getId().trim().equals(Users.getUserID().trim())) {
                    loginUser = new UserDTO(user.getId(), Users.getFullName(), Users.getMail(), Users.getRoleID(), Users.getPassword(), Users.getImageURL());
                }
            }
            session.setAttribute("LOGIN_USER", loginUser);
        } catch (Exception e) {
            log("Error at LoginController: " + e.toString());
        } finally {
            request.getRequestDispatcher(USER_PAGE).forward(request, response);
        }
    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        // call api to get token
        String response = Request.Post(ConstainGoogle.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", ConstainGoogle.GOOGLE_CLIENT_ID)
                        .add("client_secret", ConstainGoogle.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", ConstainGoogle.GOOGLE_REDIRECT_URI).add("code", code)
                        .add("grant_type", ConstainGoogle.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(GoogleController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(GoogleController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(GoogleController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(GoogleController.class.getName()).log(Level.SEVERE, null, ex);
        }
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

    public static UserGoogleDTO getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = ConstainGoogle.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        UserGoogleDTO googlePojo = new Gson().fromJson(response, UserGoogleDTO.class);
        System.out.println(googlePojo);
        return googlePojo;
    }
}
