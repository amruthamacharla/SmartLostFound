package com.db;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LostItemServlet")

@MultipartConfig(
fileSizeThreshold = 1024 * 1024 * 2,
maxFileSize = 1024 * 1024 * 10,
maxRequestSize = 1024 * 1024 * 50
)

public class LostItemServlet extends HttpServlet {

protected void doPost(HttpServletRequest request,
HttpServletResponse response)

throws ServletException, IOException {

try{

HttpSession session = request.getSession();

/* get logged in user email */

String email = (String) session.getAttribute("email");

if(email == null){

response.sendRedirect("login.jsp");
return;

}

/* form values */

String itemName = request.getParameter("item_name");

String date = request.getParameter("date");

String location = request.getParameter("location");

String description = request.getParameter("description");

/* image upload */

Part filePart = request.getPart("image");

String fileName = filePart.getSubmittedFileName();

String uploadPath =
request.getServletContext().getRealPath("") 
+ File.separator + "uploads";

File uploadDir = new File(uploadPath);

if (!uploadDir.exists()) {
    uploadDir.mkdirs();
}

filePart.write(uploadPath + File.separator + fileName);

System.out.println("Image saved at: " + uploadPath);

/* save in database */

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(

"INSERT INTO lost_items(item_name,date,location,description,image,email) VALUES(?,?,?,?,?,?)"

);

ps.setString(1,itemName);

ps.setString(2,date);

ps.setString(3,location);

ps.setString(4,description);

ps.setString(5,fileName);

ps.setString(6,email);   // IMPORTANT

int i = ps.executeUpdate();

/* refresh dashboard */

if(i>0){

response.sendRedirect("DashboardServlet");

}

else{

response.getWriter().println("Item not saved");

}

}

catch(Exception e){

e.printStackTrace();

}

}

protected void doGet(HttpServletRequest request,
HttpServletResponse response)

throws ServletException, IOException{

response.sendRedirect("lost.jsp");

}

}