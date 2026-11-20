package model5;

public class Bill5 {

    private long id;

    private java.sql.Timestamp paymentTime;

    private java.math.BigDecimal totalAmount;

    private java.math.BigDecimal discountAmount;

    private java.math.BigDecimal finalAmount;

    private Order5 order;

    private Customer5 customer;

    private Staff5 staff;

    private MembershipCard5 card;

    private int pointsUsed;

    private int pointsEarned;

    public long getId() {
        return id;
    }

    public void setId(long value) {
        this.id = value;
    }

    public java.sql.Timestamp getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(java.sql.Timestamp value) {
        this.paymentTime = value;
    }

    public java.math.BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(java.math.BigDecimal value) {
        this.totalAmount = value;
    }

    public java.math.BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(java.math.BigDecimal value) {
        this.discountAmount = value;
    }

    public java.math.BigDecimal getFinalAmount() {
        return finalAmount;
    }

    public void setFinalAmount(java.math.BigDecimal value) {
        this.finalAmount = value;
    }

    public Order5 getOrder() {
        return order;
    }

    public void setOrder(Order5 value) {
        this.order = value;
    }

    public Customer5 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer5 value) {
        this.customer = value;
    }

    public Staff5 getStaff() {
        return staff;
    }

    public void setStaff(Staff5 value) {
        this.staff = value;
    }

    public MembershipCard5 getCard() {
        return card;
    }

    public void setCard(MembershipCard5 value) {
        this.card = value;
    }

    public int getPointsUsed() {
        return pointsUsed;
    }

    public void setPointsUsed(int value) {
        this.pointsUsed = value;
    }

    public int getPointsEarned() {
        return pointsEarned;
    }

    public void setPointsEarned(int value) {
        this.pointsEarned = value;
    }
}
