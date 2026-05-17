<%@ page import="java.util.List" %>
<%@ page import="com.hirevision.model.User" %>
<%@ page import="com.hirevision.model.Job" %>
<%@ page import="com.hirevision.model.Application" %>
<%@ page import="com.hirevision.dao.JobDAO" %>
<%@ page import="com.hirevision.dao.ApplicationDAO" %>

<%
  User loggedInUser =
          (User) session.getAttribute("loggedInUser");

  if(loggedInUser == null){
    response.sendRedirect("auth.jsp");
    return;
  }

  JobDAO jobDAO =
          new JobDAO();

  ApplicationDAO applicationDAO =
          new ApplicationDAO();

  List<Job> recruiterJobs =
          jobDAO.getJobsByRecruiter(
                  loggedInUser.getId()
          );

  int totalJobs =
          recruiterJobs.size();

  int totalApplications = 0;

  for(Job job : recruiterJobs){

    totalApplications +=
            applicationDAO
                    .getApplicationsByJob(
                            job.getId()
                    ).size();
  }
%>

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="UTF-8">

  <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

  <title>Recruiter Dashboard</title>

  <link rel="preconnect"
        href="https://fonts.googleapis.com">

  <link rel="preconnect"
        href="https://fonts.gstatic.com"
        crossorigin>

  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">

  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

  <link rel="stylesheet" href="css/recruiterDashboard.css">


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

      <a href="recruiterDashboard.jsp"
         class="active">

        <i class="bi bi-house-door"></i>

        Dashboard

      </a>

      <a href="postJob.jsp">

        <i class="bi bi-plus-circle"></i>

        Post Job

      </a>

      <a href="myJobs.jsp">

        <i class="bi bi-briefcase"></i>

        My Jobs

      </a>

      <a href="viewApplicants.jsp">

        <i class="bi bi-people"></i>

        Applicants

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
          Recruiter Dashboard
        </h1>

        <p>
          Manage jobs and monitor applications.
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
          Recruiter
        </p>

        </div>

      </div>

    </div>

    <!-- STATS -->

    <div class="stats">

      <div class="stat-card">

        <div class="stat-icon blue">
          <i class="bi bi-briefcase"></i>
        </div>

        <h2>
          <%= totalJobs %>
        </h2>

        <p>
          Total Jobs Posted
        </p>

      </div>

      <div class="stat-card">

        <div class="stat-icon purple">
          <i class="bi bi-people"></i>
        </div>

        <h2>
          <%= totalApplications %>
        </h2>

        <p>
          Applications Received
        </p>

      </div>

    </div>

    <!-- JOBS -->

    <div class="section">

      <div class="section-top">

        <h2>
          Recent Posted Jobs
        </h2>

        <a href="postJob.jsp"
           class="post-btn">

          + Post New Job

        </a>

      </div>

      <%
        if(recruiterJobs.size() == 0){
      %>

      <div class="empty">

        <i class="bi bi-briefcase"></i>

        <h2>
          No Jobs Posted Yet
        </h2>

        <p>
          Start posting jobs to attract candidates.
        </p>

      </div>

      <%
      } else {
      %>

      <div class="job-list">

      <%

        for(Job job : recruiterJobs){
      %>

        <div class="job-card">

          <div>

            <div class="job-title">

              <h3>
                <%= job.getJobTitle() %>
              </h3>

              <div class="company">
                <%= job.getCompanyName() %>
              </div>

            </div>

            <div class="job-info">

              <div>
                <i class="bi bi-geo-alt"></i>
                <%= job.getLocation() %>
              </div>

              <div>
                <i class="bi bi-cash-stack"></i>
                &#8377;<%= job.getSalary() %>
              </div>

            </div>

          </div>

          <div class="actions">

            <a href="editJob.jsp?id=<%= job.getId() %>">

              <button class="edit-btn">

                Edit

              </button>

            </a>

            <a href="deleteJob?id=<%= job.getId() %>"
               onclick="return confirm('Are you sure you want to delete this job?')">

              <button class="delete-btn">

                Delete

              </button>

            </a>

          </div>

        </div>

      <%
          }
      %>

      </div>

      <%
        }
      %>

    </div>

    </div>

  </main>

</div>

</body>

</html>
