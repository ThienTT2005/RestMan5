package model5;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;


public class CustomerStat5 extends Customer5 {

    private int orderCount;
    private BigDecimal totalSpending;
    private LocalDate startDate;
    private LocalDate endDate;

    public int getOrderCount() {
        return orderCount;
    }

    public void setOrderCount(int value) {
        this.orderCount = value;
    }

    public BigDecimal getTotalSpending() {
        return totalSpending;
    }

    public void setTotalSpending(BigDecimal value) {
        this.totalSpending = value;
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
