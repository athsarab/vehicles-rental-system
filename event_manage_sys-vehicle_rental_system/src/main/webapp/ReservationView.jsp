<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Vehicle" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Vehicle List</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h2>Vehicle List</h2>
                <!-- Display the list of vehicles -->
                <table class="table">
                    <thead>
                        <tr>
                            <th>Vehicle ID</th>
                            <th>Model</th>
                            <th>Make</th>
                            <th>Availability</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<Vehicle> vehicles = (List<Vehicle>) request.getAttribute("vehicles");
                            if (vehicles != null) {
                                for (Vehicle vehicle : vehicles) { %>
                                    <tr>
                                        <td><%= vehicle.getVehicleId() %></td>
                                        <td><%= vehicle.getModel() %></td>
                                        <td><%= vehicle.getMake()%></td>
                                        <td><%= vehicle.isAvailability() %></td>
                                        <td>
                                            <!-- Edit button with data-vehicle-id attribute -->
                                            <a href="#" class="btn btn-primary editVehicleLink" data-vehicle-id="<%= vehicle.getVehicleId()%>">Edit</a>
                                            <!-- Delete button with data-vehicle-id attribute -->
                                            <a href="#" class="btn btn-danger deleteVehicleLink" data-vehicle-id="<%= vehicle.getVehicleId()%>" data-toggle="modal" data-target="#deleteConfirmationModal">Delete</a>
                                        </td>
                                    </tr>
                        <%} } %>
                    </tbody>
                </table>
                <!-- Add new vehicle form -->
                <h2>Add New Vehicle</h2>
                <form action="<%= request.getContextPath() %>/vehicles" method="post" id="vehicleForm">
                    <input type="hidden" name="action" id="formAction" value="create">
                    <input type="hidden" name="vehicleId" id="vehicleId">
                    <div class="form-group">
                        <label for="model">Model:</label>
                        <input type="text" class="form-control" id="model" name="model" required>
                    </div>
                    <div class="form-group">
                        <label for="make">Make:</label>
                        <input type="text" class="form-control" id="make" name="make" required>
                    </div>
                    <div class="form-group">
                        <label for="availability">Availability:</label>
                        <input type="checkbox" class="form-check-input" id="availability" name="availability" value="true">
                    </div>
                    <button type="submit" class="btn btn-success">Add Vehicle</button>
                </form>
            </div>
        </div>
    </div>

    <!-- Include Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <script>
        $(document).ready(function() {

            $('.deleteVehicleLink').click(function() {
                var vehicleId = $(this).data('vehicle-id');
                // Set the delete link in the modal to include the vehicleId
                $('#deleteVehicleLink').attr('href', '<%= request.getContextPath() %>/vehicles?action=delete&vehicleId=' + vehicleId);
                // Show the delete confirmation modal
                $('#deleteConfirmationModal').modal('show');
            });
            // Edit Vehicle link click handler
            $('.editVehicleLink').click(function() {
                var vehicleId = $(this).data('vehicle-id');
                // Load vehicle data using AJAX and populate the form
                loadEditVehicleData(vehicleId);
            });

            function loadEditVehicleData(vehicleId) {
                // Make an AJAX request to fetch data for the selected vehicle
                fetch('<%= request.getContextPath() %>/vehicles?action=edit&id=' + vehicleId, {
                        method: 'GET',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                    })
                    .then(response => response.json())
                    .then(data => {
                        // Populate the fields in the edit form with the fetched data
                        $('#formAction').val('update');
                        $('#vehicleId').val(data.vehicleId);
                        $('#model').val(data.model);
                        $('#make').val(data.make);
                        $('#availability').prop('checked', data.availability);

                        // Change the form action to update
                        $('#vehicleForm').attr('action', '<%= request.getContextPath() %>/vehicles?action=update');

                        // Scroll to the form
                        $('html, body').animate({
                            scrollTop: $("#vehicleForm").offset().top
                        }, 500);
                    })
                    .catch(error => {
                        // Handle errors
                        console.error('Failed to fetch data for vehicle ID: ' + vehicleId);
                    });
            }

            // Client-side validation for Add/Update Vehicle Form
            $('#vehicleForm').submit(function(event) {
                var isValid = true;
                // Example: Add validation logic for each field
                if ($('#model').val().trim() === '') {
                    alert('Model is required.');
                    isValid = false;
                }
                // Add other validation rules as needed

                if (!isValid) {
                    event.preventDefault(); // Prevent form submission
                }
            });
        });
    </script>
</body>
</html>
