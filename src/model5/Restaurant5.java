package model5;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;


public class Restaurant5 {

    private long id;
    private String name;
    private String address;
    private String phone;
    private String email;
    private String description;
    private List<Combo5> combos = new ArrayList<>();
    private List<Dish5> dishes = new ArrayList<>();
    private List<Member5> members = new ArrayList<>();
    private List<Table5> tables = new ArrayList<>();

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

    public String getAddress() {
        return address;
    }

    public void setAddress(String value) {
        this.address = value;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String value) {
        this.phone = value;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String value) {
        this.email = value;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String value) {
        this.description = value;
    }

    public List<Combo5> getCombos() {
        return combos;
    }

    public void setCombos(List<Combo5> value) {
        this.combos = value;
    }

    public List<Dish5> getDishes() {
        return dishes;
    }

    public void setDishes(List<Dish5> value) {
        this.dishes = value;
    }

    public List<Member5> getMembers() {
        return members;
    }

    public void setMembers(List<Member5> value) {
        this.members = value;
    }

    public List<Table5> getTables() {
        return tables;
    }

    public void setTables(List<Table5> value) {
        this.tables = value;
    }

}
