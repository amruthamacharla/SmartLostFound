package com.db;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        // get input (email OR username)
        String user = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Connection con = DBConnection.getConnection();

            // ✅ allow email OR username login
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE (email=? OR username=?) AND password=?"
            );

            ps.setString(1, user);
            ps.setString(2, user);
            ps.setString(3, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session = request.getSession();
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("username", rs.getString("username"));

                System.out.println("Login SUCCESS");

                response.sendRedirect(request.getContextPath() + "/DashboardServlet");

            } else {
                System.out.println("Login FAILED");
                response.getWriter().println("Invalid Email or Password");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}