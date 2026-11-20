
package dao5;

import model5.*;

import java.sql.*;
import java.math.BigDecimal;

public class OrderDAO5 extends DAO5 {

    public Order5 getOrderByDishOrder(DishOrder5 item)
            throws SQLException {

        long orderId = item.getOrder().getId();

        String orderSql =
                "SELECT id, orderTime, status " +
                        "FROM tblOrder5 " +
                        "WHERE id = ?";

        String dishSql =
                "SELECT od.id, od.quantity, od.price, " +
                        "ds.id AS dsId, " +
                        "d.id AS dishId, d.name, d.type, " +
                        "d.basePrice, d.description, d.image, " +
                        "z.id AS sizeId, z.name AS sizeName, " +
                        "z.pricePercentage " +
                        "FROM tblDishOrder5 od " +
                        "JOIN tblDishSize5 ds ON ds.id = od.dishSizeId " +
                        "JOIN tblDish5 d ON d.id = ds.dishId " +
                        "JOIN tblSize5 z ON z.id = ds.sizeId " +
                        "WHERE od.orderId = ? " +
                        "ORDER BY od.id";

        String comboSql =
                "SELECT co.id, co.quantity, co.price, " +
                        "c.id AS comboId, c.name, c.description, " +
                        "c.image, c.startDate, c.endDate, " +
                        "c.price AS comboPrice " +
                        "FROM tblComboOrder5 co " +
                        "JOIN tblCombo5 c ON c.id = co.comboId " +
                        "WHERE co.orderId = ? " +
                        "ORDER BY co.id";

        String tableSql =
                "SELECT ot.id, t.id AS tableId, " +
                        "t.tableNumber, t.capacity, t.status, " +
                        "t.`condition`, t.type " +
                        "FROM tblOrderTable5 ot " +
                        "JOIN tblTable5 t ON t.id = ot.tableId " +
                        "WHERE ot.orderId = ? " +
                        "ORDER BY t.tableNumber";

        try (Connection con = DAO5.connect();
             PreparedStatement orderPs =
                     con.prepareStatement(orderSql);
             PreparedStatement dishPs =
                     con.prepareStatement(dishSql);
             PreparedStatement comboPs =
                     con.prepareStatement(comboSql);
             PreparedStatement tablePs =
                     con.prepareStatement(tableSql)) {

            orderPs.setLong(1, orderId);

            try (ResultSet rs = orderPs.executeQuery()) {

                if (!rs.next()) {
                    return null;
                }

                Order5 order = new Order5();

                order.setId(rs.getLong("id"));
                order.setOrderTime(
                        rs.getTimestamp("orderTime")
                );
                order.setStatus(rs.getString("status"));

                // 1. Lấy danh sách món ăn trong đơn hàng
                dishPs.setLong(1, order.getId());

                try (ResultSet dishRs =
                             dishPs.executeQuery()) {

                    while (dishRs.next()) {

                        Dish5 dish = new Dish5();

                        dish.setId(
                                dishRs.getLong("dishId")
                        );
                        dish.setName(
                                dishRs.getString("name")
                        );
                        dish.setType(
                                dishRs.getString("type")
                        );
                        dish.setBasePrice(
                                dishRs.getBigDecimal("basePrice")
                        );
                        dish.setDescription(
                                dishRs.getString("description")
                        );
                        dish.setImage(
                                dishRs.getString("image")
                        );

                        Size5 size = new Size5();

                        size.setId(
                                dishRs.getLong("sizeId")
                        );
                        size.setName(
                                dishRs.getString("sizeName")
                        );
                        size.setPricePercentage(
                                dishRs.getFloat("pricePercentage")
                        );

                        DishSize5 dishSize = new DishSize5();

                        dishSize.setId(
                                dishRs.getLong("dsId")
                        );
                        dishSize.setDish(dish);
                        dishSize.setSize(size);

                        DishOrder5 dishOrder =
                                new DishOrder5();

                        dishOrder.setId(
                                dishRs.getLong("id")
                        );
                        dishOrder.setQuantity(
                                dishRs.getInt("quantity")
                        );

                        BigDecimal dishPrice =
                                dishRs.getBigDecimal("price");

                        dishOrder.setAmount(
                                dishPrice.multiply(
                                        BigDecimal.valueOf(
                                                dishOrder.getQuantity()
                                        )
                                )
                        );

                        dishOrder.setDishSize(dishSize);
                        dishOrder.setOrder(order);

                        order.getDishes().add(dishOrder);
                    }
                }

                // 2. Lấy danh sách combo trong đơn hàng
                comboPs.setLong(1, order.getId());

                try (ResultSet comboRs =
                             comboPs.executeQuery()) {

                    while (comboRs.next()) {

                        Combo5 combo = new Combo5();

                        combo.setId(
                                comboRs.getLong("comboId")
                        );
                        combo.setName(
                                comboRs.getString("name")
                        );
                        combo.setPrice(
                                comboRs.getBigDecimal("comboPrice")
                        );
                        combo.setDescription(
                                comboRs.getString("description")
                        );
                        combo.setImage(
                                comboRs.getString("image")
                        );
                        combo.setStartDate(
                                comboRs.getTimestamp("startDate")
                        );
                        combo.setEndDate(
                                comboRs.getTimestamp("endDate")
                        );

                        ComboOrder5 comboOrder =
                                new ComboOrder5();

                        comboOrder.setId(
                                comboRs.getLong("id")
                        );
                        comboOrder.setQuantity(
                                comboRs.getInt("quantity")
                        );

                        BigDecimal comboPrice =
                                comboRs.getBigDecimal("price");

                        comboOrder.setAmount(
                                comboPrice.multiply(
                                        BigDecimal.valueOf(
                                                comboOrder.getQuantity()
                                        )
                                )
                        );

                        comboOrder.setCombo(combo);

                        order.getCombos().add(comboOrder);
                    }
                }

                // 3. Lấy danh sách bàn của đơn hàng
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
                        table.setCapacity(
                                tableRs.getInt("capacity")
                        );
                        table.setStatus(
                                tableRs.getString("status")
                        );
                        table.setCondition(
                                tableRs.getString("condition")
                        );
                        table.setType(
                                tableRs.getString("type")
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

                // 4. Tính tổng tiền đơn hàng
                BigDecimal totalAmount = BigDecimal.ZERO;

                for (DishOrder5 dishOrder :
                        order.getDishes()) {

                    totalAmount = totalAmount.add(
                            dishOrder.getAmount()
                    );
                }

                for (ComboOrder5 comboOrder :
                        order.getCombos()) {

                    totalAmount = totalAmount.add(
                            comboOrder.getAmount()
                    );
                }

                order.setTotalAmount(totalAmount);

                return order;
            }
        }
    }
}
