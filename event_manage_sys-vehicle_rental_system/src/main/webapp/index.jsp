<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Home Page</title>
    <!-- CSS -->
    <link rel="stylesheet" href="res/css/index.css" />
	  <!-- Swiper CSS -->
    <link rel="stylesheet" href="swiper-bundle.min.css">
	  
    <!-- Unicons CSS -->
    <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css" />
    <script src="script.js" defer></script>
	 <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
   <script src="script.js" defer></script>
  
  </head>
  <body>
  
 <!--header------------>	
    
	<nav class="nav">
      <i class="uil uil-bars navOpenBtn"></i>
      <a href="#" class="logo">SARA Riders</a>

      <ul class="nav-links">
        <i class="uil uil-times navCloseBtn"></i>
         <li><a href="index.jsp">Home</a></li>
        <li><a href="driver.jsp">Drivers</a></li>
        <li><a href="vehicle.jsp">Vehicles</a></li>
        <li><a href="myReservations.jsp">Packages</a></li>
        <li><a href="aboutus.jsp">About Us</a></li>
      </ul>
  
    <a class="button" href="LoginView.jsp">Login </a>
    
    <a class="button" href="#">Register </a>
	  
    </nav>
	
	
<!--vehicles-------------->
		<div class="wrapper">
      <i id="left" class="fa-solid fa-angle-left"></i>
      <div class="carousel">
        <img src="C:\Users\pc\Downloads\Image\Vehicles\image1.jpg" alt="img" draggable="false">
        <img src="C:\Users\pc\Downloads\Image\Vehicles\image2.jpg" alt="img" draggable="false">
	<img src="C:\Users\pc\Downloads\Image\Vehicles\image4.jpg" alt="img" draggable="false">
        <img src="C:\Users\pc\Downloads\Image\Vehicles\image3.jpg" alt="img" draggable="false">
        
      </div>
      <i id="right" class="fa-solid fa-angle-right"></i>
    </div>
	
	
<!--buttons-------------------------->
    

	<div >
	  <a class="btn" href="index.jsp">Availabilities</a>
	  </div>
	   
	  
	<br>
	<hr>
	

	<br><br>
	<br><br>
<!--footer------------>	
 
 <footer>
   <div class="content">
   <img src="C:\Users\pc\Downloads\Image\logo-black.png" alt="logo"  height="60" width="60">
   
     <div class="left">
     <a href="aboutus.jsp">Contact Us</a>
		 
     </div>
	 
     <div class="middle">
     <a href="aboutus.jsp">Terms and Conditions</a>
     </div>
	 
	 <div class="middle1"> 
   <a href="aboutus.jsp">Privacy and Policy</a>
	  
     </div>
	 
	  <div class="middle2"> 
    <a href="aboutus.jsp">FAQ'S</a> 
     </div>
	 
     <div class="right">
      
     <a href="aboutus.jsp"><img src="C:\Users\pc\Downloads\Image\download.jpeg" alt="star" height="60" width="120"></a>
     </div>
	 
   </div>
   <div class="bottom">
     <p> &#169; 2020 SARARiders. All rights reserved</p>
   </div>

   </footer>

  </body>

</html>
