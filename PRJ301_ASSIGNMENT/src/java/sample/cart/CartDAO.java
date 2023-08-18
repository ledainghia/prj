/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.cart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;
import sample.products.ProductDTO;
import sample.utils.DBUtils;

/**
 *
 * @author Acer
 */
public class CartDAO {

    private static final String CHECK_QUANTITY = "SELECT quantity FROM tblProducts WHERE productID = ?";
    private static final String INSERT_ORDER = "INSERT INTO tblOrders (orderID, userID, date, total) VALUES(?,?,?,?)";
    private static final String GET_ORDERID = "SELECT * FROM tblProducts";
    private static final String GET_BALANCE = "SELECT SUM(total) as balance FROM tblOrders";
    private static final String GET_BALANCE_DATE = "SELECT date FROM tblOrders GROUP BY date";
    private static final String GET_BALANCE_DATA = "SELECT SUM(total) AS balance FROM tblOrders GROUP BY date";
    private static final String INSERT_ORDERDETAIL = "INSERT INTO tblOrderDetails (orderDetailID, orderID, productID, price, quantity) VALUES(?,?,?,?,?)";
    private static final String UPDATE_QUANTITY = "UPDATE tblProducts SET quantity = ? WHERE productID = ?";
    private static final String QUANTITY = "SELECT quantity FROM tblProducts WHERE productID = ?";

    public boolean checkQuantity(String productID, int quantity) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CHECK_QUANTITY);
                ptm.setString(1, productID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    int quantityR = rs.getInt("quantity");
                    if (quantityR < quantity) {
                        check = false;
                    } else {
                        check = true;
                    }
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

    public boolean insertOrder(String userID, String orderID, Float total) throws SQLException, ClassNotFoundException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT_ORDER);
                ptm.setString(1, orderID);
                ptm.setString(2, userID);
                LocalDateTime currentTime = LocalDateTime.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yy");
                String formattedTime = currentTime.format(formatter);
                System.out.println("Current time: " + formattedTime);
                ptm.setString(3, formattedTime);
                ptm.setFloat(4, total);
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

    public Double getBalance() throws SQLException {
        Double balance = 0.0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_BALANCE);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    balance = rs.getDouble("balance");
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
        return balance;
    }
    
    public String getBalanceData() throws SQLException {
        String date = "[";
        int count = 1;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_BALANCE_DATA);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    if (count++ == 1) {
                        String tmp = rs.getString("balance").trim();
                        int index = tmp.indexOf(".");
                        date +=  tmp.substring(0,index+2) ;
                        System.out.println(date);
                    }
                    else{
                        String tmp = rs.getString("balance").trim();
                        int index = tmp.indexOf(".");
                         date += ", " + tmp.substring(0,index+2)  ;
                         System.out.println(date);
                    }
                }
                date+="]";
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
        return date;
    }
    
    public String getBalanceDate() throws SQLException {
        String date = "[";
        int count = 1;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_BALANCE_DATE);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    if (count++ == 1) {
                        date += "'" + rs.getString("date").trim() + "'";
                        System.out.println(date);
                    }
                    else{
                         date += ", '" + rs.getString("date").trim() + "'";
                         System.out.println(date);
                    }
                }
                date+="]";
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
        return date;
    }

    public String getOrderID() throws SQLException {
        int count = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_ORDERID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    count++;
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
        return Integer.toString(count);
    }

    public boolean insertOrderDetail(String orderDetailID, String orderID, String id, Double price, int quantity) throws SQLException, ClassNotFoundException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(INSERT_ORDERDETAIL);
                ptm.setString(1, orderDetailID);
                ptm.setString(2, orderID);
                ptm.setString(3, id);
                ptm.setDouble(4, price);
                ptm.setInt(5, quantity);
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

    public boolean updateQuantity(String teaID, int quantityCart) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_QUANTITY);
                int quantityDB = getQuantity(teaID);
                int quantityUpdate = quantityDB - quantityCart;
                ptm.setInt(1, quantityUpdate);
                ptm.setString(2, teaID);
                check = ptm.executeUpdate() > 0 ? true : false;
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
        return check;
    }

    public int getQuantity(String teaID) throws SQLException {
        int quantity = 0;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(QUANTITY);
                ptm.setString(1, teaID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    quantity = rs.getInt("quantity");
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
        return quantity;
    }
}
