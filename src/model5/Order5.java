package model5;

public class Order5 {

    private long id;

    private java.sql.Timestamp orderTime;

    private java.math.BigDecimal totalAmount;

    private String status;

    private java.util.List<DishOrder5> dishes = new java.util.ArrayList<>();

    private java.util.List<ComboOrder5> combos = new java.util.ArrayList<>();

    private java.util.List<OrderTable5> orderTables = new java.util.ArrayList<>();

    public long getId() {
        return id;
    }

    public void setId(long value) {
        this.id = value;
    }

    public java.sql.Timestamp getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(java.sql.Timestamp value) {
        this.orderTime = value;
    }

    public java.math.BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(java.math.BigDecimal value) {
        this.totalAmount = value;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String value) {
        this.status = value;
    }

    public java.util.List<DishOrder5> getDishes() {
        return dishes;
    }

    public void setDishes(java.util.List<DishOrder5> value) {
        this.dishes = value;
    }

    public java.util.List<ComboOrder5> getCombos() {
        return combos;
    }

    public void setCombos(java.util.List<ComboOrder5> value) {
        this.combos = value;
    }

    public java.util.List<OrderTable5> getOrderTables() {
        return orderTables;
    }

    public void setOrderTables(java.util.List<OrderTable5> value) {
        this.orderTables = value;
    }
}
