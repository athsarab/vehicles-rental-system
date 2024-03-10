package models;

public class Vehicle {
    private int vehicleId;
    private String model;
    private String make;
    private boolean availability;

    // Default constructor
    public Vehicle() {}

    // Parameterized constructor
    public Vehicle(int vehicleId, String model, String make, boolean availability) {
        this.vehicleId = vehicleId;
        this.model = model;
        this.make = make;
        this.availability = availability;
    }

    // Getters and setters
    public int getVehicleId() {
        return vehicleId;
    }

    public void setVehicleId(int vehicleId) {
        this.vehicleId = vehicleId;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public String getMake() {
        return make;
    }

    public void setMake(String make) {
        this.make = make;
    }

    public boolean isAvailability() {
        return availability;
    }

    public void setAvailability(boolean availability) {
        this.availability = availability;
    }
}
