<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ page import="models.Booking" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Edit Booking</title>
    <!-- Include Bootstrap CSS -->
    <link
      href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
      crossorigin="anonymous"
    />
  </head>
  <body class="bg-light">
    <div class="container mt-5">
      <div class="row justify-content-center">
        <div class="col-md-8">
          <h2>Edit Booking</h2>
          <!-- Edit booking form -->
          <% Booking booking = (Booking) request.getAttribute("booking");
          if(booking!=null){ %>
          <form action="<%= request.getContextPath() %>/bookings" method="post">
            <input type="hidden" name="action" value="update" />
            <input
              type="hidden"
              name="bookingId"
              value="<%= booking.getBookingId() %>"
            />
            <div class="form-group">
              <label for="userId">User ID:</label>
              <input
                type="text"
                class="form-control"
                id="userId"
                name="userId"
                value="<%= booking.getUserId() %>"
                required
              />
            </div>
            <div class="form-group">
              <label for="vehicleId">Vehicle ID:</label>
              <input
                type="text"
                class="form-control"
                id="vehicleId"
                name="vehicleId"
                value="<%= booking.getVehicleId() %>"
                required
              />
            </div>
            <div class="form-group">
              <label for="startDate">Start Date:</label>
              <input
                type="text"
                class="form-control"
                id="startDate"
                name="startDate"
                value="<%= booking.getStartDate() %>"
                required
              />
            </div>
            <div class="form-group">
              <label for="endDate">End Date:</label>
              <input
                type="text"
                class="form-control"
                id="endDate"
                name="endDate"
                value="<%= booking.getEndDate() %>"
                required
              />
            </div>
            <button type="submit" class="btn btn-primary">Save Changes</button>
          </form>
          <% } %>
        </div>
      </div>
    </div>

    <!-- Include Bootstrap JS and Popper.js -->
    <script
      src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
      integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
      integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
      integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
      crossorigin="anonymous"
    ></script>
  </body>
</html>
