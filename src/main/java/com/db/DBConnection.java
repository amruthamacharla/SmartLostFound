package com.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/smart_lost_found?useSSL=false&serverTimezone=UTC",
                "root",
                "@ishwarya006"
            );
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
