package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import models.Vehicle;

public class VehicleDao {
    private Connection connection;

    public VehicleDao(Connection connection) {
        this.connection = connection;
    }

    public List<Vehicle> getAllVehicles() {
        List<Vehicle> vehicles = new ArrayList<>();
        String query = "SELECT * FROM vehicles";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int vehicleId = resultSet.getInt("vehicle_id");
                String model = resultSet.getString("model");
                String make = resultSet.getString("make");
                boolean availability = resultSet.getBoolean("availability");

                Vehicle vehicle = new Vehicle(vehicleId, model, make, availability);
                vehicles.add(vehicle);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vehicles;
    }

    public Vehicle getVehicleById(int vehicleId) {
        String query = "SELECT * FROM vehicles WHERE vehicle_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, vehicleId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String model = resultSet.getString("model");
                String make = resultSet.getString("make");
                boolean availability = resultSet.getBoolean("availability");

                return new Vehicle(vehicleId, model, make, availability);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addVehicle(Vehicle vehicle) {
        String query = "INSERT INTO vehicles (model, make, availability) VALUES (?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, vehicle.getModel());
            preparedStatement.setString(2, vehicle.getMake());
            preparedStatement.setBoolean(3, vehicle.isAvailability());

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateVehicle(Vehicle vehicle) {
        String query = "UPDATE vehicles SET model = ?, make = ?, availability = ? WHERE vehicle_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setString(1, vehicle.getModel());
            preparedStatement.setString(2, vehicle.getMake());
            preparedStatement.setBoolean(3, vehicle.isAvailability());
            preparedStatement.setInt(4, vehicle.getVehicleId());

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteVehicle(int vehicleId) {
        String query = "DELETE FROM vehicles WHERE vehicle_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, vehicleId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
