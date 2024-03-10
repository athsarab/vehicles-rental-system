<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="models.*" %>
        <%@ page import="java.util.List" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Booking List</title>
                <!-- Include Bootstrap CSS -->
                <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"
                    integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
                    crossorigin="anonymous">
            </head>

            <body class="bg-light">
                <div class="container mt-5">
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <h2>Booking List</h2>
                            <!-- Display the list of bookings -->
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>Booking ID</th>
                                        <th>User ID</th>
                                        <th>Vehicle ID</th>
                                        <th>Start Date</th>
                                        <th>End Date</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Booking> bookings = (List<Booking>) request.getAttribute("bookings");
                                            if (bookings != null) {
                                            for (Booking booking : bookings) { %>
                                            <tr>
                                                <td>
                                                    <%= booking.getBookingId() %>
                                                </td>
                                                <td>
                                                    <%= booking.getUserId() %>
                                                </td>
                                                <td>
                                                    <%= booking.getVehicleId() %>
                                                </td>
                                                <td>
                                                    <%= booking.getStartDate() %>
                                                </td>
                                                <td>
                                                    <%= booking.getEndDate() %>
                                                </td>
                                                <td>
                                                    <!-- Edit button with data-booking-id attribute -->
                                                    <a href="<%= request.getContextPath() %>/bookings?action=edit&bookingId=<%=booking.getBookingId()%>"
                                                        class="btn btn-primary editBookingLink"
                                                        data-booking-id="<%= booking.getBookingId()%>">Edit</a>
                                                    <!-- Delete button with data-booking-id attribute -->
                                                    <a href="#" class="btn btn-danger deleteBookingLink"
                                                        data-booking-id="<%= booking.getBookingId()%>"
                                                        data-toggle="modal"
                                                        data-target="#deleteConfirmationModal">Delete</a>
                                                </td>
                                            </tr>
                                            <%} } %>
                                </tbody>
                            </table>
                            <!-- Add new booking form -->
                            <h2>Add New Booking</h2>
                            <form action="<%= request.getContextPath() %>/bookings" method="post" id="bookingForm">
                                <input type="hidden" name="action" id="formAction" value="create">
                                <input type="hidden" name="bookingId" id="bookingId">
                                <div class="form-group">
                                    <label for="userId">User ID:</label>
                                    <select class="form-control" id="userId" name="userId" required>
                                        <option value="" selected disabled>Select User</option>
                                        <% List<UserModel> users = (List<UserModel>) request.getAttribute("users");
                                                if (users != null) {
                                                for (UserModel user : users) { %>
                                                <option value="<%= user.getUserId() %>">
                                                    <%= user.getUsername() %>
                                                </option>
                                                <% } } %>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="vehicleId">Vehicle ID:</label>
                                    <select class="form-control" id="vehicleId" name="vehicleId" required>
                                        <option value="" selected disabled>Select Vehicle</option>
                                        <% List<Vehicle> vehicles = (List<Vehicle>) request.getAttribute("vehicles");
                                                if (vehicles != null) {
                                                for (Vehicle vehicle : vehicles) { %>
                                                <option value="<%= vehicle.getVehicleId() %>">
                                                    <%= vehicle.getModel() %>
                                                </option>
                                                <% } } %>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="startDate">Start Date:</label>
                                    <input type="text" class="form-control" id="startDate" name="startDate"
                                        placeholder="YYYY-MM-DD" required>
                                </div>
                                <div class="form-group">
                                    <label for="endDate">End Date:</label>
                                    <input type="text" class="form-control" id="endDate" name="endDate"
                                        placeholder="YYYY-MM-DD" required>
                                </div>
                                <button type="submit" class="btn btn-success">Add Booking</button>
                            </form>
                        </div>
                    </div>
                </div>
                
                <div class="modal fade" id="deleteConfirmationModal" tabindex="-1" role="dialog" aria-labelledby="deleteConfirmationModalLabel"
    aria-hidden="true">
			    <div class="modal-dialog" role="document">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h5 class="modal-title" id="deleteConfirmationModalLabel">Delete Confirmation</h5>
			                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			                    <span aria-hidden="true">&times;</span>
			                </button>
			            </div>
			            <div class="modal-body">
			                Are you sure you want to delete this booking?
			            </div>
			            <div class="modal-footer">
			                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
			                <!-- Delete button with id 'deleteBookingLink' -->
			                <a href="#" class="btn btn-danger" id="deleteBookingLink">Delete</a>
			            </div>
			        </div>
			    </div>
			</div>

                <!-- Include Bootstrap JS and Popper.js -->
                <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
                    integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
                    crossorigin="anonymous"></script>
                <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
                    integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
                    crossorigin="anonymous"></script>
                <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
                    integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
                    crossorigin="anonymous"></script>

                <script>
                    $(document).ready(function () {
                        // Edit Booking link click handler
                        $('.editBookingLink').click(function () {
                            var bookingId = $(this).data('booking-id');
                            // Load booking data using AJAX and populate the form
                            loadEditBookingData(bookingId);
                        });

                        function loadEditBookingData(bookingId) {
                            // Make an AJAX request to fetch data for the selected booking
                            fetch('<%= request.getContextPath() %>/bookings?action=edit&bookingId=' + bookingId, {
                                method: 'GET',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                            })
                                .then(response => response.json())
                                .then(data => {
                                    // Populate the fields in the edit form with the fetched data
                                    $('#userId').val(data.userId);
                                    $('#vehicleId').val(data.vehicleId);
                                    $('#startDate').val(data.startDate);
                                    $('#endDate').val(data.endDate);
                                })
                                .catch(error => {
                                    // Handle errors
                                    console.error('Failed to fetch data for booking ID: ' + bookingId);
                                });
                        }

                        // Client-side validation for Add/Update Booking Form
                        $('#bookingForm').submit(function (event) {
                            var isValid = true;
                            // Example: Add validation logic for each field
                            if ($('#userId').val().trim() === '') {
                                alert('User ID is required.');
                                isValid = false;
                            }
                            // Add other validation rules as needed

                            if (!isValid) {
                                event.preventDefault(); // Prevent form submission
                            }
                        });

                        // Delete Booking link click handler
                        $('.deleteBookingLink').click(function () {
                            var bookingId = $(this).data('booking-id');
                            // Set the delete link in the modal to include the bookingId
                            $('#deleteBookingLink').attr('href', '<%= request.getContextPath() %>/bookings?action=delete&bookingId=' + bookingId);
                            // Show the delete confirmation modal
                            $('#deleteConfirmationModal').modal('show');
                        });

                        // Delete confirmation modal "Delete" button click handler
                        $('#deleteBookingLink').click(function () {
                            var deleteUrl = $(this).attr('href');

                            // Make an AJAX request to the servlet to delete the booking
                            $.ajax({
                                url: deleteUrl,
                                type: 'GET',
                                success: function (data) {
                                    // Handle success, if needed
                                    // Reload the page or update the UI
                                    window.location.reload();
                                },
                                error: function (error) {
                                    // Handle error, if needed
                                    console.error('Failed to delete booking. Error: ' + error);
                                }
                            });
                        });
                    });
                </script>
            </body>

            </html>