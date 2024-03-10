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
                                            <a href="<%= request.getContextPath() %>/vehicles?action=edit&vehicleId=<%=vehicle.getVehicleId()%>" class="btn btn-primary editVehicleLink" data-vehicle-id="<%= vehicle.getVehicleId()%>">Edit</a>
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
        
        <div class="modal fade" id="deleteConfirmationModal" tabindex="-1" role="dialog" aria-labelledby="deleteConfirmationModalLabel" aria-hidden="true">
		    <div class="modal-dialog" role="document">
		        <div class="modal-content">
		            <div class="modal-header">
		                <h5 class="modal-title" id="deleteConfirmationModalLabel">Confirm Delete</h5>
		                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		                    <span aria-hidden="true">&times;</span>
		                </button>
		            </div>
		            <div class="modal-body">
		                Are you sure you want to delete this vehicle?
		            </div>
		            <div class="modal-footer">
		                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
		                <a href="#" id="deleteVehicleLink" class="btn btn-danger">Delete</a>
		            </div>
		        </div>
		    </div>
		</div>
    </div>

    <!-- Include Bootstrap JS and Popper.js -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>


	

    <script>
        $(document).ready(function() {
            // Edit Vehicle link click handler
           $('.deleteVehicleLink').click(function() {
                var vehicleId = $(this).data('vehicle-id');
                // Set the delete link in the modal to include the vehicleId
                $('#deleteVehicleLink').attr('href', '<%= request.getContextPath() %>/vehicles?action=delete&vehicleId=' + vehicleId);
                // Show the delete confirmation modal
                $('#deleteConfirmationModal').modal('show');
            });
            
            $('#deleteVehicleLink').click(function(){
            	 var deleteUrl = $(this).attr('href');
                 
                
                 $.ajax({
                     url: deleteUrl,
                     type: 'GET',
                     success: function(data) {
                         // Handle success, if needed
                         console.log('Vehicle deleted successfully.');
                        
                         location.reload();
                     },
                     error: function(error) {
                         // Handle errors, if needed
                         console.error('Error deleting vehicle:', error);
                     }
                 });

                 // Hide the modal after making the request
                 $('#deleteConfirmationModal').modal('hide');

                 // Prevent the default link behavior
                 return false;
             });

           
         });
     </script>
</body>
</html>
