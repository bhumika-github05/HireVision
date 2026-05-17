package com.hirevision.dao;

import com.hirevision.model.User;
import com.hirevision.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

import java.sql.ResultSet;

public class UserDAO {

    public User getUserById(int id){

        User user = null;

        try{

            Connection con =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM users WHERE id=?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, id);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()){

                user = new User();

                user.setId(
                        rs.getInt("id")
                );

                user.setFullName(
                        rs.getString("full_name")
                );

                user.setEmail(
                        rs.getString("email")
                );

                user.setRole(
                        rs.getString("role")
                );
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return user;
    }

    public boolean registerUser(User user) {

        String query = "INSERT INTO users(full_name, email, password, role) VALUES (?, ?, ?, ?)";

        try {

            // Get database connection
            Connection conn = DBConnection.getConnection();

            // Prepare SQL query
            PreparedStatement ps = conn.prepareStatement(query);

            // Set values into query
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());

            // Execute query
            int rows = ps.executeUpdate();

            // If rows inserted successfully
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    public User loginUser(String email, String password) {

        String query = "SELECT * FROM users WHERE email = ? AND password = ?";

        try {

            Connection conn = DBConnection.getConnection();

            PreparedStatement ps = conn.prepareStatement(query);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            // If user found
            if(rs.next()) {

                User user = new User();

                user.setId(rs.getInt("id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));

                return user;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}