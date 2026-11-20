package model5;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;


public class Reservation5 {

    private long id;
    private Timestamp arrivalTime;
    private Timestamp bookingTime;
    private int numberOfGuests;
    private String note;
    private Timestamp confirmationTime;
    private String reason;
    private Customer5 customer;
    private List<ReservationDetail5> details = new ArrayList<>();
    private String status;

    public long getId() {
        return id;
    }

    public void setId(long value) {
        this.id = value;
    }

    public Timestamp getArrivalTime() {
        return arrivalTime;
    }

    public void setArrivalTime(Timestamp value) {
        this.arrivalTime = value;
    }

    public Timestamp getBookingTime() {
        return bookingTime;
    }

    public void setBookingTime(Timestamp value) {
        this.bookingTime = value;
    }

    public int getNumberOfGuests() {
        return numberOfGuests;
    }

    public void setNumberOfGuests(int value) {
        this.numberOfGuests = value;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String value) {
        this.note = value;
    }

    public Timestamp getConfirmationTime() {
        return confirmationTime;
    }

    public void setConfirmationTime(Timestamp value) {
        this.confirmationTime = value;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String value) {
        this.reason = value;
    }

    public Customer5 getCustomer() {
        return customer;
    }

    public void setCustomer(Customer5 value) {
        this.customer = value;
    }

    public List<ReservationDetail5> getDetails() {
        return details;
    }

    public void setDetails(List<ReservationDetail5> value) {
        this.details = value;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String value) {
        this.status = value;
    }

}
