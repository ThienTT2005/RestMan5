package model5;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;


public class ReservationDetail5 {

    private long id;
    private Table5 table;

    public long getId() {
        return id;
    }

    public void setId(long value) {
        this.id = value;
    }

    public Table5 getTable() {
        return table;
    }

    public void setTable(Table5 value) {
        this.table = value;
    }

}
