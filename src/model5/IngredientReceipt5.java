package model5;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;


public class IngredientReceipt5 {

    private long id;
    private Timestamp importTime;
    private BigDecimal totalAmount;
    private Staff5 staff;
    private Supplier5 supplier;
    private List<IngredientReceiptDetail5> details = new ArrayList<>();

    public long getId() {
        return id;
    }

    public void setId(long value) {
        this.id = value;
    }

    public Timestamp getImportTime() {
        return importTime;
    }

    public void setImportTime(Timestamp value) {
        this.importTime = value;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal value) {
        this.totalAmount = value;
    }

    public Staff5 getStaff() {
        return staff;
    }

    public void setStaff(Staff5 value) {
        this.staff = value;
    }

    public Supplier5 getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier5 value) {
        this.supplier = value;
    }

    public List<IngredientReceiptDetail5> getDetails() {
        return details;
    }

    public void setDetails(List<IngredientReceiptDetail5> value) {
        this.details = value;
    }

}
