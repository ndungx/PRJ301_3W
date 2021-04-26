package com.ndungx.product;

import com.ndungx.utils.DBUtils;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.NamingException;

/*
 * @author NDungx
 */
public class ProductDAO implements Serializable{
private List<ProductDTO> productList;

    public List<ProductDTO> getProductList() {
        return this.productList;
    }

    public void getProduct() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;

        try {
            //1. connect DB
            con = DBUtils.makeConnection();
            if (con != null) {
                //2. create SQL String
                String sql = "Select productID, productName, price, quantity, categoryID, image "
                        + "From dbo.Product";
                //3. Create Statement and assign value to parameter
                stm = con.prepareStatement(sql);
                //4. Execute Query
                rs = stm.executeQuery();
                //5. Process result
                while (rs.next()) {
                    int productID = rs.getInt("productID");
                    String productName = rs.getString("productName");
                    float price = rs.getFloat("price");
                    int quantity = rs.getInt("quantity");
                    int categoryID = rs.getInt("categoryID");
                    String image = rs.getString("image");

                    ProductDTO dto = new ProductDTO(productID, productName, price, quantity, categoryID, image);
                    if (this.productList == null) {
                        this.productList = new ArrayList<>();
                    }//end if list account is not existed
                    this.productList.add(dto);
                }//end while traversing result
            }//end if con is opened
        } finally {
            if (con != null) {
                con.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
    }
}
