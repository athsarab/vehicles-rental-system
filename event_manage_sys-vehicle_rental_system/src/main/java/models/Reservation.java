package models;

import java.util.Date;

public class Reservation {
    private int reservationId;
    private Date reservationDate;
    private String userName;
    private String userEmail;
    private int reservationItemId;
    private String reservedItemName;

    public int getReservationId() {
        return reservationId;
    }

    public void setReservationId(int reservationId) {
        this.reservationId = reservationId;
    }

    public Date getReservationDate() {
        return reservationDate;
    }

    public void setReservationDate(Date reservationDate) {
        this.reservationDate = reservationDate;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public int getReservationItemId() {
        return reservationItemId;
    }

    public void setReservationItemId(int reservationItemId) {
        this.reservationItemId = reservationItemId;
    }

    public String getReservedItemName() {
        return reservedItemName;
    }

    public void setReservedItemName(String reservedItemName) {
        this.reservedItemName = reservedItemName;
    }
}
