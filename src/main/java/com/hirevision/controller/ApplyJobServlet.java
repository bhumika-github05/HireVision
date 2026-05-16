package com.hirevision.controller;

import com.hirevision.dao.ApplicationDAO;
import com.hirevision.model.Application;
import com.hirevision.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;

import java.io.IOException;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;

@MultipartConfig
public class ApplyJobServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int jobId =
                Integer.parseInt(
                        request.getParameter("jobId")
                );

        HttpSession session =
                request.getSession();

        User user =
                (User) session.getAttribute("loggedInUser");

        int userId =
                user.getId();

        Part filePart =
                request.getPart("resume");

        String fileName =
                filePart.getSubmittedFileName();

        String uploadPath =
                getServletContext()
                        .getRealPath("/uploads");

        java.io.File uploadDir =
                new java.io.File(uploadPath);

        if(!uploadDir.exists()){
            uploadDir.mkdir();
        }

        filePart.write(
                uploadPath +
                        java.io.File.separator +
                        fileName
        );

        String resumeLink =
                "uploads/" + fileName;

        Application app =
                new Application(
                        userId,
                        jobId,
                        resumeLink
                );

        ApplicationDAO dao =
                new ApplicationDAO();

        boolean status =
                dao.applyJob(app);

        if(status){

            response.sendRedirect(
                    "viewJobs.jsp"
            );

        } else {

            response.getWriter().println(
                    "Failed to Apply!"
            );
        }
    }
}