package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Driver;

public class DriverService {
    private Connection connection;

    public DriverService(Connection connection) {
        this.connection = connection;
    }

    public List<Driver> getAllDrivers() {
        List<Driver> drivers = new ArrayList<>();
        String sql = "SELECT * FROM drivers";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                int driverId = resultSet.getInt("driver_id");
                String name = resultSet.getString("name");
                String licenseNumber = resultSet.getString("license_number");

                Driver driver = new Driver(driverId, name, licenseNumber);
                drivers.add(driver);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return drivers;
    }

    public Driver getDriverById(int driverId) {
        String sql = "SELECT * FROM drivers WHERE driver_id = ?";
        Driver driver = null;

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, driverId);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String name = resultSet.getString("name");
                String licenseNumber = resultSet.getString("license_number");

                driver = new Driver(driverId, name, licenseNumber);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return driver;
    }

    public void addDriver(Driver driver) {
        String sql = "INSERT INTO drivers (name, license_number) VALUES (?, ?)";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, driver.getName());
            preparedStatement.setString(2, driver.getLicenseNumber());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateDriver(Driver driver) {
        String sql = "UPDATE drivers SET name = ?, license_number = ? WHERE driver_id = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, driver.getName());
            preparedStatement.setString(2, driver.getLicenseNumber());
            preparedStatement.setInt(3, driver.getDriverId());

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteDriver(int driverId) {
        String sql = "DELETE FROM drivers WHERE driver_id = ?";

        try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, driverId);

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
