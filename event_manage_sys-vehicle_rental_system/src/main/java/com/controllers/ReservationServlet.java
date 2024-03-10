package com.controllers;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.*;

import models.Reservation;
import services.ReservationService;

public class ReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public List<Reservation> reservations;
    private ReservationService reservationService = new ReservationService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
               
                reservations = reservationService.getAllReservations();
                System.out.println("reservation length " + reservations.size());
                request.setAttribute("reservations", reservations);
                try {
					request.getRequestDispatcher("ReservationView.jsp").forward(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
            } else if (action.equals("create")) {
                // Show form to create a new reservation
                request.getRequestDispatcher("createReservation.jsp").forward(request, response);
            } else if (action.equals("edit")) {
            	   int reservationId = Integer.parseInt(request.getParameter("id"));
            	  
                   Reservation reservation = reservationService.getReservationById(reservationId);

                   Map<String, Object> reservationData = new HashMap<>();
                   reservationData.put("userName", reservation.getUserName());
                   reservationData.put("userEmail", reservation.getUserEmail());
                   reservationData.put("reservationDate", reservation.getReservationDate().toString());
                   reservationData.put("reservationItemId", reservation.getReservationItemId());
                   reservationData.put("reservedItemName", reservation.getReservedItemName());

                   // Convert Map to JSON using simple string concatenation (you may want to use a library for this in production)
                   String json = "{";
                   for (Map.Entry<String, Object> entry : reservationData.entrySet()) {
                       json += "\"" + entry.getKey() + "\":\"" + entry.getValue() + "\",";
                   }
                   json = json.substring(0, json.length() - 1) + "}"; // Remove the trailing comma and add the closing brace

                   // Write JSON response
                   response.setContentType("application/json");
                   response.setCharacterEncoding("UTF-8");
                   response.getWriter().write(json);
            } else if (action.equals("delete")) {
                // Delete an existing reservation
                int reservationId = Integer.parseInt(request.getParameter("id"));
                boolean success = reservationService.deleteReservation(reservationId);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/reservation");
                } else {
                    response.getWriter().println("Failed to delete reservation. Please try again.");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred. Please try again.");
        } catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        String id = request.getParameter("id");
        try {
            if (action.equals("create")) {
                // Create a new reservation
                Reservation reservation = createReservationFromRequest(request);
                
                boolean success = reservationService.addReservation(reservation);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/reservation");
                } else {
                    response.getWriter().println("Failed to create reservation. Please try again.");
                }
            } else if (action.equals("update")) {
                // Update an existing reservation
                Reservation reservation = createReservationFromRequest(request);
                
                boolean success = reservationService.updateReservation(reservation);

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/reservation");
                } else {
                    response.getWriter().println("Failed to update reservation. Please try again.");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            response.getWriter().println("An error occurred. Please try again.");
        }
    }

    // Helper method to create a Reservation object from the request parameters
    private Reservation createReservationFromRequest(HttpServletRequest request) {
        Reservation reservation = new Reservation();

        // Assuming your Reservation class has setters for all these fields
        reservation.setUserName(request.getParameter("userName"));
        reservation.setUserEmail(request.getParameter("userEmail"));

        // Convert the date string to java.util.Date
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date reservationDate = dateFormat.parse(request.getParameter("reservationDate"));
            reservation.setReservationDate(reservationDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // Convert other fields accordingly
        reservation.setReservationItemId(Integer.parseInt(request.getParameter("reservationItemId")));
        reservation.setReservedItemName(request.getParameter("reservedItemName"));

        return reservation;
    }

}
