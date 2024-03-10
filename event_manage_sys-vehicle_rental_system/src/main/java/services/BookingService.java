package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Booking;

public class BookingService {
    private Connection connection;

    public BookingService(Connection connection) {
        this.connection = connection;
    }

    public List<Booking> getAllBookings() throws SQLException {
        List<Booking> bookings = new ArrayList<>();

        try (PreparedStatement statement = connection.prepareStatement("SELECT * FROM bookings")) {
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int bookingId = resultSet.getInt("booking_id");
                int userId = resultSet.getInt("user_id");
                int vehicleId = resultSet.getInt("vehicle_id");
                java.sql.Date startDateSql = resultSet.getDate("start_date");
                java.sql.Date endDateSql = resultSet.getDate("end_date");

                Booking booking = new Booking(bookingId, userId, vehicleId, startDateSql, endDateSql);
                bookings.add(booking);
            }
        }

        return bookings;
    }

    public Booking getBookingById(int bookingId) throws SQLException {
        Booking booking = null;

        try (PreparedStatement statement = connection.prepareStatement("SELECT * FROM bookings WHERE booking_id = ?")) {
            statement.setInt(1, bookingId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                int userId = resultSet.getInt("user_id");
                int vehicleId = resultSet.getInt("vehicle_id");
                java.sql.Date startDateSql = resultSet.getDate("start_date");
                java.sql.Date endDateSql = resultSet.getDate("end_date");

                booking = new Booking(bookingId, userId, vehicleId, startDateSql, endDateSql);
            }
        }

        return booking;
    }

    public void addBooking(Booking booking) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(
                "INSERT INTO bookings (user_id, vehicle_id, start_date, end_date) VALUES (?, ?, ?, ?)")) {
            statement.setInt(1, booking.getUserId());
            statement.setInt(2, booking.getVehicleId());
            statement.setDate(3, new java.sql.Date(booking.getStartDate().getTime()));
            statement.setDate(4, new java.sql.Date(booking.getEndDate().getTime()));
            statement.executeUpdate();
        }
    }

    public void updateBooking(Booking booking) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement(
                "UPDATE bookings SET user_id = ?, vehicle_id = ?, start_date = ?, end_date = ? WHERE booking_id = ?")) {
            statement.setInt(1, booking.getUserId());
            statement.setInt(2, booking.getVehicleId());
            statement.setDate(3, new java.sql.Date(booking.getStartDate().getTime()));
            statement.setDate(4, new java.sql.Date(booking.getEndDate().getTime()));
            statement.setInt(5, booking.getBookingId());
            statement.executeUpdate();
        }
    }

    public void deleteBooking(int bookingId) throws SQLException {
        try (PreparedStatement statement = connection.prepareStatement("DELETE FROM bookings WHERE booking_id = ?")) {
            statement.setInt(1, bookingId);
            statement.executeUpdate();
        }
    }
}
