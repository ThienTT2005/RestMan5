package dao5;

import model5.*;

import java.sql.*;

import java.util.*;

public class DishDAO5 extends DAO5 {

    public List<Dish5> getDishByKeyword(String keyword) throws SQLException {
        List<Dish5> out = new ArrayList<>();
        String sql = "SELECT id,name,type,basePrice,description,image FROM tblDish5 WHERE LOWER(name) LIKE LOWER(?) ORDER BY name";
        try (Connection c = DAO5.connect();PreparedStatement p = c.prepareStatement(sql)) {
            p.setString(1,"%"+keyword+"%");
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    Dish5 d = new Dish5();
                    d.setId(r.getLong("id"));
                    d.setName(r.getString("name"));
                    d.setType(r.getString("type"));
                    d.setBasePrice(r.getBigDecimal("basePrice"));
                    d.setDescription(r.getString("description"));
                    d.setImage(r.getString("image"));
                    out.add(d);
                }
            }
        }
        return out;
    }
}
