<%@ page import="java.util.List" %>
<%@ page import="com.hirevision.model.User" %>
<%@ page import="com.hirevision.model.Application" %>
<%@ page import="com.hirevision.model.Job" %>
<%@ page import="com.hirevision.dao.ApplicationDAO" %>
<%@ page import="com.hirevision.dao.JobDAO" %>

<%
  User loggedInUser =
          (User) session.getAttribute("loggedInUser");

  if(loggedInUser == null){
    response.sendRedirect("auth.jsp");
    return;
  }

  ApplicationDAO applicationDAO =
          new ApplicationDAO();

  JobDAO jobDAO =
          new JobDAO();

  List<Application> applications =
          applicationDAO.getApplicationsByUser(
                  loggedInUser.getId()
          );

  int totalApplications = applications.size();

  int pendingCount = 0;
  int acceptedCount = 0;
  int rejectedCount = 0;

  for(Application app : applications){

    String status =
            app.getStatus() == null ? "Pending" : app.getStatus();

    if(status.equalsIgnoreCase("Pending")){
      pendingCount++;
    }

    else if(status.equalsIgnoreCase("Accepted")){
      acceptedCount++;
    }

    else if(status.equalsIgnoreCase("Rejected")){
      rejectedCount++;
    }
  }
%>

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="UTF-8">

  <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

  <title>My Applications - HireVision</title>

  <link rel="preconnect"
        href="https://fonts.googleapis.com">

  <link rel="preconnect"
        href="https://fonts.gstatic.com"
        crossorigin>

  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">

  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

  <link rel="stylesheet" href="css/myApplications.css">



</head>

<body>

<div class="dashboard">

  <!-- SIDEBAR -->

  <aside class="sidebar">

    <div class="logo">

      <div class="logo-icon">
        <i class="bi bi-columns-gap"></i>
      </div>

      <div class="logo-text">

        <h1>
          Hire<span>Vision</span>
        </h1>

        <p>
          Smart Hiring, Better Future
        </p>

      </div>

    </div>

    <nav class="menu">

      <a href="candidateDashboard.jsp">

        <i class="bi bi-house-door"></i>

        Dashboard

      </a>

      <a href="viewJobs.jsp">

        <i class="bi bi-briefcase"></i>

        Browse Jobs

      </a>

      <a href="myApplications.jsp"
         class="active">

        <i class="bi bi-file-earmark-text"></i>

        My Applications

      </a>

      <a href="auth.jsp">

        <i class="bi bi-box-arrow-right"></i>

        Logout

      </a>

    </nav>

  </aside>

  <!-- MAIN -->

  <main class="main">

    <div class="content-shell">

    <div class="topbar">

      <div class="page-title">

        <h1>
          My Applications
        </h1>

        <p>
          Track your job applications and status.
        </p>

      </div>

      <div class="profile">

        <div class="profile-avatar">
          <%= loggedInUser.getFullName().substring(0, 1).toUpperCase() %>
        </div>

        <div>

        <h4>
          <%= loggedInUser.getFullName() %>
        </h4>

        <p>
          Candidate
        </p>

        </div>

      </div>

    </div>

    <!-- STATS -->

    <div class="stats">

      <div class="stat-card">

        <div class="stat-icon blue">
          <i class="bi bi-file-earmark-text"></i>
        </div>

        <h2>
          <%= totalApplications %>
        </h2>

        <p>
          Total Applications
        </p>

      </div>

      <div class="stat-card">

        <div class="stat-icon yellow">
          <i class="bi bi-hourglass-split"></i>
        </div>

        <h2>
          <%= pendingCount %>
        </h2>

        <p>
          Pending
        </p>

      </div>

      <div class="stat-card">

        <div class="stat-icon green">
          <i class="bi bi-check-circle"></i>
        </div>

        <h2>
          <%= acceptedCount %>
        </h2>

        <p>
          Accepted
        </p>

      </div>

      <div class="stat-card">

        <div class="stat-icon red">
          <i class="bi bi-x-circle"></i>
        </div>

        <h2>
          <%= rejectedCount %>
        </h2>

        <p>
          Rejected
        </p>

      </div>

    </div>

    <!-- APPLICATION LIST -->

    <%
      if(applications.size() == 0){
    %>

    <div class="empty">

      <i class="bi bi-file-earmark-x"></i>

      <h2>
        No Applications Yet
      </h2>

      <p>
        Start applying to jobs and track them here.
      </p>

    </div>

    <%
    } else {
    %>

    <div class="applications">

    <%

      for(Application app : applications){

        Job job =
                jobDAO.getJobById(
                        app.getJobId()
                );

        String status =
                app.getStatus() == null ? "Pending" : app.getStatus();

        String statusClass =
                status.toLowerCase();

        if(!statusClass.equals("pending") &&
                !statusClass.equals("accepted") &&
                !statusClass.equals("rejected")){
          statusClass = "pending";
        }

        if(job == null){
          continue;
        }
    %>

      <div class="application-card">

        <div class="card-top">

          <div class="job-title">

            <h2>
              <%= job.getJobTitle() %>
            </h2>

            <div class="company">
              <%= job.getCompanyName() %>
            </div>

          </div>

          <div class="status
                    <%= statusClass %>">

            <%= status %>

          </div>

        </div>

        <div class="info">

          <div>
            <i class="bi bi-geo-alt"></i>
            <%= job.getLocation() %>
          </div>

          <div>
            <i class="bi bi-cash-stack"></i>
            &#8377;<%= job.getSalary() %>
          </div>

          <div>
            <i class="bi bi-briefcase"></i>
            Full Time
          </div>

        </div>

        <a href="<%= app.getResumeLink() %>"
           target="_blank"
           class="resume-btn">

          <i class="bi bi-file-earmark-arrow-down"></i>

          View Resume

        </a>

      </div>

    <%
        }
    %>

    </div>

    <%
      }
    %>

    </div>

  </main>

</div>

</body>

</html>
