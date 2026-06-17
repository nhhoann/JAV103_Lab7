package com.example.filter;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.example.entity.User;

@WebFilter(filterName = "LoggerFilter", urlPatterns = {"/admin/*"})
public class LoggerFilter implements Filter {

    private String logFilePath;

    @Override
    public void init(FilterConfig config) throws ServletException {
        logFilePath = config.getServletContext().getRealPath("/access_log.txt");
        System.out.println("✓ LoggerFilter khởi động");
        System.out.println("  File log: " + logFilePath);
    }

    @Override
    @SuppressWarnings({"UseSpecificCatch", "CallToPrintStackTrace"})
    public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws ServletException, IOException {

        HttpServletRequest httpReq = (HttpServletRequest) request;
        
        try {
            String uri = httpReq.getRequestURI();
            String username = "Guest";
            String userRole = "User";
     
            HttpSession session = httpReq.getSession(false);
            if (session != null) {
                User user = (User) session.getAttribute("user");
                if (user != null) {
                    username = user.getId();
                    userRole = user.isAdmin() ? "Admin" : "User";
                }
            }

            String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                    .format(new Date());
            String logEntry = String.format("[%s] User: %s | Role: %s | URI: %s%n",
                    timestamp, username, userRole, uri);

            Files.write(
                    Paths.get(logFilePath),
                    logEntry.getBytes(),
                    StandardOpenOption.CREATE,
                    StandardOpenOption.APPEND
            );
            
            System.out.println("📝 Log: " + logEntry.trim());
            
        } catch (Exception e) {
            System.err.println("✗ Lỗi ghi log: " + e.getMessage());
            e.printStackTrace();
        }
        
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        System.out.println("✗ LoggerFilter dừng");
    }
}