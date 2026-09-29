package com.db;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/SearchServlet")

public class SearchServlet extends HttpServlet {

protected void doGet(HttpServletRequest request,
HttpServletResponse response)

throws ServletException, IOException {

ArrayList<String[]> items = new ArrayList<>();

try {

HttpSession session = request.getSession();

/* get logged in user */

String email = (String) session.getAttribute("email");

/* if not logged in */

if(email == null){

response.sendRedirect("login.jsp");

return;

}

Connection con = DBConnection.getConnection();

/* LOST ITEMS of this user */

PreparedStatement ps1 = con.prepareStatement(

"SELECT item_name, location, description, image FROM lost_items WHERE email=?"

);

ps1.setString(1,email);

ResultSet rs1 = ps1.executeQuery();

while(rs1.next()){

String data[] = new String[5];

data[0] = "LOST";

data[1] = rs1.getString("item_name");

data[2] = rs1.getString("location");

data[3] = rs1.getString("description");

data[4] = rs1.getString("image");

items.add(data);

}

/* FOUND ITEMS of this user */

PreparedStatement ps2 = con.prepareStatement(

"SELECT item_name, location, description, image FROM found_items WHERE email=?"

);

ps2.setString(1,email);

ResultSet rs2 = ps2.executeQuery();

while(rs2.next()){

String data[] = new String[5];

data[0] = "FOUND";

data[1] = rs2.getString("item_name");

data[2] = rs2.getString("location");

data[3] = rs2.getString("description");

data[4] = rs2.getString("image");

items.add(data);

}

/* send to jsp */

request.setAttribute("itemsList", items);

request.getRequestDispatcher("search.jsp")

.forward(request,response);

}

catch(Exception e){

e.printStackTrace();

response.getWriter().println("Error : "+e.getMessage());

}

}

}