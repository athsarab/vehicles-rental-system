package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Reservation;

public class ReservationDAO {
    private Connection connection;

    public ReservationDAO() {
        // Initialize your database connection (Assuming you have a ConnectionManager class)
        try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
       try {
		this.connection  = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/event_plan_db","root","");
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    }

    public List<Reservation> getAllReservations() {
        // Retrieve all reservations from the database
        List<Reservation> reservations = new ArrayList<>();

        try (PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM reservations");
                ResultSet resultSet = preparedStatement.executeQuery()) {
            while (resultSet.next()) {
                Reservation reservation = mapResultSetToReservation(resultSet);
                reservations.add(reservation);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return reservations;
    }
    

    public Reservation getReservationById(int reservationId) {
        // Retrieve a reservation by ID from the database
        try (PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM reservations WHERE reservationId = ?")) {
            preparedStatement.setInt(1, reservationId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return mapResultSetToReservation(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean addReservation(Reservation reservation) {
        // Add a new reservation to the database
        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "INSERT INTO reservations (reservationDate, userName, userEmail, reservationItemId, reservedItemName) VALUES (?, ?, ?, ?, ?)")) {
            preparedStatement.setDate(1, new java.sql.Date(reservation.getReservationDate().getTime()));
            preparedStatement.setString(2, reservation.getUserName());
            preparedStatement.setString(3, reservation.getUserEmail());
            preparedStatement.setInt(4, reservation.getReservationItemId());
            preparedStatement.setString(5, reservation.getReservedItemName());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateReservation(Reservation reservation) {
        // Update an existing reservation in the database
        try (PreparedStatement preparedStatement = connection.prepareStatement(
                "UPDATE reservations SET userName = ?, userEmail = ?, reservationItemId = ?, reservedItemName = ? WHERE userEmail = ?")) {
        	
        
            preparedStatement.setString(1, reservation.getUserName());
            preparedStatement.setString(2, reservation.getUserEmail());
            preparedStatement.setInt(3, reservation.getReservationItemId());
            preparedStatement.setString(4, reservation.getReservedItemName());
            preparedStatement.setString(5, reservation.getUserEmail());

            int rowsAffected = preparedStatement.executeUpdate();
            System.out.println("update state " + rowsAffected);
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteReservation(int reservationId) {
        // Delete a reservation from the database
        try (PreparedStatement preparedStatement = connection.prepareStatement("DELETE FROM reservations WHERE reservationId = ?")) {
            preparedStatement.setInt(1, reservationId);

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper method to map ResultSet to Reservation object
    private Reservation mapResultSetToReservation(ResultSet resultSet) throws SQLException {
        Reservation reservation = new Reservation();
        reservation.setReservationId(resultSet.getInt("reservationId"));
        reservation.setReservationDate(resultSet.getDate("reservationDate"));
        reservation.setUserName(resultSet.getString("userName"));
        reservation.setUserEmail(resultSet.getString("userEmail"));
        reservation.setReservationItemId(resultSet.getInt("reservationItemId"));
        reservation.setReservedItemName(resultSet.getString("reservedItemName"));
        return reservation;
    }
}
