package com.hirevision.controller;

import com.hirevision.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

public class DeleteJobServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int jobId =
                Integer.parseInt(
                        request.getParameter("id")
                );

        try {

            Connection conn =
                    DBConnection.getConnection();

            // FIRST DELETE APPLICATIONS

            String deleteApplications =
                    "DELETE FROM applications WHERE job_id=?";

            PreparedStatement ps1 =
                    conn.prepareStatement(deleteApplications);

            ps1.setInt(1, jobId);

            ps1.executeUpdate();

            // THEN DELETE JOB

            String deleteJob =
                    "DELETE FROM jobs WHERE id=?";

            PreparedStatement ps2 =
                    conn.prepareStatement(deleteJob);

            ps2.setInt(1, jobId);

            ps2.executeUpdate();

            response.sendRedirect("myJobs.jsp");

        } catch (Exception e){
            e.printStackTrace();
        }
    }
    }