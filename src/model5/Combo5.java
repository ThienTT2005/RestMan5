package model5;

public class Combo5 {

    private long id;

    private String name;

    private String description;

    private String image;

    private java.math.BigDecimal price;

    private java.sql.Timestamp startDate;

    private java.sql.Timestamp endDate;

    private java.util.List<ComboDetail5> details = new java.util.ArrayList<>();

    public long getId() {
        return id;
    }

    public void setId(long value) {
        this.id = value;
    }

    public String getName() {
        return name;
    }

    public void setName(String value) {
        this.name = value;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String value) {
        this.description = value;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String value) {
        this.image = value;
    }

    public java.math.BigDecimal getPrice() {
        return price;
    }

    public void setPrice(java.math.BigDecimal value) {
        this.price = value;
    }

    public java.sql.Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(java.sql.Timestamp value) {
        this.startDate = value;
    }

    public java.sql.Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(java.sql.Timestamp value) {
        this.endDate = value;
    }

    public java.util.List<ComboDetail5> getDetails() {
        return details;
    }

    public void setDetails(java.util.List<ComboDetail5> value) {
        this.details = value;
    }
}
