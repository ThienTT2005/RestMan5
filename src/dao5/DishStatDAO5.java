
package dao5;

import model5.*;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class DishStatDAO5 extends DAO5 {

    public List<DishStat5> getDishStat(
            LocalDate startDate,
            LocalDate endDate
    ) throws SQLException {

        List<DishStat5> out = new ArrayList<>();

        String sql =
                "SELECT d.id, d.name, d.type, d.basePrice, " +
                        "d.description, d.image, " +
                        "SUM(od.quantity) AS qty, " +
                        "SUM(od.quantity * od.price) AS revenue " +
                        "FROM tblDish5 d " +
                        "JOIN tblDishSize5 ds ON ds.dishId = d.id " +
                        "JOIN tblDishOrder5 od ON od.dishSizeId = ds.id " +
                        "JOIN tblBill5 b ON b.orderId = od.orderId " +
                        "WHERE b.paymentTime >= ? " +
                        "AND b.paymentTime < ? " +
                        "GROUP BY d.id, d.name, d.type, " +
                        "d.basePrice, d.description, d.image " +
                        "ORDER BY revenue DESC, d.name";

        try (Connection con = DAO5.connect();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setTimestamp(
                    1,
                    Timestamp.valueOf(startDate.atStartOfDay())
            );

            ps.setTimestamp(
                    2,
                    Timestamp.valueOf(
                            endDate.plusDays(1).atStartOfDay()
                    )
            );

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    DishStat5 stat = new DishStat5();

                    // Thuộc tính kế thừa từ Dish5
                    stat.setId(rs.getLong("id"));
                    stat.setName(rs.getString("name"));
                    stat.setType(rs.getString("type"));
                    stat.setBasePrice(
                            rs.getBigDecimal("basePrice")
                    );
                    stat.setDescription(
                            rs.getString("description")
                    );
                    stat.setImage(rs.getString("image"));

                    // Thuộc tính riêng của DishStat5
                    stat.setQuantitySold(rs.getInt("qty"));
                    stat.setTotalAmount(
                            rs.getBigDecimal("revenue")
                    );
                    stat.setStartDate(startDate);
                    stat.setEndDate(endDate);

                    out.add(stat);
                }
            }
        }

        return out;
    }
}
