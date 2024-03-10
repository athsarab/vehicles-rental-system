CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE drivers (
    driver_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    license_number VARCHAR(255) NOT NULL
);


CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY AUTO_INCREMENT,
    model VARCHAR(255) NOT NULL,
    make VARCHAR(255) NOT NULL,
    availability BOOLEAN NOT NULL
);
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    vehicle_id INT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

INSERT INTO users (username, password, full_name, email, role)
VALUES ('admin', 'adminpassword', 'Admin User', 'admin@example.com', 'admin');


