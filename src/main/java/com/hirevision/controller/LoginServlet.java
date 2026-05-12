package com.hirevision.controller;

import com.hirevision.dao.UserDAO;
import com.hirevision.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDAO userDAO = new UserDAO();

        User user = userDAO.loginUser(email, password);

        if(user != null){

            HttpSession session = request.getSession();

            session.setAttribute("loggedInUser", user);

            session.setAttribute("userName", user.getFullName());

            session.setAttribute("userRole", user.getRole());

            if(user.getRole().equals("Candidate")){

                response.sendRedirect("candidateDashboard.jsp");

            } else {

                response.sendRedirect("recruiterDashboard.jsp");
            }

        }else {

            response.getWriter().println("Invalid Email or Password!");

        }
    }
}