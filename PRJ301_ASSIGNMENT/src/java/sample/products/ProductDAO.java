/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.products;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;
import sample.users.UserDTO;
import sample.utils.DBUtils;

/**
 *
 * @author Acer
 */
public class ProductDAO {

    private static final String GET_PRODUCT = "SELECT * FROM tblProducts";
    private static final String SEARCH_PRODUCT = "SELECT * FROM tblProducts WHERE name LIKE ?";
    private static final String DELETE = "DELETE tblUsers WHERE userID =?";
    private static final String UPDATE = "UPDATE tblProducts SET name = ?, price = ?,quantity = ?, categori = ? WHERE productID = ?";
    private static final String DELETE_PRODUCT = "DELETE tblProducts WHERE productID =?";
    private static final String INSERT = "INSERT INTO tblProducts(productID, name, price, quantity, imageURL, categori) VALUES(?,?,?,?,?,?)";
    private static final String CHECK_DUPLICATE_PRODUCTID="SELECT name FROM tblProducts WHERE productID = ?";
    
    public List<ProductDTO> getAllProduct() throws SQLException {
        List<ProductDTO> listTea = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_PRODUCT);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String id = rs.getString("productID").trim();
                    String name = rs.getString("name").trim();
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    String imageURL = rs.getString("imageURL").trim();
                    String categori = rs.getString("categori").trim();
                    listTea.add(new ProductDTO(id, name, price, quantity, imageURL, categori));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listTea;
    }

    public List<ProductDTO> getProduct(String search) throws SQLException {
        List<ProductDTO> listProduct = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SEARCH_PRODUCT);
                ptm.setString(1, "%" + search + "%");
                rs = ptm.executeQuery();
                while (rs.next()) {
                    String id = rs.getString("productID").trim();
                    String name = rs.getString("name").trim();
                    double price = rs.getDouble("price");
                    int quantity = rs.getInt("quantity");
                    String imageURL = rs.getString("imageURL").trim();
                    String categori = rs.getString("categori").trim();
                    listProduct.add(new ProductDTO(id, name, price, quantity, imageURL, categori));
                }
            }
        } catch (Exception e) {
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listProduct;
    }

    public boolean update(ProductDTO productDTO) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE);
                ptm.setString(1, productDTO.getName());
                ptm.setDouble(2, productDTO.getPrice());
                ptm.setInt(3, productDTO.getQuantity());
                ptm.setString(4, productDTO.getCategori());
                ptm.setString(5, productDTO.getProductID());
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean deleteProduct(String productID) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(DELETE_PRODUCT);
                ptm.setString(1, productID);
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
    
    public boolean insert(ProductDTO productDTO) throws SQLException, ClassNotFoundException, NamingException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT);
                ptm.setString(1, productDTO.getProductID());
                ptm.setString(2, productDTO.getName());
                ptm.setDouble(3, productDTO.getPrice());
                ptm.setInt(4, productDTO.getQuantity());
                ptm.setString(5, productDTO.getUrl());
                ptm.setString(6,productDTO.getCategori());
                check = ptm.executeUpdate() > 0 ? true : false;
            }
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
    
     public boolean checkDuplicateProductID(String mail) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_DUPLICATE_PRODUCTID);
                ptm.setString(1, mail);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    check = true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
}
