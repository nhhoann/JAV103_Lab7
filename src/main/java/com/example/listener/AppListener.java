package com.example.listener;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener
public class AppListener implements HttpSessionListener, ServletContextListener {
    @Override
    @SuppressWarnings("UseSpecificCatch")
    public void contextInitialized(ServletContextEvent e) {
        Integer visitors = 0;
        try {
            String path = e.getServletContext().getRealPath("/visitors.txt");
            List<String> lines = Files.readAllLines(Paths.get(path));
            visitors = Integer.valueOf(lines.get(0));
            System.out.println("✓ Đọc số khách từ file: " + visitors);
        } catch (Exception ex) {
            visitors = 100000; 
            System.out.println("⚠ File không tìm thấy, khởi đầu số khách: " + visitors);
        }
        e.getServletContext().setAttribute("visitors", visitors);
    }
    @Override
    @SuppressWarnings({"UseSpecificCatch", "CallToPrintStackTrace"})
    public void contextDestroyed(ServletContextEvent e) {
        Integer visitors = (Integer) e.getServletContext().getAttribute("visitors");
        try {
            String path = e.getServletContext().getRealPath("/visitors.txt");
            byte[] data = String.valueOf(visitors).getBytes();
            Files.write(Paths.get(path), data, StandardOpenOption.CREATE);
            System.out.println("✓ Ghi số khách vào file: " + visitors);
        } catch (Exception ex) {
            System.out.println("✗ Lỗi khi ghi file: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
    @Override
    public void sessionCreated(HttpSessionEvent e) {
        Integer visitors = (Integer) e.getSession().getServletContext()
                .getAttribute("visitors");
        visitors++;
        e.getSession().getServletContext().setAttribute("visitors", visitors);
        System.out.println("→ Session mới. Tổng khách: " + visitors);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent e) {
        System.out.println("→ Session hủy");
    }
}