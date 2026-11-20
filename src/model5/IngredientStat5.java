package model5;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;


public class IngredientStat5 extends Ingredient5 {

    private int quantityImported;
    private BigDecimal totalImportCost;
    private LocalDate startDate;
    private LocalDate endDate;

    public int getQuantityImported() {
        return quantityImported;
    }

    public void setQuantityImported(int value) {
        this.quantityImported = value;
    }

    public BigDecimal getTotalImportCost() {
        return totalImportCost;
    }

    public void setTotalImportCost(BigDecimal value) {
        this.totalImportCost = value;
    }

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate value) {
        this.startDate = value;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate value) {
        this.endDate = value;
    }

}
