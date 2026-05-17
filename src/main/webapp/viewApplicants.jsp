<%@ page import="java.util.List" %>
<%@ page import="com.hirevision.model.User" %>
<%@ page import="com.hirevision.model.Job" %>
<%@ page import="com.hirevision.model.Application" %>
<%@ page import="com.hirevision.dao.JobDAO" %>
<%@ page import="com.hirevision.dao.ApplicationDAO" %>
<%@ page import="com.hirevision.dao.UserDAO" %>

<%
  User loggedInUser =
          (User) session.getAttribute("loggedInUser");

  if(loggedInUser == null){
    response.sendRedirect("auth.jsp");
    return;
  }

  if(!"Recruiter".equals(loggedInUser.getRole())){
    response.sendRedirect("candidateDashboard.jsp");
    return;
  }

  JobDAO jobDAO =
          new JobDAO();

  ApplicationDAO applicationDAO =
          new ApplicationDAO();

  UserDAO userDAO =
          new UserDAO();

  List<Job> recruiterJobs =
          jobDAO.getJobsByRecruiter(
                  loggedInUser.getId()
          );

  String jobIdParam =
          request.getParameter("jobId");

  int selectedJobId = 0;

  if(jobIdParam != null){

    selectedJobId =
            Integer.parseInt(jobIdParam);
  }
%>

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="UTF-8">

  <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

  <title>Applicants - HireVision</title>

  <link rel="preconnect"
        href="https://fonts.googleapis.com">

  <link rel="preconnect"
        href="https://fonts.gstatic.com"
        crossorigin>

  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
        rel="stylesheet">

  <link rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

  <link rel="stylesheet" href="css/viewApplicants.css">



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

      <a href="myJobs.jsp">

        <i class="bi bi-briefcase"></i>

        My Jobs

      </a>

      <a href="viewApplicants.jsp"
         class="active">

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
          Applicants
        </h1>

        <p>
          Manage candidates and applications.
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

    <div class="applicants">

      <%
        boolean hasApplicants = false;

        for(Job job : recruiterJobs){

          if(selectedJobId != 0 &&
                  job.getId() != selectedJobId){

            continue;
          }

          List<Application> apps =
                  applicationDAO
                          .getApplicationsByJob(
                                  job.getId()
                          );

          for(Application app : apps){

            hasApplicants = true;

            User candidate =
                    userDAO.getUserById(
                            app.getUserId()
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

            if(candidate == null){
              continue;
            }
      %>

      <div class="applicant-card">

        <div class="card-top">

          <div class="candidate">

            <h2>
              <%= candidate.getFullName() %>
            </h2>

            <p>
              Applied for:
              <%= job.getJobTitle() %>
            </p>

          </div>

          <div class="status
                    <%= statusClass %>">

            <%= status %>

          </div>

        </div>

        <div class="info">

          <div>
            <i class="bi bi-building"></i>
            <%= job.getCompanyName() %>
          </div>

          <div>
            <i class="bi bi-geo-alt"></i>
            <%= job.getLocation() %>
          </div>

          <div>
            <i class="bi bi-cash-stack"></i>
            &#8377;<%= job.getSalary() %>
          </div>

        </div>

        <div class="actions">

          <a href="<%= app.getResumeLink() %>"
             target="_blank"
             class="resume-btn">

            <i class="bi bi-file-earmark-arrow-down"></i>

            View Resume

          </a>

          <a href="updateApplicationStatus?id=<%= app.getId() %>&status=Accepted">

            <button class="accept-btn">

              Accept

            </button>

          </a>

          <a href="updateApplicationStatus?id=<%= app.getId() %>&status=Rejected">

            <button class="reject-btn">

              Reject

            </button>

          </a>

        </div>

      </div>

      <%
          }
        }

        if(!hasApplicants){
      %>

      <div class="empty">

        <i class="bi bi-people"></i>

        <h2>
          No Applicants Yet
        </h2>

        <p>
          Applications from candidates will appear here.
        </p>

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
