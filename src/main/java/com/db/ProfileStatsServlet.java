package com.db;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ProfileStatsServlet")

public class ProfileStatsServlet extends HttpServlet {

protected void doGet(HttpServletRequest request,
HttpServletResponse response)

throws ServletException, IOException {

try{

HttpSession session = request.getSession();

/* get logged in user email */

String email = (String) session.getAttribute("email");

/* if no login session, go to login */

if(email == null){

response.sendRedirect("login.jsp");

return;

}

Connection con = DBConnection.getConnection();

/* get user details */

PreparedStatement ps = con.prepareStatement(

"SELECT name,email,username FROM users WHERE email=?"

);

ps.setString(1,email);

ResultSet rs = ps.executeQuery();

if(rs.next()){

session.setAttribute("fullname", rs.getString("name"));

session.setAttribute("username", rs.getString("username"));

session.setAttribute("email", rs.getString("email"));

}

/* count lost items of this user */

PreparedStatement ps1 = con.prepareStatement(

"SELECT COUNT(*) FROM lost_items WHERE email=?"

);

ps1.setString(1,email);

ResultSet rs1 = ps1.executeQuery();

int lostCount = 0;

if(rs1.next()){

lostCount = rs1.getInt(1);

}

/* count found items of this user */

PreparedStatement ps2 = con.prepareStatement(

"SELECT COUNT(*) FROM found_items WHERE email=?"

);

ps2.setString(1,email);

ResultSet rs2 = ps2.executeQuery();

int foundCount = 0;

if(rs2.next()){

foundCount = rs2.getInt(1);

}

/* total contributions */

int total = lostCount + foundCount;

/* store fresh values in session */

session.setAttribute("contributions", total);

session.setAttribute("status", "Active");

/* reset phone if not set */

if(session.getAttribute("phone") == null){

session.setAttribute("phone", "Not provided");

}

/* open profile page */

request.getRequestDispatcher("profile.jsp")

.forward(request,response);

}

catch(Exception e){

e.printStackTrace();

}

}

}