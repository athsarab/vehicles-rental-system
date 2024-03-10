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
import models.Driver;
import services.DriverService;

public class DriverServlet extends HttpServlet {
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
            DriverService driverService = new DriverService(connection);

            String action = request.getParameter("action");

            if ("edit".equals(action)) {
                int driverId = Integer.parseInt(request.getParameter("driverId"));
                Driver driver = driverService.getDriverById(driverId);
                request.setAttribute("driver", driver);
                request.getRequestDispatcher("editDriver.jsp").forward(request, response);
            } 
            else if ("delete".equals(action)) {
            	System.out.println("delete");
                int vehicleId = Integer.parseInt(request.getParameter("driverId"));
                driverService.deleteDriver(vehicleId);
                response.sendRedirect(request.getContextPath() + "/drivers");
                }
            
            else {
                List<Driver> drivers = driverService.getAllDrivers();
                request.setAttribute("drivers", drivers);
                request.getRequestDispatcher("driverList.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
       
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection connection = getConnection()) {
            DriverService driverService = new DriverService(connection);

            String action = request.getParameter("action");

            if ("create".equals(action)) {
                String name = request.getParameter("name");
                String licenseNumber = request.getParameter("licenseNumber");

                Driver newDriver = new Driver(0, name, licenseNumber);
                driverService.addDriver(newDriver);
            } else if ("update".equals(action)) {
                int driverId = Integer.parseInt(request.getParameter("driverId"));
                String name = request.getParameter("name");
                String licenseNumber = request.getParameter("licenseNumber");

                Driver updatedDriver = new Driver(driverId, name, licenseNumber);
                driverService.updateDriver(updatedDriver);
            } else if ("delete".equals(action)) {
                int driverId = Integer.parseInt(request.getParameter("driverId"));
                driverService.deleteDriver(driverId);
            }

            response.sendRedirect(request.getContextPath() + "/drivers");
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception as needed
        }
    }
}
