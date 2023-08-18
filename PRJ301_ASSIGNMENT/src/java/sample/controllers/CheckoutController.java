/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sample.cart.Cart;
import sample.cart.CartDAO;
import sample.cart.Tea;
import sample.users.UserDTO;

/**
 *
 * @author Acer
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    private static final String SUCCESS = "index.jsp";
    private static final String ERROR = "login.jsp";
    private static final String ERROR1 = "shop_cart.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR1;
        boolean check = true, checkInsertOrder = true,checkInsertOrderDetail=false;
        String message = "";

        try {
            Float total = Float.parseFloat(request.getParameter("totalPrice"));
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");
            CartDAO cartDAO = new CartDAO();
            Cart cart = (Cart) session.getAttribute("CARTT");
            if (user == null) {
                url = ERROR1;
                request.setAttribute("message_erorr", "ERORR");
                request.setAttribute("message", "Your need to login to checkout !");
            } else {
                if (cart == null) {
                    url = ERROR1;
                    request.setAttribute("message_erorr", "ERORR");
                    request.setAttribute("message", "Your cart dont have any product. Please add and try again!!");
                } else {
                    for (Tea tea : cart.getCart().values()) {
                        String productID = tea.getId();
                        int quantity = tea.getQuantity();

                        check = cartDAO.checkQuantity(productID, quantity);
                        if (check == false) {
                            message += "Products " + tea.getName() + " in stock are not enough </br>";
                        }
                    }
                    if (!message.isEmpty()) {
                        url = ERROR1;
                        request.setAttribute("message_erorr", "ERORR");
                        request.setAttribute("message", message);
                    } else {
                        // CHECK CMN OUT <3
                        String orderID = UUID.randomUUID().toString().substring(0, 5);
                        checkInsertOrder = cartDAO.insertOrder(user.getUserID(), orderID, total);
                        System.out.println(checkInsertOrder);
                        if (checkInsertOrder) {
                            for (Tea tea : cart.getCart().values()) {
                                String orderDetailID = UUID.randomUUID().toString().substring(0, 5);
                                 checkInsertOrderDetail = cartDAO.insertOrderDetail(orderDetailID, orderID, tea.getId(), tea.getPrice(), tea.getQuantity());
                                 if(checkInsertOrderDetail){
                                     cartDAO.updateQuantity(tea.getId(), tea.getQuantity());
                                 }
                            }
                        }
                        //cập nhật quantity - > xóa attibui cảtt
                        
                        url = ERROR1;
                        session.setAttribute("CARTT", null);
                        request.setAttribute("message_erorr", "SUCCESS");
                        request.setAttribute("message", "SUCCESS");

                    }
                }
            }
        } catch (Exception e) {
            request.setAttribute("message_erorr", "ERORR");
                        request.setAttribute("message", e.toString());
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
