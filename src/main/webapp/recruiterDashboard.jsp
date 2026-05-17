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

  <style>

    *{
      margin:0;
      padding:0;
      box-sizing:border-box;
      font-family:'Inter', sans-serif;
    }

    body{

      min-height:100vh;

      background:
              radial-gradient(circle at top left,
              rgba(37,99,235,0.20),
              transparent 30%),

              radial-gradient(circle at bottom right,
              rgba(124,58,237,0.18),
              transparent 30%),

              linear-gradient(
                      135deg,
                      #020617,
                      #030712,
                      #000814
              );

      color:white;

      overflow-x:hidden;
    }

    body::before{

      content:"";

      position:fixed;

      inset:0;

      background:
              linear-gradient(rgba(59,130,246,0.04) 1px, transparent 1px),
              linear-gradient(90deg, rgba(59,130,246,0.04) 1px, transparent 1px);

      background-size:55px 55px;

      pointer-events:none;
    }

    .dashboard{

      display:grid;

      grid-template-columns:250px 1fr;

      min-height:100vh;

      position:relative;

      z-index:1;
    }

    /* SIDEBAR */

    .sidebar{

      background:
              rgba(5,12,28,0.84);

      border-right:
              1px solid rgba(148,163,184,0.12);

      backdrop-filter:blur(18px);

      padding:24px 14px;

      min-height:100vh;
    }

    .logo{

      display:flex;
      align-items:center;
      gap:12px;

      padding:0 10px;

      margin-bottom:42px;
    }

    .logo-icon{

      width:44px;
      height:44px;

      border-radius:13px;

      display:grid;
      place-items:center;

      background:
              linear-gradient(
                      135deg,
                      #2857ff,
                      #7c3aed
              );

      box-shadow:
              0 16px 34px rgba(37,99,235,0.34);

      font-size:24px;
    }

    .logo-text h1{

      font-size:20px;

      font-weight:800;
    }

    .logo-text span{
      color:#2383ff;
    }

    .logo-text p{

      margin-top:6px;

      color:#98a6bc;

      font-size:12px;
    }

    .menu{

      display:grid;

      gap:10px;
    }

    .menu a{

      display:flex;
      align-items:center;
      gap:13px;

      min-height:44px;

      padding:0 14px;

      border-radius:10px;

      color:#b9c4d7;

      text-decoration:none;

      font-size:15px;

      font-weight:600;

      transition:0.3s;
    }

    .menu a:hover,
    .menu a.active{

      color:white;

      background:
              linear-gradient(
                      135deg,
                      rgba(37,99,235,0.42),
                      rgba(37,99,235,0.13)
              );

      box-shadow:
              inset 0 0 0 1px rgba(35,131,255,0.42),
              0 14px 34px rgba(37,99,235,0.18);
    }

    .menu i{

      width:22px;

      color:#a8b5cb;

      font-size:20px;
    }

    .menu a.active i,
    .menu a:hover i{
      color:#2383ff;
    }

    /* MAIN */

    .main{

      padding:24px 34px 34px;
    }

    .content-shell{
      max-width:1260px;
      margin:0 auto;
    }

    .topbar{

      min-height:52px;

      display:flex;

      justify-content:space-between;

      align-items:center;

      margin-bottom:22px;
    }

    .page-title h1{

      font-size:34px;

      font-weight:800;
    }

    .page-title p{

      margin-top:8px;

      color:#9fb0c8;
    }

    .profile{

      display:flex;
      align-items:center;
      gap:12px;
      text-align:left;
    }

    .profile-avatar{
      width:42px;
      height:42px;
      border-radius:12px;
      display:grid;
      place-items:center;
      background:linear-gradient(135deg, #2563eb, #7c3aed);
      font-weight:800;
    }

    .profile h4{

      font-size:16px;
    }

    .profile p{

      margin-top:4px;

      color:#9fb0c8;

      font-size:14px;
    }

    /* STATS */

    .stats{

      display:grid;

      grid-template-columns:
            repeat(2,1fr);

      gap:20px;

      margin-bottom:22px;
    }

    .stat-card{

      background:
              rgba(12,18,32,0.72);

      border:
              1px solid rgba(148,163,184,0.14);

      border-radius:18px;

      padding:22px;

      transition:0.3s;
    }

    .stat-card:hover{

      transform:translateY(-3px);

      box-shadow:
              0 18px 36px rgba(37,99,235,0.14);
    }

    .stat-icon{

      width:54px;
      height:54px;

      border-radius:16px;

      display:flex;
      justify-content:center;
      align-items:center;

      font-size:25px;

      margin-bottom:16px;
    }

    .blue{
      background:rgba(37,99,235,0.16);
      color:#60a5fa;
    }

    .purple{
      background:rgba(124,58,237,0.16);
      color:#a78bfa;
    }

    .stat-card h2{

      font-size:36px;
    }

    .stat-card p{

      margin-top:8px;

      color:#9fb0c8;
    }

    /* SECTION */

    .section{

      background:
              rgba(12,18,32,0.72);

      border:
              1px solid rgba(148,163,184,0.14);

      border-radius:18px;

      padding:26px;

      margin-top:24px;
    }

    .section-top{

      display:flex;

      justify-content:space-between;

      align-items:center;

      margin-bottom:24px;
    }

    .section-top h2{

      font-size:24px;
    }

    .post-btn{

      padding:12px 18px;

      border-radius:12px;

      background:
              linear-gradient(
                      90deg,
                      #3d5bff,
                      #168bff
              );

      color:white;

      text-decoration:none;

      font-weight:700;

      transition:0.3s;
    }

    .post-btn:hover{

      transform:translateY(-2px);

      box-shadow:
              0 14px 28px rgba(35,131,255,0.28);
    }

    /* JOB CARDS */

    .job-list{

      display:grid;

      gap:14px;
    }

    .job-card{

      background:
              rgba(255,255,255,0.03);

      border:
              1px solid rgba(148,163,184,0.12);

      border-radius:15px;

      padding:18px 20px;

      display:flex;

      justify-content:space-between;

      align-items:center;

      transition:0.3s;
    }

    .job-card:hover{

      transform:translateY(-2px);

      box-shadow:
              0 18px 34px rgba(37,99,235,0.12);
    }

    .job-title h3{

      font-size:19px;
    }

    .company{

      margin-top:8px;

      color:#60a5fa;

      font-weight:600;
    }

    .job-info{

      margin-top:14px;

      display:flex;

      gap:18px;

      color:#b8c6da;

      flex-wrap:wrap;
    }

    .job-info div{

      display:flex;

      align-items:center;

      gap:8px;
    }

    .actions{

      display:flex;

      gap:12px;
    }

    .edit-btn,
    .delete-btn{

      padding:11px 16px;

      border:none;

      border-radius:12px;

      color:white;

      font-weight:700;

      cursor:pointer;

      transition:0.3s;
    }

    .edit-btn{

      background:
              linear-gradient(
                      90deg,
                      #2563eb,
                      #3b82f6
              );
    }

    .delete-btn{

      background:
              linear-gradient(
                      90deg,
                      #dc2626,
                      #ef4444
              );
    }

    .edit-btn:hover,
    .delete-btn:hover{

      transform:translateY(-2px);
    }

    .empty{

      text-align:center;

      padding:60px 20px;
    }

    .empty i{

      font-size:80px;

      color:#3b82f6;
    }

    .empty h2{

      margin-top:24px;

      font-size:34px;
    }

    .empty p{

      margin-top:14px;

      color:#9fb0c8;
    }

    @media(max-width:900px){

      .dashboard{
        grid-template-columns:1fr;
      }

      .main{
        padding:20px;
      }

      .sidebar{
        min-height:auto;
      }

      .stats{
        grid-template-columns:1fr;
      }

      .job-card{

        flex-direction:column;

        align-items:flex-start;

        gap:18px;
      }
    }

  </style>

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

      <a href="viewRecruiterJobs.jsp">

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
