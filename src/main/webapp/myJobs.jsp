<%@ page import="java.util.List" %>
<%@ page import="com.hirevision.model.User" %>
<%@ page import="com.hirevision.model.Job" %>
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
%>

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="UTF-8">

  <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

  <title>My Jobs - HireVision</title>

  <link rel="preconnect"
        href="https://fonts.googleapis.com">

  <link rel="preconnect"
        href="https://fonts.gstatic.com"
        crossorigin>

  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">

  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

  <link rel="stylesheet" href="css/myJobs.css">


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

      <a href="recruiterDashboard.jsp">

        <i class="bi bi-house-door"></i>

        Dashboard

      </a>

      <a href="postJob.jsp">

        <i class="bi bi-plus-circle"></i>

        Post Job

      </a>

      <a href="myJobs.jsp"
         class="active">

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

    <div class="topbar">

      <div class="page-title">

        <h1>
          My Jobs
        </h1>

        <p>
          Manage and track all your posted jobs.
        </p>

      </div>

      <div class="profile">

        <div class="profile-avatar">
          <%= loggedInUser.getFullName().substring(0,1).toUpperCase() %>
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

    <div class="job-list">

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

        for(Job job : recruiterJobs){

          int applicantCount =
                  applicationDAO
                          .getApplicationsByJob(
                                  job.getId()
                          ).size();
      %>

      <div class="job-card">

        <div class="card-top">

          <div class="job-title">

            <h2>
              <%= job.getJobTitle() %>
            </h2>

            <div class="company">
              <%= job.getCompanyName() %>
            </div>

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

          <div>
            <i class="bi bi-people"></i>
            <%= applicantCount %> Applicants
          </div>

        </div>

        <div class="description">

          <%= job.getDescription() %>

        </div>

        <div class="actions">

          <a href="editJob.jsp?id=<%= job.getId() %>"
             class="edit-btn">

            Edit Job

          </a>

          <a href="deleteJob?id=<%= job.getId() %>"
             class="delete-btn"
             onclick="return confirm('Are you sure you want to delete this job?')">

            Delete Job

          </a>

          <a href="viewApplicants.jsp?jobId=<%= job.getId() %>"
             class="applicants-btn">

            View Applicants

          </a>

        </div>

      </div>

      <%
          }
        }
      %>

    </div>

  </main>

</div>

</body>

</html>