package com.db;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/RegisterServlet")

public class RegisterServlet extends HttpServlet {

private static final long serialVersionUID = 1L;

protected void doPost(HttpServletRequest request,
HttpServletResponse response)

throws ServletException, IOException {

/* get values from form */

String fullname = request.getParameter("fullname");
String username = request.getParameter("username");
String email = request.getParameter("email");
String password = request.getParameter("password");

try{

Connection con = DBConnection.getConnection();

/* insert into database */

PreparedStatement ps = con.prepareStatement(

"INSERT INTO users(name,email,username,password) VALUES(?,?,?,?)"

);

ps.setString(1, fullname);
ps.setString(2, email);
ps.setString(3, username);
ps.setString(4, password);

int result = ps.executeUpdate();

if(result > 0){

HttpSession session = request.getSession();

/* clear previous user data */
session.invalidate();

/* create new session */
session = request.getSession(true);

/* store new user details */
session.setAttribute("fullname", fullname);
session.setAttribute("username", username);
session.setAttribute("email", email);

/* reset all values */
session.setAttribute("phone", "Not provided");
session.setAttribute("lostCount", 0);
session.setAttribute("foundCount", 0);
session.setAttribute("contributions", 0);
session.setAttribute("status", "Active");

/* success message */
session.setAttribute("msg","Successfully Registered");

response.sendRedirect("DashboardServlet");
}
else{

response.getWriter().println("Registration Failed");

}

}

catch(Exception e){

e.printStackTrace();

response.setContentType("text/html");

response.getWriter().println(
"<h3>Error: " + e.getMessage() + "</h3>"
);

}

}

/* if user opens servlet directly */

protected void doGet(HttpServletRequest request,
HttpServletResponse response)

throws ServletException, IOException {

response.sendRedirect("register.jsp");

}

}