package com.hirevision.controller;

import com.hirevision.dao.UserDAO;
import com.hirevision.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        User user = new User(fullName, email, password, role);

        UserDAO userDAO = new UserDAO();

        boolean status = userDAO.registerUser(user);

        if (status) {
            response.getWriter().println("Registration Successful!");
        } else {
            response.getWriter().println("Registration Failed!");
        }
    }
}
//
//package com.hirevision.controller;
//
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.*;
//import java.io.IOException;
//
//@WebServlet("/register")
//public class RegisterServlet extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request,
//                         HttpServletResponse response)
//            throws IOException {
//
//        response.getWriter().println("Servlet is working!");
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request,
//                          HttpServletResponse response)
//            throws IOException {
//
//        response.getWriter().println("POST is working!");
//    }
//}
