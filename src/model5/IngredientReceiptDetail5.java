package model5;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;


public class IngredientReceiptDetail5 {

    private long id;
    private float quantity;
    private BigDecimal amount;
    private BigDecimal price;
    private Ingredient5 ingredient;

    public long getId() {
        return id;
    }

    public void setId(long value) {
        this.id = value;
    }

    public float getQuantity() {
        return quantity;
    }

    public void setQuantity(float value) {
        this.quantity = value;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal value) {
        this.amount = value;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal value) {
        this.price = value;
    }

    public Ingredient5 getIngredient() {
        return ingredient;
    }

    public void setIngredient(Ingredient5 value) {
        this.ingredient = value;
    }

}
