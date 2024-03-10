package com.controllers;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.UserModel;
import services.UserService;

public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
        String username = request.getParameter("username"); 
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

  
        UserModel user = new UserModel();
        user.setUsername(username);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);

      
        UserService userService = new UserService();
        boolean signupSuccess = userService.createUser(user);

        if (signupSuccess) {
          
            response.sendRedirect("LoginView.jsp");
        } else {
            
            response.getWriter().println("Signup failed. Please try again.");
        }
    }
}
