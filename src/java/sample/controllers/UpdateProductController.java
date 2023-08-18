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
import sample.products.ProductDAO;
import sample.products.ProductDTO;
import sample.users.UserDAO;
import sample.users.UserDTO;

/**
 *
 * @author Acer
 */
@WebServlet(name = "UpdateProductController", urlPatterns = {"/UpdateProductController"})
public class UpdateProductController extends HttpServlet {

    private static final String ERROR = "product_admin.jsp";
    private static final String SUCCESS = "product_admin.jsp";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
         String url = ERROR;
        try {
            String productID = request.getParameter("product_id");
            String name = request.getParameter("product_name");
            Double price = Double.parseDouble(request.getParameter("product_price"));
            int quantity = Integer.parseInt(request.getParameter("product_quantity"));
            String catelogi = request.getParameter("product_categori");
            ProductDAO productDAO = new ProductDAO();
            ProductDTO productDTO = new ProductDTO(productID, name, price, quantity, url, catelogi);
            boolean checkUpdate = productDAO.update(productDTO);

            if (checkUpdate) {
                List<ProductDTO> products = productDAO.getAllProduct();
                request.setAttribute("PRODUCTS", products);
                url = SUCCESS;
                 request.setAttribute("message", "Update product" +name+" successful");
                         request.setAttribute("message_erorr", "SUCCESS");
            }
            else {
                request.setAttribute("message", "Update product " +name+" Fail");
                         request.setAttribute("message_erorr", "ERORR");
            }
        } catch (Exception e) {
            log("Error at UpdateController: " + e.toString());
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
