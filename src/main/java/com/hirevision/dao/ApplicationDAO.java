package com.hirevision.dao;

import com.hirevision.model.Application;
import com.hirevision.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ApplicationDAO {

    public boolean applyJob(Application app) {

        boolean status = false;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "INSERT INTO applications(user_id, job_id, resume_link) VALUES(?,?,?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, app.getUserId());

            ps.setInt(2, app.getJobId());

            ps.setString(3, app.getResumeLink());

            int rows =
                    ps.executeUpdate();

            if(rows > 0){
                status = true;
            }

        } catch (Exception e){
            e.printStackTrace();
        }

        return status;
    }
}