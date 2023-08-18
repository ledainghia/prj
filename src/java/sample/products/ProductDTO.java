/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.products;

/**
 *
 * @author Acer
 */
public class ProductDTO {
    private String productID;
    private String name;
    private double price;
    private int quantity;
    private String url;
    private String categori;
    public ProductDTO() {
    }

    public ProductDTO(String productID, String name, double price, int quantity, String url, String categori) {
        this.productID = productID.trim();
        this.name = name.trim();
        this.price = price;
        this.quantity = quantity;
        this.url = url.trim();
        this.categori = categori.trim();
    }

    public String getCategori() {
        return categori;
    }

    public void setCategori(String categori) {
        this.categori = categori;
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
    
    
}
