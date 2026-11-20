package model5;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;


public class OnlineOrder5 extends Order5 {

    private String status;
    private Reservation5 reservation;

    public String getStatus() {
        return status;
    }

    public void setStatus(String value) {
        this.status = value;
    }

    public Reservation5 getReservation() {
        return reservation;
    }

    public void setReservation(Reservation5 value) {
        this.reservation = value;
    }

}
