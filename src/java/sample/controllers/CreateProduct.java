/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.controllers;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import net.coobird.thumbnailator.Thumbnails;
import sample.products.ProductDAO;
import sample.products.ProductDTO;
import sample.users.UserDAO;
import sample.users.UserDTO;
import sample.users.UserError;

/**
 *
 * @author Acer
 */
@WebServlet(name = "CreateProduct", urlPatterns = {"/CreateProduct"})
public class CreateProduct extends HttpServlet {

    private static final String ERROR = "product_admin.jsp";
    private static final String SUCCESS = "product_admin.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        UserError userError = new UserError();

        try {
            ProductDAO productDAO = new ProductDAO();
            // Gọi phương thức getAllProduct() để lấy danh sách sản phẩm
            List<ProductDTO> products2 = productDAO.getAllProduct();
            request.setAttribute("LIST_USER", products2);

            Part filePart = request.getPart("image");
            String fileName = filePart.getSubmittedFileName();
            String fileExtension = fileName.substring(fileName.lastIndexOf('.')).toLowerCase();

            boolean checkValidation = true;
            String productID = request.getParameter("productID");
            String part = "./images/product/"+"crop_" + productID +fileExtension ;
            String saveImage = productID + fileExtension;
            String name = request.getParameter("name");
            Double price = Double.parseDouble(request.getParameter("price"));
            Integer quantity = Integer.parseInt(request.getParameter("quantity"));
            String categori = request.getParameter("categori");
            if (productDAO.checkDuplicateProductID(productID)) {
                checkValidation = false;
                request.setAttribute("message_erorr", "ERORR");
                request.setAttribute("message", "" + productID + " is duplicated!!!");
            }

            if (checkValidation) {
                ProductDTO product = new ProductDTO(productID, name, price, quantity, part, categori);
//                boolean checkInsert = userDAO.insert(user);
                boolean checkInsert = productDAO.insert(product);

                if (checkInsert) {
                     //filePart.write("C:\\Users\\Acer\\Desktop\\prj301\\ASSIGNMENT\\PRJ301_ASSIGNMENT\\web\\images\\product\\" + saveImage);
                    // Crop the image to a predefined size
                    int targetWidth = 341; // Specify the desired width
                    int targetHeight = 434; // Specify the desired height

                    BufferedImage originalImage = ImageIO.read(filePart.getInputStream());
                    BufferedImage resizedImage = Thumbnails.of(originalImage)
                            .size(targetWidth, targetHeight)
                            .asBufferedImage();

                    String croppedFileName = "C:\\Users\\Acer\\Desktop\\prj301\\ASSIGNMENT\\PRJ301_ASSIGNMENT\\web\\images\\product\\crop_" + saveImage;

                    // Save the cropped image
                    ImageIO.write(resizedImage, "jpg", new File(croppedFileName));
                    url = SUCCESS;

                    request.setAttribute("message_erorr", "SUCCESS");
                    request.setAttribute("message", "Create product " + productID + " successful");
                } else {
                    request.setAttribute("message_erorr", "ERORR");
                    request.setAttribute("message", "Create product " + productID + " fail");
                }
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
