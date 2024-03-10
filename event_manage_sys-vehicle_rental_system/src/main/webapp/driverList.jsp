<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Driver" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Driver List</title>
    <!-- Include Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          crossorigin="anonymous">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <h2>Driver List</h2>
                <!-- Display the list of drivers -->
                <table class="table">
                    <thead>
                        <tr>
                            <th>Driver ID</th>
                            <th>Name</th>
                            <th>License Number</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            List<Driver> drivers = (List<Driver>) request.getAttribute("drivers");
                            if (drivers != null) {
                                for (Driver driver : drivers) { %>
                                    <tr>
                                        <td><%= driver.getDriverId() %></td>
                                        <td><%= driver.getName() %></td>
                                        <td><%= driver.getLicenseNumber() %></td>
                                        <td>
                                            <!-- Edit button with data-driver-id attribute -->
                                            <a href="<%= request.getContextPath() %>/drivers?action=edit&driverId=<%=driver.getDriverId()%>"
                                                class="btn btn-primary editDriverLink"
                                                data-driver-id="<%= driver.getDriverId()%>">Edit</a>
                                            <!-- Delete button with data-driver-id attribute -->
                                            <a href="#" class="btn btn-danger deleteDriverLink"
                                                data-driver-id="<%= driver.getDriverId()%>"
                                                data-toggle="modal"
                                                data-target="#deleteConfirmationModal">Delete</a>
                                        </td>
                                    </tr>
                        <%} } %>
                    </tbody>
                </table>
                <!-- Add new driver form -->
               <h2>Add New Driver</h2>
                <form action="<%= request.getContextPath() %>/drivers" method="post" id="driverForm">
                    <input type="hidden" name="action" id="formAction" value="create">
                    <input type="hidden" name="driverId" id="driverId">
                    
                    <div class="form-group">
                        <label for="name">Name:</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="licenseNumber">License Number:</label>
                        <input type="text" class="form-control" id="licenseNumber" name="licenseNumber" required>
                    </div>
                    
                    <button type="submit" class="btn btn-success">Add Driver</button>
                </form>

            </div>
        </div>
    </div>

    <!-- Delete confirmation modal -->
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
                    Are you sure you want to delete this driver?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                    
                    <a href="#" class="btn btn-danger" id="deleteDriverLink">Delete</a>
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
            // Delete Driver link click handler
            $('.deleteDriverLink').click(function () {
                var driverId = $(this).data('driver-id');
                
                $('#deleteDriverLink').attr('href', '<%= request.getContextPath() %>/drivers?action=delete&driverId=' + driverId);
                // Show the delete confirmation modal
                $('#deleteConfirmationModal').modal('show');
            });

            // Delete confirmation modal "Delete" button click handler
            $('#deleteDriverLink').click(function () {
                var deleteUrl = $(this).attr('href');

                // Make an AJAX request to the servlet to delete the driver
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
                        console.error('Failed to delete driver. Error: ' + error);
                    }
                });
            });
        });
    </script>
</body>
</html>
