package services;

import java.sql.Connection;
import java.util.List;

import dao.VehicleDao;
import models.Vehicle;

public class VehicleService {
    private VehicleDao vehicleDao;

    public VehicleService(Connection connection) {
        this.vehicleDao = new VehicleDao(connection);
    }

    public List<Vehicle> getAllVehicles() {
        return vehicleDao.getAllVehicles();
    }

    public Vehicle getVehicleById(int vehicleId) {
        return vehicleDao.getVehicleById(vehicleId);
    }

    public boolean addVehicle(Vehicle vehicle) {
        return vehicleDao.addVehicle(vehicle);
    }

    public boolean updateVehicle(Vehicle vehicle) {
        return vehicleDao.updateVehicle(vehicle);
    }

    public boolean deleteVehicle(int vehicleId) {
        return vehicleDao.deleteVehicle(vehicleId);
    }
}
