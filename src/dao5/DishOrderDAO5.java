
package dao5;

import model5.*;

import java.sql.*;
import java.util.*;
import java.math.BigDecimal;

public class DishOrderDAO5 extends DAO5 {

    public List<DishOrder5> getDishOrderByDishStat(DishStat5 stat)
            throws SQLException {

        List<DishOrder5> dishOrderList = new ArrayList<>();

        String sql =
                "SELECT od.id, od.quantity, od.price, " +
                        "ds.id AS dsId, " +
                        "z.id AS sizeId, z.name AS sizeName, " +
                        "z.pricePercentage, " +
                        "o.id AS orderId, o.orderTime, o.status " +
                        "FROM tblDishOrder5 od " +
                        "JOIN tblDishSize5 ds ON ds.id = od.dishSizeId " +
                        "JOIN tblSize5 z ON z.id = ds.sizeId " +
                        "JOIN tblOrder5 o ON o.id = od.orderId " +
                        "JOIN tblBill5 b ON b.orderId = o.id " +
                        "WHERE ds.dishId = ? " +
                        "AND b.paymentTime >= ? " +
                        "AND b.paymentTime < ? " +
                        "ORDER BY o.orderTime, od.id";

        String tableSql =
                "SELECT ot.id, " +
                        "t.id AS tableId, t.tableNumber " +
                        "FROM tblOrderTable5 ot " +
                        "JOIN tblTable5 t ON t.id = ot.tableId " +
                        "WHERE ot.orderId = ? " +
                        "ORDER BY t.tableNumber";

        try (Connection con = DAO5.connect();
             PreparedStatement ps = con.prepareStatement(sql);
             PreparedStatement tablePs =
                     con.prepareStatement(tableSql)) {

            ps.setLong(1, stat.getId());

            ps.setTimestamp(
                    2,
                    Timestamp.valueOf(
                            stat.getStartDate().atStartOfDay()
                    )
            );

            ps.setTimestamp(
                    3,
                    Timestamp.valueOf(
                            stat.getEndDate()
                                    .plusDays(1)
                                    .atStartOfDay()
                    )
            );

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Size5 size = new Size5();

                    size.setId(rs.getLong("sizeId"));
                    size.setName(rs.getString("sizeName"));
                    size.setPricePercentage(
                            rs.getFloat("pricePercentage")
                    );

                    DishSize5 dishSize = new DishSize5();

                    dishSize.setId(rs.getLong("dsId"));
                    dishSize.setDish(stat);
                    dishSize.setSize(size);

                    Order5 order = new Order5();

                    order.setId(rs.getLong("orderId"));
                    order.setOrderTime(
                            rs.getTimestamp("orderTime")
                    );
                    order.setStatus(rs.getString("status"));

                    DishOrder5 dishOrder = new DishOrder5();

                    dishOrder.setId(rs.getLong("id"));
                    dishOrder.setQuantity(
                            rs.getInt("quantity")
                    );

                    BigDecimal price =
                            rs.getBigDecimal("price");

                    dishOrder.setAmount(
                            price.multiply(
                                    BigDecimal.valueOf(
                                            dishOrder.getQuantity()
                                    )
                            )
                    );

                    dishOrder.setDishSize(dishSize);
                    dishOrder.setOrder(order);

                    // Lấy danh sách bàn của lần gọi món
                    tablePs.setLong(1, order.getId());

                    try (ResultSet tableRs =
                                 tablePs.executeQuery()) {

                        while (tableRs.next()) {

                            Table5 table = new Table5();

                            table.setId(
                                    tableRs.getLong("tableId")
                            );
                            table.setTableNumber(
                                    tableRs.getInt("tableNumber")
                            );

                            OrderTable5 orderTable =
                                    new OrderTable5();

                            orderTable.setId(
                                    tableRs.getLong("id")
                            );
                            orderTable.setTable(table);

                            order.getOrderTables().add(
                                    orderTable
                            );
                        }
                    }

                    dishOrderList.add(dishOrder);
                }
            }
        }

        return dishOrderList;
    }
}
