package com.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Vehicle;
import services.VehicleService;

public class VehicleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private Connection getConnection() throws SQLException {
        Connection connection;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        try {
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/vehiclle_rental_db", "root", "");
            return connection;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection connection = getConnection()) {
            VehicleService vehicleService = new VehicleService(connection);

            String action = request.getParameter("action");

            if ("edit".equals(action)) {
                int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                Vehicle vehicle = vehicleService.getVehicleById(vehicleId);
                request.setAttribute("vehicle", vehicle);
                request.getRequestDispatcher("editVehicle.jsp").forward(request, response);
            }
            else if ("delete".equals(action)) {
                int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                vehicleService.deleteVehicle(vehicleId);
                response.sendRedirect(request.getContextPath() + "/vehicles");
                }
            else {
                List<Vehicle> vehicles = vehicleService.getAllVehicles();
                request.setAttribute("vehicles", vehicles);
                request.getRequestDispatcher("vehicleList.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception as needed
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection connection = getConnection()) {
            VehicleService vehicleService = new VehicleService(connection);

            String action = request.getParameter("action");

            if ("create".equals(action)) {
                String model = request.getParameter("model");
                String make = request.getParameter("make");
                boolean availability = Boolean.parseBoolean(request.getParameter("availability"));

                Vehicle newVehicle = new Vehicle(0, model, make, availability);
                vehicleService.addVehicle(newVehicle);
            } else if ("update".equals(action)) {
                int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                String model = request.getParameter("model");
                String make = request.getParameter("make");
                boolean availability = Boolean.parseBoolean(request.getParameter("availability"));

                Vehicle updatedVehicle = new Vehicle(vehicleId, model, make, availability);
                vehicleService.updateVehicle(updatedVehicle);
            } else if ("delete".equals(action)) {
                int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                vehicleService.deleteVehicle(vehicleId);
            }

            response.sendRedirect(request.getContextPath() + "/vehicles");
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception as needed
        }
    }
}
