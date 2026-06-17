package com.example.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.DAO.UserDAO;
import com.example.entity.User;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        
        String id = req.getParameter("username");
        String pw = req.getParameter("password");
        
        try {
            UserDAO dao = new UserDAO();
            User user = dao.findById(id);
            
            if (!user.getPassword().equals(pw)) {
                req.setAttribute("message", "Sai mật khẩu!");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
                return;
            }
 
            req.setAttribute("message", "Đăng nhập thành công!");
            
            req.getSession().setAttribute("user", user);
  
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
            
        } catch (Exception e) {
            req.setAttribute("message", "Sai tên đăng nhập!");
            req.getRequestDispatcher("login.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("login.jsp").forward(req, resp);
    }
}