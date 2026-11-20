
package dao5;

import model5.*;

import java.sql.*;
import java.util.*;

public class ComboDAO5 extends DAO5 {

    public List<Combo5> getComboByKeyword(String keyword)
            throws SQLException {

        List<Combo5> comboList = new ArrayList<>();

        String sql =
                "SELECT id, name, price, description, image, " +
                        "startDate, endDate " +
                        "FROM tblCombo5 " +
                        "WHERE LOWER(name) LIKE LOWER(?) " +
                        "ORDER BY name";

        String detailSql =
                "SELECT cd.id, cd.quantity, " +
                        "ds.id AS dsId, " +
                        "d.id AS dishId, d.name AS dishName, " +
                        "d.type, d.basePrice, d.description, d.image, " +
                        "z.id AS sizeId, z.name AS sizeName, " +
                        "z.pricePercentage " +
                        "FROM tblComboDetail5 cd " +
                        "JOIN tblDishSize5 ds ON ds.id = cd.dishSizeId " +
                        "JOIN tblDish5 d ON d.id = ds.dishId " +
                        "JOIN tblSize5 z ON z.id = ds.sizeId " +
                        "WHERE cd.comboId = ? " +
                        "ORDER BY cd.id";

        try (Connection con = DAO5.connect();
             PreparedStatement ps = con.prepareStatement(sql);
             PreparedStatement detailPs =
                     con.prepareStatement(detailSql)) {

            ps.setString(1, "%" + keyword + "%");

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Combo5 combo = new Combo5();

                    combo.setId(rs.getLong("id"));
                    combo.setName(rs.getString("name"));
                    combo.setPrice(rs.getBigDecimal("price"));
                    combo.setDescription(
                            rs.getString("description")
                    );
                    combo.setImage(rs.getString("image"));
                    combo.setStartDate(
                            rs.getTimestamp("startDate")
                    );
                    combo.setEndDate(
                            rs.getTimestamp("endDate")
                    );

                    List<ComboDetail5> details =
                            new ArrayList<>();

                    detailPs.setLong(1, combo.getId());

                    try (ResultSet detailRs =
                                 detailPs.executeQuery()) {

                        while (detailRs.next()) {

                            Dish5 dish = new Dish5();

                            dish.setId(
                                    detailRs.getLong("dishId")
                            );
                            dish.setName(
                                    detailRs.getString("dishName")
                            );
                            dish.setType(
                                    detailRs.getString("type")
                            );
                            dish.setBasePrice(
                                    detailRs.getBigDecimal("basePrice")
                            );
                            dish.setDescription(
                                    detailRs.getString("description")
                            );
                            dish.setImage(
                                    detailRs.getString("image")
                            );

                            Size5 size = new Size5();

                            size.setId(
                                    detailRs.getLong("sizeId")
                            );
                            size.setName(
                                    detailRs.getString("sizeName")
                            );
                            size.setPricePercentage(
                                    detailRs.getFloat("pricePercentage")
                            );

                            DishSize5 dishSize = new DishSize5();

                            dishSize.setId(
                                    detailRs.getLong("dsId")
                            );
                            dishSize.setDish(dish);
                            dishSize.setSize(size);

                            ComboDetail5 detail =
                                    new ComboDetail5();

                            detail.setId(
                                    detailRs.getLong("id")
                            );
                            detail.setQuantity(
                                    detailRs.getInt("quantity")
                            );
                            detail.setDishSize(dishSize);

                            details.add(detail);
                        }
                    }

                    combo.setDetails(details);
                    comboList.add(combo);
                }
            }
        }

        return comboList;
    }
}
