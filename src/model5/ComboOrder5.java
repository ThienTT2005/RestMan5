package model5;

public class ComboOrder5 {

    private long id;

    private int quantity;

    private java.math.BigDecimal amount;

    private Combo5 combo;

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

    public Combo5 getCombo() {
        return combo;
    }

    public void setCombo(Combo5 value) {
        this.combo = value;
    }
}
