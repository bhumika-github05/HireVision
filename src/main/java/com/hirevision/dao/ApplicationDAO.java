package com.hirevision.dao;

import com.hirevision.model.Application;
import com.hirevision.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;
import com.hirevision.model.Application;

public class ApplicationDAO {

    public List<Application> getApplicationsByJob(int jobId){

        List<Application> list =
                new ArrayList<>();

        try{

            Connection con =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM applications WHERE job_id=?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, jobId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                Application app =
                        new Application();

                app.setId(
                        rs.getInt("id")
                );

                app.setUserId(
                        rs.getInt("user_id")
                );

                app.setJobId(
                        rs.getInt("job_id")
                );

                app.setResumeLink(
                        rs.getString("resume_link")
                );

                app.setStatus(
                        rs.getString("status")
                );

                list.add(app);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

    public List<Application> getApplicationsByUser(int userId){

        List<Application> list =
                new ArrayList<>();

        try{

            Connection con =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM applications WHERE user_id=?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, userId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                Application app =
                        new Application();

                app.setId(rs.getInt("id"));

                app.setUserId(
                        rs.getInt("user_id")
                );

                app.setJobId(
                        rs.getInt("job_id")
                );

                app.setResumeLink(
                        rs.getString("resume_link")
                );

                app.setStatus(
                        rs.getString("status")
                );

                list.add(app);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return list;
    }

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

    public boolean hasAlreadyApplied(int userId,
                                     int jobId) {

        boolean exists = false;

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM applications " +
                            "WHERE user_id=? AND job_id=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, userId);

            ps.setInt(2, jobId);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()){
                exists = true;
            }

        } catch (Exception e){
            e.printStackTrace();
        }

        return exists;
    }
}