package com.lpg.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Railway Environment Variables များကို စစ်ဆေးခြင်း
            String host = System.getenv("MYSQLHOST");
            String port = System.getenv("MYSQLPORT");
            String dbName = System.getenv("MYSQLDATABASE");
            String user = System.getenv("MYSQLUSER");
            String password = System.getenv("MYSQLPASSWORD"); // (သို့မဟုတ် MYSQL_ROOT_PASSWORD)
            
            String url;
            if (host != null && !host.isEmpty()) {
                // Railway ဆာဗာအတွက် URL
                url = "jdbc:mysql://" + host + ":" + port + "/" + dbName + "?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
            } else {
                // Localhost အတွက် (ယခင်အတိုင်း)
                url = "jdbc:mysql://localhost:3306/lpg_platform?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8";
                user = "root";
                password = "aungkyawsan";
            }
            
            conn = DriverManager.getConnection(url, user, password);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
