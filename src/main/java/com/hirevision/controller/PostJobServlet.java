package com.hirevision.controller;

import com.hirevision.dao.JobDAO;
import com.hirevision.model.Job;
import com.hirevision.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

public class PostJobServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String jobTitle =
                request.getParameter("jobTitle");

        String companyName =
                request.getParameter("companyName");

        String location =
                request.getParameter("location");

        String salary =
                request.getParameter("salary");

        String description =
                request.getParameter("description");

        HttpSession session =
                request.getSession();

        User loggedInUser =
                (User) session.getAttribute("loggedInUser");

        int postedBy =
                loggedInUser.getId();

        Job job = new Job(
                jobTitle,
                companyName,
                location,
                salary,
                description,
                postedBy
        );

        JobDAO dao = new JobDAO();

        boolean status = dao.addJob(job);

        if(status){

            response.sendRedirect(
                    "recruiterDashboard.jsp"
            );

        } else {

            response.getWriter().println(
                    "Failed to Post Job!"
            );
        }
    }
}