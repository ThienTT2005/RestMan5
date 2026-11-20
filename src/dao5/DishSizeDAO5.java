package dao5;

import model5.*;

import java.sql.*;

import java.util.*;

public class DishSizeDAO5 extends DAO5 {

    public List<DishSize5> getDishSizeByDish(Dish5 dish) throws SQLException {
        List<DishSize5> out = new ArrayList<>();
        String sql = "SELECT ds.id,z.id AS sizeId,z.name,z.pricePercentage FROM tblDishSize5 ds JOIN tblSize5 z ON z.id=ds.sizeId WHERE ds.dishId=? ORDER BY z.pricePercentage";
        try (Connection c = DAO5.connect();PreparedStatement p = c.prepareStatement(sql)) {
            p.setLong(1, dish.getId());
            try (ResultSet r = p.executeQuery()) {
                while (r.next()) {
                    Size5 z = new Size5();
                    z.setId(r.getLong("sizeId"));
                    z.setName(r.getString("name"));
                    z.setPricePercentage(r.getFloat("pricePercentage"));
                    DishSize5 ds = new DishSize5();
                    ds.setId(r.getLong("id"));
                    ds.setDish(dish);
                    ds.setSize(z);
                    out.add(ds);
                }
            }
        }
        return out;
    }
}
