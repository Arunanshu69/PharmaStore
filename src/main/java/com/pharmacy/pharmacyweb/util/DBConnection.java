package com.pharmacy.pharmacyweb.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/pharmacy_db", "root", "Armaan MALIK@22");
        } catch (Exception e) {
            // This will print the actual error (like 'Access Denied') in the IntelliJ console
            e.printStackTrace();
            return null;
        }
    }
}