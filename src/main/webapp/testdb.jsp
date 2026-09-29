<%@ page import="java.sql.Connection" %>
<%@ page import="com.db.DBConnection" %>

<html>
<body>
<%
    Connection con = DBConnection.getConnection();
    if(con != null){
        out.println("Database Connected Successfully");
    } else {
        out.println("Database Connection Failed");
    }
    
%>
</body>
</html>
