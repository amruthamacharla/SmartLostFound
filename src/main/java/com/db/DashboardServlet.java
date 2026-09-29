package com.db;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DashboardServlet")

public class DashboardServlet extends HttpServlet {

protected void doGet(
HttpServletRequest request,
HttpServletResponse response)

throws ServletException, IOException {

try{

HttpSession session =
request.getSession();

/* check login */

String email =
(String) session.getAttribute("email");

if(email == null){

response.sendRedirect("login.jsp");

return;

}

Connection con =
DBConnection.getConnection();

/* LOST COUNT */

PreparedStatement ps1 =
con.prepareStatement(

"SELECT COUNT(*) FROM lost_items WHERE email=?"

);

ps1.setString(1,email);

ResultSet rs1 =
ps1.executeQuery();

int lostCount = 0;

if(rs1.next()){

lostCount = rs1.getInt(1);

}


/* FOUND COUNT */

PreparedStatement ps2 =
con.prepareStatement(

"SELECT COUNT(*) FROM found_items WHERE email=?"

);

ps2.setString(1,email);

ResultSet rs2 =
ps2.executeQuery();

int foundCount = 0;

if(rs2.next()){

foundCount = rs2.getInt(1);

}


/* LAST 5 LOST ITEMS */

PreparedStatement ps3 =
con.prepareStatement(

"SELECT item_name,image FROM lost_items WHERE email=? ORDER BY id DESC LIMIT 5"

);

ps3.setString(1,email);

ResultSet rs3 =
ps3.executeQuery();

ArrayList<String> lostList =
new ArrayList<>();

while(rs3.next()){

lostList.add(

rs3.getString("item_name")
+ "|"
+ rs3.getString("image")

);

}


/* LAST 5 FOUND ITEMS */

PreparedStatement ps4 =
con.prepareStatement(

"SELECT item_name,image FROM found_items WHERE email=? ORDER BY id DESC LIMIT 5"

);

ps4.setString(1,email);

ResultSet rs4 =
ps4.executeQuery();

ArrayList<String> foundList =
new ArrayList<>();

while(rs4.next()){

foundList.add(

rs4.getString("item_name")
+ "|"
+ rs4.getString("image")

);

}


/* 🔔 NOTIFICATION COUNT */

PreparedStatement ps5 =
con.prepareStatement(

"SELECT COUNT(*) FROM notifications WHERE email=? AND is_read=FALSE"

);

ps5.setString(1,email);

ResultSet rs5 =
ps5.executeQuery();

int count = 0;

if(rs5.next()){

count = rs5.getInt(1);

}


/* send data to dashboard */

request.setAttribute(
"lostCount",
lostCount
);

request.setAttribute(
"foundCount",
foundCount
);

request.setAttribute(
"lostList",
lostList
);

request.setAttribute(
"foundList",
foundList
);

request.setAttribute(
"count",
count
);


/* open dashboard */

request.getRequestDispatcher(
"dashboard.jsp"
).forward(
request,
response
);

}
catch(Exception e){

e.printStackTrace();

}

}

}