package com.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.catalina.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Booking;
import models.Vehicle;
import models.UserModel;
import services.BookingService;
import services.VehicleService;
import services.UserService;
public class BookingServlet extends HttpServlet {
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
            BookingService bookingService = new BookingService(connection);
            UserService userService =new UserService();
            VehicleService vehicleService =new VehicleService(connection);
            String action = request.getParameter("action");

            if ("edit".equals(action)) {
            	System.out.println("edi caled");
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                Booking booking = bookingService.getBookingById(bookingId);
                booking.setBookingId(bookingId);
                List<UserModel> users = userService.getAllUsers();
                List<Vehicle> vehicles = vehicleService.getAllVehicles();
                System.out.println("there are users and vehicles" + users.size() + "  " + vehicles.size());
                request.setAttribute("booking", booking);
                request.setAttribute("users", users);
                request.setAttribute("vehicles", vehicles);
                request.getRequestDispatcher("editBooking.jsp").forward(request, response);
            } 
            
            else if ("delete".equals(action)) {
            	System.out.println("delete");
                int vehicleId = Integer.parseInt(request.getParameter("bookingId"));
                bookingService.deleteBooking(vehicleId);
                response.sendRedirect(request.getContextPath() + "/bookings");
                }
            else {
                List<Booking> bookings = bookingService.getAllBookings();
                
                List<UserModel> users = userService.getAllUsers();
                List<Vehicle> vehicles = vehicleService.getAllVehicles();
                System.out.println("there are users and vehicles" + users.size() + "  " + vehicles.size());
         
                request.setAttribute("users", users);
                request.setAttribute("vehicles", vehicles);
                request.setAttribute("bookings", bookings);
                request.getRequestDispatcher("bookingList.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception as needed
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection connection = getConnection()) {
            BookingService bookingService = new BookingService(connection);

            String action = request.getParameter("action");

            if ("create".equals(action)) {
                int userId = Integer.parseInt(request.getParameter("userId"));
                int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                String startDateString = request.getParameter("startDate");
                String endDateString = request.getParameter("endDate");

                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date startDate = dateFormat.parse(startDateString);
                Date endDate = dateFormat.parse(endDateString);

                Booking newBooking = new Booking(0, userId, vehicleId, startDate, endDate);
                bookingService.addBooking(newBooking);
            } else if ("update".equals(action)) {
            	System.out.println("booking id" + request.getParameter("bookingId"));
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                int userId = Integer.parseInt(request.getParameter("userId"));
                int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
                String startDateString = request.getParameter("startDate");
                String endDateString = request.getParameter("endDate");

                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date startDate = dateFormat.parse(startDateString);
                Date endDate = dateFormat.parse(endDateString);

                Booking updatedBooking = new Booking(bookingId, userId, vehicleId, startDate, endDate);
                bookingService.updateBooking(updatedBooking);
            } else if ("delete".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("bookingId"));
                bookingService.deleteBooking(bookingId);
            }

            response.sendRedirect(request.getContextPath() + "/bookings");
        } catch (SQLException | ParseException e) {
            e.printStackTrace();
            // Handle the exception as needed
        }
    }
}
