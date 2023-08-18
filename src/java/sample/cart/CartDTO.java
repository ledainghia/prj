/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.cart;

/**
 *
 * @author Acer
 */
public class CartDTO {

    private String cartID;
    private String productID;
    private String name;
    private double price;
    private int quantity;
    private String url;
    private String categori;

    public CartDTO(String cartID, String productID, String name, double price, int quantity) {
        this.cartID = cartID;
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
    }

    
    
    

    public CartDTO(String cartID, String productID, String name, double price, int quantity, String url, String categori) {
        this.cartID = cartID;
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.url = url;
        this.categori = categori;
    }

    public CartDTO(String cartID, String productID, String name, double price, int quantity, String url) {
        this.cartID = cartID;
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.url = url;
    }
    
    public CartDTO() {
    }
    
    
    public String getCartID() {
        return cartID;
    }

    public void setCartID(String cartID) {
        this.cartID = cartID;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getCategori() {
        return categori;
    }

    public void setCategori(String categori) {
        this.categori = categori;
    }
    

}
