<%@ page import="java.util.ArrayList" %>

<h2>Your Notifications </h2>

<%

ArrayList<String> list =
(ArrayList<String>)
request.getAttribute("notifications");

/* check if list empty */

if(list==null || list.size()==0){

%>

<p>No notifications</p>

<%

}else{

for(String msg : list){

%>

<div
style="
border:1px solid #ddd;
padding:10px;
margin:10px;
border-radius:8px">

<%=msg%>

</div>

<%
}

}
%>