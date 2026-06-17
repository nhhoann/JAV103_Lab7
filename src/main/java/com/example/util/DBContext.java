package com.example.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    
    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String URL = "jdbc:sqlserver://localhost:1433;databaseName=Lab07;encrypt=true;trustServerCertificate=true";
    private static final String USER = "sa";         
    private static final String PASSWORD = "123456Aa@";  

    @SuppressWarnings("UseSpecificCatch")
    public Connection getConnection() throws Exception {
        try {
            Class.forName(DRIVER);
            
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("✓ Kết nối database thành công!");
            return conn;
            
        } catch (ClassNotFoundException e) {
            System.err.println("✗ Lỗi: Không tìm thấy SQL Server Driver");
            System.err.println("  Đảm bảo mssql-jdbc-xx.jar có trong classpath");
            throw e;
            
        } catch (Exception e) {
            System.err.println("✗ Lỗi kết nối database: " + e.getMessage());
            System.err.println("  Kiểm tra:");
            System.err.println("  - Server: localhost:1433");
            System.err.println("  - Database: Lab07");
            System.err.println("  - Username: " + USER);
            throw e;
        }
    }

    @SuppressWarnings("CallToPrintStackTrace")
    public static void main(String[] args) {
        try {
            DBContext db = new DBContext();
            Connection conn = db.getConnection();
            
            if (conn != null) {
                System.out.println("✓ Kết nối thành công!");
                System.out.println("✓ Database: " + conn.getCatalog());
                System.out.println("✓ Server: " + conn.getMetaData().getDatabaseProductName());
                conn.close();
                System.out.println("✓ Đóng kết nối");
            }
        } catch (Exception e) {
            System.err.println("✗ Test kết nối thất bại");
            e.printStackTrace();
        }
    }
}
