package com.controllers;

import java.io.IOException;
import java.util.Map;

import jakarta.servlet.http.*;
import services.UserService;




public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    {
    	  String email = request.getParameter("email");
          String password = request.getParameter("password");
          UserService userService = new UserService();
          Map<String,String> result = userService.login(email,password);
          if(result!=null) {
                   try {
                	   Cookie emailCookie = new Cookie("email", email);
                       emailCookie.setMaxAge(30 * 24 * 60 * 60); 
                       response.addCookie(emailCookie);
                	  
                      
                        response.sendRedirect("AdminHomeView.jsp");
                       
                   } catch (IOException e) {
                       e.printStackTrace();
                   }
  				
  		
          }else {
        	  try {
  				response.getWriter().println("Login failed. Please try again.");
  			} catch (IOException e) {
  				// TODO Auto-generated catch block
  				e.printStackTrace();
  			}
          }
       
    }
}
