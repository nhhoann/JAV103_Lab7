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
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.entity.User;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/admin/*"})
public class AuthFilter implements Filter {

    private String logFilePath;

    @Override
    public void init(FilterConfig config) throws ServletException {
        logFilePath = config.getServletContext().getRealPath("/admin_access_log.txt");
        System.out.println("✓ AuthFilter khởi động");
    }

    @Override
    @SuppressWarnings("UseSpecificCatch")
    public void doFilter(ServletRequest request, ServletResponse response,
                        FilterChain chain) throws ServletException, IOException {
        
        HttpServletRequest httpReq = (HttpServletRequest) request;
        HttpServletResponse httpResp = (HttpServletResponse) response;
        
        HttpSession session = httpReq.getSession(false);
        User user = null;
        
        if (session != null) {
            user = (User) session.getAttribute("user");
        }
  
        if (user == null) {
            System.out.println("⚠ Truy cập không được phép: Chưa đăng nhập");
            httpResp.sendRedirect(httpReq.getContextPath() + "/login");
            return;
        }

        if (!user.isAdmin()) {
            System.out.println("⚠ Truy cập không được phép: " + user.getId() + " (không phải admin)");
            httpResp.sendRedirect(httpReq.getContextPath() + "/error/forbidden.jsp");
            return;
        }
        
        try {
            String timestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
                    .format(new Date());
            String uri = httpReq.getRequestURI();
            String logEntry = String.format("[%s] Admin: %s | URI: %s | Action: SUCCESS%n",
                    timestamp, user.getId(), uri);
            
            Files.write(
                    Paths.get(logFilePath),
                    logEntry.getBytes(),
                    StandardOpenOption.CREATE,
                    StandardOpenOption.APPEND
            );
            System.out.println("✓ Admin " + user.getId() + " truy cập: " + uri);
        } catch (Exception e) {
            System.err.println("✗ Lỗi ghi log: " + e.getMessage());
        }
        
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        System.out.println("✗ AuthFilter dừng");
    }
}