package com.hirevision.dao;

import com.hirevision.model.Job;
import com.hirevision.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class JobDAO {

    public boolean addJob(Job job) {

        boolean status = false;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "INSERT INTO jobs(job_title, company_name, location, salary, description, posted_by) VALUES(?,?,?,?,?,?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1, job.getJobTitle());
            ps.setString(2, job.getCompanyName());
            ps.setString(3, job.getLocation());
            ps.setString(4, job.getSalary());
            ps.setString(5, job.getDescription());
            ps.setInt(6, job.getPostedBy());

            int rows = ps.executeUpdate();

            if(rows > 0){
                status = true;
            }

        } catch (Exception e){
            e.printStackTrace();
        }

        return status;
    }
}