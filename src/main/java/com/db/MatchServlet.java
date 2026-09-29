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
@WebServlet("/MatchServlet")

public class MatchServlet extends HttpServlet {

protected void doGet(HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException {

ArrayList<String[]> matches = new ArrayList<>();

try{
Connection con = DBConnection.getConnection();

HttpSession session = request.getSession();
String userEmail = (String) session.getAttribute("email");

System.out.println("MatchServlet running for: " + userEmail);

/* GET LOST ITEMS OF LOGGED USER */
PreparedStatement ps1 =
con.prepareStatement(
"SELECT * FROM lost_items WHERE email=?"
);
ps1.setString(1,userEmail);

ResultSet lostRS = ps1.executeQuery();

ArrayList<String[]> lostList = new ArrayList<>();

while(lostRS.next()){
String data[] = new String[5];
data[0] = lostRS.getString("item_name");
data[1] = lostRS.getString("description");
data[2] = lostRS.getString("location");
data[3] = lostRS.getString("image");
data[4] = lostRS.getString("email"); // ✅ FIX
lostList.add(data);
}

/* GET ALL FOUND ITEMS */
PreparedStatement ps2 =
con.prepareStatement("SELECT * FROM found_items");

ResultSet foundRS = ps2.executeQuery();

while(foundRS.next()){

String foundName = foundRS.getString("item_name");
String foundDesc = foundRS.getString("description");
String foundLoc  = foundRS.getString("location");
String foundImg  = foundRS.getString("image");
String foundEmail = foundRS.getString("email");

/* COMPARE */
for(String lost[] : lostList){

String lostName = lost[0];
String lostDesc = lost[1];
String lostLoc  = lost[2];
String lostImg  = lost[3];
String lostEmail = lost[4]; // ✅ FIX

double imgScore =
ImageSimilarityUtil.compareImages(lostImg,foundImg);

double nameScore =
TextSimilarityUtil.similarity(lostName,foundName);

double descScore =
TextSimilarityUtil.similarity(lostDesc,foundDesc);

double locScore =
TextSimilarityUtil.similarity(lostLoc,foundLoc);

/* FINAL SCORE */
double finalScore =
(imgScore*0.6)+
(nameScore*0.2)+
(descScore*0.15)+
(locScore*0.05);

System.out.println("Score = " + finalScore);

if(finalScore > 0.55){

String m[] = new String[7];
m[0] = lostName;
m[1] = foundName;
m[2] = lostImg;
m[3] = foundImg;
m[4] = String.valueOf(finalScore);
m[5] = lostLoc;
m[6] = foundEmail;

matches.add(m);

/* NOTIFICATION */
String message =
"Match found for your lost item: "
+ lostName + " at " + lostLoc;

PreparedStatement notifyPS =
con.prepareStatement(
"INSERT INTO notifications(email,message) VALUES (?,?)"
);

notifyPS.setString(1, lostEmail); // ✅ FIX
notifyPS.setString(2, message);

notifyPS.executeUpdate();
}
}
}

/* SEND TO JSP */
request.setAttribute("matches", matches);

request.getRequestDispatcher("match.jsp")
.forward(request,response);

}
catch(Exception e){
e.printStackTrace();
response.getWriter().println("Error: "+e.getMessage());
}
}
}