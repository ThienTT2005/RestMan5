package model5;

public class MembershipCard5 {

    private long id;

    private String code;

    private String status;

    private java.sql.Timestamp createDate;

    private Customer5 customer;

    private int pointsBalance;

    private int totalPointsEarned;

    private int totalPointsUsed;

    public long getId() {
        return id;
    }

    public void setId(long value) {
        this.id = value;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String value) {
        this.code = value;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String value) {
        this.status = value;
    }

    public java.sql.Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(java.sql.Timestamp value) {
        this.createDate = value;
    }

    public Customer5 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer5 value) {
        this.customer = value;
    }

    public int getPointsBalance() {
        return pointsBalance;
    }

    public void setPointsBalance(int value) {
        this.pointsBalance = value;
    }

    public int getTotalPointsEarned() {
        return totalPointsEarned;
    }

    public void setTotalPointsEarned(int value) {
        this.totalPointsEarned = value;
    }

    public int getTotalPointsUsed() {
        return totalPointsUsed;
    }

    public void setTotalPointsUsed(int value) {
        this.totalPointsUsed = value;
    }
}
