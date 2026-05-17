package com.hirevision.controller;

import com.hirevision.dao.JobDAO;
import com.hirevision.model.Job;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/updateJob")
public class UpdateJobServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        int id =
                Integer.parseInt(
                        request.getParameter("id")
                );

        String title =
                request.getParameter("title");

        String company =
                request.getParameter("company");

        String location =
                request.getParameter("location");

        String salary =
                request.getParameter("salary");

        String description =
                request.getParameter("description");

        Job job =
                new Job();

        job.setId(id);
        job.setJobTitle(title);
        job.setCompanyName(company);
        job.setLocation(location);
        job.setSalary(salary);
        job.setDescription(description);

        JobDAO jobDAO =
                new JobDAO();

        boolean status =
                jobDAO.updateJob(job);

        if(status){

            response.sendRedirect("myJobs.jsp");

        }else{

            response.sendRedirect("editJob.jsp?id=" + id);
        }
    }
}
