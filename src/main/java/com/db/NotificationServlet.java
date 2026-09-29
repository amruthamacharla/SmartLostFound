package com.db;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/NotificationServlet")
public class NotificationServlet extends HttpServlet {

protected void doGet(
HttpServletRequest request,
HttpServletResponse response)

throws ServletException, IOException {

ArrayList<String> list =
new ArrayList<>();

try{

Connection con =
DBConnection.getConnection();

HttpSession session =
request.getSession();

String email =
(String) session.getAttribute("email");

/* get notifications */

PreparedStatement ps =
con.prepareStatement(

"SELECT message FROM notifications WHERE email=? ORDER BY created_at DESC"

);

ps.setString(1,email);

ResultSet rs =
ps.executeQuery();

while(rs.next()){

list.add(
rs.getString("message")
);

}

/* mark notifications as read */

PreparedStatement update =
con.prepareStatement(

"UPDATE notifications SET is_read=TRUE WHERE email=?"

);

update.setString(1,email);

update.executeUpdate();

}
catch(Exception e){

e.printStackTrace();

}

/* send to jsp */

request.setAttribute(
"notifications",
list
);

request.getRequestDispatcher(
"notifications.jsp"
).forward(request,response);

}
}