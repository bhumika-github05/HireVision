package com.hirevision.controller;

import com.hirevision.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class UpdateApplicationStatusServlet
        extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int applicationId =
                Integer.parseInt(
                        request.getParameter("id")
                );

        String status =
                request.getParameter("status");

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "UPDATE applications SET status=? WHERE id=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1, status);

            ps.setInt(2, applicationId);

            ps.executeUpdate();

            response.sendRedirect(
                    "viewApplicants.jsp"
            );

        } catch (Exception e){
            e.printStackTrace();
        }
    }
}