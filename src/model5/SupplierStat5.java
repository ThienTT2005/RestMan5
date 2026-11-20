package model5;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;


public class SupplierStat5 extends Supplier5 {

    private int receiptCount;
    private int totalQuantity;
    private BigDecimal totalImportCost;
    private Timestamp startDate;
    private Timestamp endDate;

    public int getReceiptCount() {
        return receiptCount;
    }

    public void setReceiptCount(int value) {
        this.receiptCount = value;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int value) {
        this.totalQuantity = value;
    }

    public BigDecimal getTotalImportCost() {
        return totalImportCost;
    }

    public void setTotalImportCost(BigDecimal value) {
        this.totalImportCost = value;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp value) {
        this.startDate = value;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp value) {
        this.endDate = value;
    }

}
