package com.example.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.example.entity.User;
import com.example.util.DBContext;

public class UserDAO {
    public User findById(String id) throws Exception {
        String sql = "SELECT * FROM [User] WHERE [id] = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getString("id"));
                    user.setPassword(rs.getString("password"));
                    user.setFullname(rs.getString("fullname"));
                    user.setAdmin(rs.getBoolean("admin"));
                    return user;
                }
            }
        }
        throw new Exception("Không tìm thấy người dùng: " + id);
    }

    public List<User> getAll() throws Exception {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM [User]";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    User user = new User();
                    user.setId(rs.getString("id"));
                    user.setPassword(rs.getString("password"));
                    user.setFullname(rs.getString("fullname"));
                    user.setAdmin(rs.getBoolean("admin"));
                    list.add(user);
                }
            }
        }
        return list;
    }

    public void insert(User user) throws Exception {
        String sql = "INSERT INTO [User] (id, password, fullname, admin) VALUES (?, ?, ?, ?)";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getId());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setBoolean(4, user.isAdmin());
            ps.executeUpdate();
        }
    }

    public void update(User user) throws Exception {
        String sql = "UPDATE [User] SET password = ?, fullname = ?, admin = ? WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getPassword());
            ps.setString(2, user.getFullname());
            ps.setBoolean(3, user.isAdmin());
            ps.setString(4, user.getId());
            ps.executeUpdate();
        }
    }

    public void delete(String id) throws Exception {
        String sql = "DELETE FROM [User] WHERE id = ?";
        try (Connection conn = new DBContext().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, id);
            ps.executeUpdate();
        }
    }
}