package com.hirevision.dao;

import com.hirevision.model.Job;
import com.hirevision.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {

    public List<Job> getJobsByRecruiter(int recruiterId){

        List<Job> jobs =
                new ArrayList<>();

        try{

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM jobs WHERE posted_by=?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setInt(1, recruiterId);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                Job job =
                        new Job();

                job.setId(
                        rs.getInt("id")
                );

                job.setJobTitle(
                        rs.getString("job_title")
                );

                job.setCompanyName(
                        rs.getString("company_name")
                );

                job.setLocation(
                        rs.getString("location")
                );

                job.setSalary(
                        rs.getString("salary")
                );

                job.setDescription(
                        rs.getString("description")
                );

                job.setPostedBy(
                        rs.getInt("posted_by")
                );

                jobs.add(job);
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return jobs;
    }

    public Job getJobById(int id){

        Job job = null;

        try{

            Connection con =
                    DBConnection.getConnection();

            String query =
                    "SELECT * FROM jobs WHERE id=?";

            PreparedStatement ps =
                    con.prepareStatement(query);

            ps.setInt(1, id);

            ResultSet rs =
                    ps.executeQuery();

            if(rs.next()){

                job = new Job();

                job.setId(
                        rs.getInt("id")
                );

                job.setJobTitle(
                        rs.getString("job_title")
                );

                job.setCompanyName(
                        rs.getString("company_name")
                );

                job.setLocation(
                        rs.getString("location")
                );

                job.setSalary(
                        rs.getString("salary")
                );

                job.setDescription(
                        rs.getString("description")
                );
            }

        }catch(Exception e){
            e.printStackTrace();
        }

        return job;
    }

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


    public List<Job> getAllJobs() {

        List<Job> jobs = new ArrayList<>();

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM jobs";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                Job job = new Job();

                job.setId(rs.getInt("id"));

                job.setJobTitle(
                        rs.getString("job_title")
                );

                job.setCompanyName(
                        rs.getString("company_name")
                );

                job.setLocation(
                        rs.getString("location")
                );

                job.setSalary(
                        rs.getString("salary")
                );

                job.setDescription(
                        rs.getString("description")
                );

                job.setPostedBy(
                        rs.getInt("posted_by")
                );

                jobs.add(job);
            }

        } catch (Exception e){
            e.printStackTrace();
        }

        return jobs;
    }

    public List<Job> searchJobs(String keyword){

        List<Job> jobs =
                new ArrayList<>();

        try {

            Connection conn =
                    DBConnection.getConnection();

            String sql =
                    "SELECT * FROM jobs " +
                            "WHERE job_title LIKE ? " +
                            "OR company_name LIKE ? " +
                            "OR location LIKE ?";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            String searchKeyword =
                    "%" + keyword + "%";

            ps.setString(1, searchKeyword);

            ps.setString(2, searchKeyword);

            ps.setString(3, searchKeyword);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()){

                Job job = new Job();

                job.setId(rs.getInt("id"));

                job.setJobTitle(
                        rs.getString("job_title")
                );

                job.setCompanyName(
                        rs.getString("company_name")
                );

                job.setLocation(
                        rs.getString("location")
                );

                job.setSalary(
                        rs.getString("salary")
                );

                job.setDescription(
                        rs.getString("description")
                );

                jobs.add(job);
            }

        } catch (Exception e){
            e.printStackTrace();
        }

        return jobs;
    }
}