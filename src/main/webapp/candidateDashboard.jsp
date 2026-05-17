<%@ page import="com.hirevision.model.User" %>
<%@ page import="com.hirevision.dao.JobDAO" %>
<%@ page import="com.hirevision.dao.ApplicationDAO" %>
<%@ page import="com.hirevision.model.Job" %>
<%@ page import="java.util.List" %>

<%
    User loggedInUser =
            (User) session.getAttribute("loggedInUser");

    if(loggedInUser == null){
        response.sendRedirect("auth.jsp");
        return;
    }

    JobDAO jobDAO = new JobDAO();

    ApplicationDAO applicationDAO =
            new ApplicationDAO();

    List<Job> recentJobs =
            jobDAO.getAllJobs();

    int totalJobs =
            recentJobs.size();

    int appliedJobs =
            applicationDAO
                    .getApplicationsByUser(
                            loggedInUser.getId()
                    ).size();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HireVision Dashboard</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/candidateDashboard.css">

</head>

<body>
<div class="dashboard">
    <aside class="sidebar">
        <div class="logo">
            <div class="logo-icon">
                <i class="bi bi-columns-gap"></i>
            </div>
            <div class="logo-text">
                <h1>Hire<span>Vision</span></h1>
                <p>Smart Hiring, Better Future</p>
            </div>
        </div>

        <nav class="menu">
            <a href="candidateDashboard.jsp" class="active">
                <i class="bi bi-house-door"></i>
                <span>Dashboard</span>
            </a>
            <a href="viewJobs.jsp">
                <i class="bi bi-briefcase"></i>
                <span>Browse Jobs</span>
            </a>
            <a href="myApplications.jsp">
                <i class="bi bi-file-earmark-text"></i>
                <span>My Applications</span>
            </a>
            <a href="auth.jsp">
                <i class="bi bi-box-arrow-right"></i>
                <span>Logout</span>
            </a>
        </nav>
    </aside>

    <main class="main">
        <div class="content-shell">
            <div class="topbar">
                <div class="profile">
                    <div class="profile-avatar">
                        <%= loggedInUser.getFullName().substring(0, 1).toUpperCase() %>
                    </div>
                    <div>
                        <h4><%= loggedInUser.getFullName() %></h4>
                        <p>Candidate</p>
                    </div>
                </div>
            </div>

            <section class="hero">
                <div>
                    <h1>
                        Welcome back,
                        <span><%= loggedInUser.getFullName() %></span>
                    </h1>
                    <p>Find your dream opportunity today.</p>
                </div>

                <div class="hero-visual" aria-hidden="true">
                    <div class="hero-bag"></div>
                    <div class="hero-card"></div>
                    <div class="hero-lens"></div>
                </div>
            </section>

            <section class="stats">
                <div class="stat-card">
                    <div class="stat-icon blue">
                        <i class="bi bi-file-earmark-check"></i>
                    </div>
                    <h2><%= appliedJobs %></h2>
                    <p>Applied Jobs</p>
                </div>

                <div class="stat-card">
                    <div class="stat-icon cyan">
                        <i class="bi bi-briefcase"></i>
                    </div>
                    <h2><%= totalJobs %></h2>
                    <p>Available Jobs</p>
                </div>
            </section>

            <section class="section">
                <div class="section-title">
                    <h2>Recent Jobs</h2>
                    <a href="viewJobs.jsp" class="view-all">View All</a>
                </div>

                <div class="job-list">
                    <%
                        int count = 0;

                        for(Job job : recentJobs){

                            if(count == 3){
                                break;
                            }
                    %>

                    <div class="job-card">
                        <div>
                            <h3><%= job.getJobTitle() %></h3>
                            <p>
                                <%= job.getCompanyName() %>
                                &bull;
                                <%= job.getLocation() %>
                                &bull;
                                &#8377;<%= job.getSalary() %>
                            </p>
                        </div>

                        <a href="viewJobs.jsp">
                            <button class="apply-btn">Apply Now</button>
                        </a>
                    </div>

                    <%
                            count++;
                        }
                    %>
                </div>
            </section>
        </div>
    </main>
</div>
</body>
</html>
