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
import sample.cart.CartDAO;
import sample.products.ProductDAO;
import sample.products.ProductDTO;
import sample.users.UserDAO;
import sample.users.UserDTO;
import sample.users.UserError;

/**
 *
 * @author hoang
 */
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 100, // 1 MB
        maxFileSize = 1024 * 1024 * 100, // 10 MB
        maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class MainController extends HttpServlet {

    private static final String LOGIN_PAGE = "index.jsp";
    
    private static final String LOGIN = "Login";
    private static final String LOGIN_CONTROLLER = "LoginController";
    
    private static final String PRODUCT = "updateProduct";
    private static final String PRODUCT_CONTROLLER = "ProductController";
    
    private static final String GOOGLE = "Google";
    private static final String GOOGLE_CONTROLLER = "GoogleController";
    
    private static final String HOME = "home";
    private static final String HOME_PAGE = "index.jsp";
    private static final String HOME_ADMIN = "home_admin";
    private static final String HOME_ADMIN_PAGE = "dashboard_admin.jsp";
    
    private static final String PRODUCT_ADMIN = "product_admin";
    private static final String PRODUCT_ADMIN_PAGE = "product_admin.jsp";
    
    private static final String CLIENT_ADMIN = "client_admin";
    private static final String CLIENT_ADMIN_PAGE = "clients_admin.jsp";
    
    private static final String CHANGE = "ChangeInformation";
    private static final String CHANGE_CONTROLLER = "ChangInformationController";
    
    private static final String SEARCH = "Search";
    private static final String SEARCH_CONTROLLER = "SearchController";

    private static final String SEARCH_PRODUCT = "SearchProduct";
    private static final String SEARCH_PRODUCT_CONTROLLER = "SearchProductController";
    
    private static final String SEARCH_PRODUCT_ADMIN = "SearchProductAdmin";
    private static final String SEARCH_PRODUCT_ADMIN_CONTROLLER = "SearchProductAdminController";
    
    private static final String SEARCH_USER_ADMIN = "SearchUserAdmin";
    private static final String SEARCH_USER_ADMIN_CONTROLLER = "SearchUserAdminController";
    
    private static final String CART = "Cart";
    private static final String CART_PAGE = "shop_cart.jsp";
    
    private static final String PROFILE = "Profile";
    private static final String PROFILE_PAGE = "information.jsp";

    private static final String DELETE = "DeleteProduct";
    private static final String DELETE_CONTROLLER = "DeleteProductController";

    private static final String DELETE_USER = "DeleteUserAdmin";
    private static final String DELETE_USER_CONTROLLER = "DeleteClientController";
    
    private static final String DELETE_PRODUCT = "DeleteProductAdmin";
    private static final String DELETE_PRODUCT_CONTROLLER = "DeleteProductController";

    private static final String UPDATE = "UpdateUserAdmin";
    private static final String UPDATE_CONTROLLER = "UpdateUserController";

    private static final String UPDATE_PRODUCT = "UpdateProductAdmin";
    private static final String UPDATE_PRODUCT_CONTROLLER = "UpdateProductController";
    // fix lai :))))))))
    private static final String CREATE_PAGE = "CreatePage";
    private static final String CREATE_PAGE_VIEW = "create.html";

    private static final String CREATE = "createNewUser";
    private static final String CREATE_CONTROLLER = "CreateController";
    
    private static final String CREATE_USER = "createUserAdmin";
    private static final String CREATE_USER_AD_CONTROLLER = "CreateUserADController";
    
    private static final String CREATE_PRODUCT = "CreateProduct";
    private static final String CREATE_PRODUCT_CONTROLLER = "CreateProduct";

    private static final String LOGOUT = "Logout";
    private static final String LOGOUT_CONTROLLER = "LogoutController";

    private static final String ADD = "addToCart";
    private static final String ADD_CONTROLLER = "CartController";
    

    private static final String REMOVE = "Remove";
    private static final String REMOVE_CONTROLLER = "RemoveController";
    
    private static final String EDIT = "Edit";
    private static final String EDIT_CONTROLLER = "EditController";
    
    private static final String CHECKOUT = "Checkout";
    private static final String CHECKOUT_CONTROLLER = "CheckoutController";
    
    private static final String TOP2 = "top2";
    private static final String TOP2_CONTROLLER = "Top2Controller";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = LOGIN_PAGE;
        try {
            String action = request.getParameter("action");
            String actionn = request.getParameter("actionn");
            ProductDAO productDAO = new ProductDAO();

            List<ProductDTO> products = productDAO.getAllProduct();
            System.out.println(products.size());

            HttpSession session = request.getSession();
            if (request.getAttribute("PRODUCTS") == null) {
                request.setAttribute("PRODUCTS", products);
            }
            UserDAO userDAO = new UserDAO();

            List<UserDTO> users = userDAO.getAllUser();
            request.setAttribute("LIST_USER", users);
            
            CartDAO cartDAO = new CartDAO();
            
            request.setAttribute("BA1ACE",  Math.round( (cartDAO.getBalance() *100.0))/100.0);
            request.setAttribute("BALANCE_DATE", cartDAO.getBalanceDate());
            request.setAttribute("BALANCE_DATA", cartDAO.getBalanceData());
            if (action == null) {

                url = HOME_PAGE;
            }else if (TOP2.equals(action)) {
                url = TOP2_CONTROLLER;
            } else if (PRODUCT.equals(action)) {
                url = PRODUCT_CONTROLLER;
            } else if (LOGIN.equals(action)) {
                url = LOGIN_CONTROLLER;
            } else if (CLIENT_ADMIN.equals(action)) {
                url = CLIENT_ADMIN_PAGE;
            } else if (PROFILE.equals(action)) {
                url = PROFILE_PAGE;
            } else if (SEARCH.equals(action)) {
                url = SEARCH_CONTROLLER;
            } else if (SEARCH_PRODUCT.equals(action)) {
                url = SEARCH_PRODUCT_CONTROLLER;
            } else if (SEARCH_PRODUCT_ADMIN.equals(action)) {
                url = SEARCH_PRODUCT_ADMIN_CONTROLLER;
            } else if (SEARCH_USER_ADMIN.equals(action)) {
                url = SEARCH_USER_ADMIN_CONTROLLER;
            } else if (HOME.equals(action)) {
                url = HOME_PAGE;
            } else if (HOME_ADMIN.equals(action)) {
                url = HOME_ADMIN_PAGE;
            } else if (PRODUCT_ADMIN.equals(action)) {
                url = PRODUCT_ADMIN_PAGE;
            }else if (CART.equals(action)) {
                url =CART_PAGE;
            }else if (CHANGE.equals(action)) {
                url = CHANGE_CONTROLLER;
            } else if (DELETE.equals(action)) {
                url = DELETE_CONTROLLER;
            } else if (DELETE_USER.equals(action)) {
                url = DELETE_USER_CONTROLLER;
            } else if (DELETE_PRODUCT.equals(action)) {
                url = DELETE_PRODUCT_CONTROLLER;
            } else if (UPDATE.equals(action)) {
                url = UPDATE_CONTROLLER;
            } else if (UPDATE_PRODUCT.equals(action)) {
                url = UPDATE_PRODUCT_CONTROLLER;
            } else if (CREATE_PAGE.equals(action)) {
                url = CREATE_PAGE_VIEW;
            } else if (CREATE.equals(action)) {
                url = CREATE_CONTROLLER;
            }else if (CREATE_PRODUCT.equals(action)) {
                url = CREATE_PRODUCT_CONTROLLER;
            } else if (CREATE_USER.equals(action)) {
                url = CREATE_USER_AD_CONTROLLER;
            } else if (LOGOUT.equals(action)) {
                url = LOGOUT_CONTROLLER;
            }  else if (ADD.equals(action)) {
                url = ADD_CONTROLLER;
            }  else if (REMOVE.equals(action)) {
                url = REMOVE_CONTROLLER;
            } else if (EDIT.equals(action)) {
                url = EDIT_CONTROLLER;
            } else if (CHECKOUT.equals(action)) {
                url = CHECKOUT_CONTROLLER;
            }
        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
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
