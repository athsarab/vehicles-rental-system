package services;

import java.util.List;

import dao.ReservationDAO;
import models.Reservation;

public class ReservationService {
    private ReservationDAO reservationDAO = new ReservationDAO();

    // Constructor, initialize DAO

    public List<Reservation> getAllReservations() {
        return reservationDAO.getAllReservations();
    }

    public Reservation getReservationById(int reservationId) {
        return reservationDAO.getReservationById(reservationId);
    }

    public boolean addReservation(Reservation reservation) {
        return reservationDAO.addReservation(reservation);
    }

    public boolean updateReservation(Reservation reservation) {
        return reservationDAO.updateReservation(reservation);
    }

    public boolean deleteReservation(int reservationId) {
        return reservationDAO.deleteReservation(reservationId);
    }
}
