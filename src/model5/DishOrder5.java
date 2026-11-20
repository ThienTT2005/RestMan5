package model5;

public class DishOrder5 {

    private long id;

    private int quantity;

    private java.math.BigDecimal amount;

    private DishSize5 dishSize;

    private Order5 order;

    public long getId() {
        return id;
    }

    public void setId(long value) {
        this.id = value;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int value) {
        this.quantity = value;
    }

    public java.math.BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(java.math.BigDecimal value) {
        this.amount = value;
    }

    public DishSize5 getDishSize() {
        return dishSize;
    }

    public void setDishSize(DishSize5 value) {
        this.dishSize = value;
    }

    public Order5 getOrder() {
        return order;
    }

    public void setOrder(Order5 value) {
        this.order = value;
    }
}
