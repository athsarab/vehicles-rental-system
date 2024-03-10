package models;

public class Driver {
    private int driverId;
    private String name;
    private String licenseNumber;

    // Default constructor
    public Driver() {}

    // Parameterized constructor
    public Driver(int driverId, String name, String licenseNumber) {
        this.driverId = driverId;
        this.name = name;
        this.licenseNumber = licenseNumber;
    }

    // Getters and setters
    public int getDriverId() {
        return driverId;
    }

    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLicenseNumber() {
        return licenseNumber;
    }

    public void setLicenseNumber(String licenseNumber) {
        this.licenseNumber = licenseNumber;
    }
}
