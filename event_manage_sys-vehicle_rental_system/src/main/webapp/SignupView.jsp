<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Signup Page</title>
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
        <div class="col-md-6">
          <div class="card">
            <div class="card-header bg-success text-white">
              <h4 class="mb-0">Sign up</h4>
            </div>
            <div class="card-body">
              <!-- Your signup form goes here -->
              <form action="SignupServlet" method="post">
                <div class="form-group">
                  <label for="fullName">Full Name:</label>
                  <input
                    type="text"
                    class="form-control"
                    id="fullName"
                    name="fullName"
                    required
                  />
                </div>
                <div class="form-group">
                  <label for="username">Username:</label>
                  <input
                    type="text"
                    class="form-control"
                    id="username"
                    name="username"
                    required
                  />
                </div>
                <div class="form-group">
                  <label for="email">Email:</label>
                  <input
                    type="email"
                    class="form-control"
                    id="email"
                    name="email"
                    required
                  />
                </div>
                <div class="form-group">
                  <label for="password">Password:</label>
                  <input
                    type="password"
                    class="form-control"
                    id="password"
                    name="password"
                    required
                  />
                </div>
                <button type="submit" class="btn btn-success">Sign up</button>
              </form>
            </div>
            <div class="card-footer text-center">
              <p class="mb-0">
                Already have an account? <a href="LoginView.jsp">Login here</a>
              </p>
            </div>
          </div>
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
