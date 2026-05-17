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
            repeat(4,1fr);

      gap:20px;

      margin-bottom:22px;
    }

    .stat-card{

      background:
              rgba(12,18,32,0.72);

      border:
              1px solid rgba(148,163,184,0.14);

      border-radius:18px;

      padding:20px;

      transition:0.3s;
    }

    .stat-card:hover{

      transform:translateY(-3px);

      box-shadow:
              0 16px 32px rgba(37,99,235,0.14);
    }

    .stat-icon{

      width:52px;
      height:52px;

      border-radius:14px;

      display:flex;
      justify-content:center;
      align-items:center;

      font-size:24px;

      margin-bottom:14px;
    }

    .blue{
      background:rgba(37,99,235,0.16);
      color:#60a5fa;
    }

    .yellow{
      background:rgba(234,179,8,0.16);
      color:#facc15;
    }

    .green{
      background:rgba(34,197,94,0.16);
      color:#4ade80;
    }

    .red{
      background:rgba(239,68,68,0.16);
      color:#f87171;
    }

    .stat-card h2{

      font-size:32px;
    }

    .stat-card p{

      margin-top:8px;

      color:#9fb0c8;
    }

    /* APPLICATIONS */

    .applications{

      display:grid;

      gap:14px;
    }

    .application-card{

      background:
              rgba(12,18,32,0.72);

      border:
              1px solid rgba(148,163,184,0.14);

      border-radius:18px;

      padding:22px;

      transition:0.3s;
    }

    .application-card:hover{

      transform:translateY(-2px);

      box-shadow:
              0 18px 36px rgba(37,99,235,0.14);
    }

    .card-top{

      display:flex;

      justify-content:space-between;

      align-items:flex-start;

      margin-bottom:20px;
    }

    .job-title h2{

      font-size:20px;
    }

    .company{

      margin-top:8px;

      color:#60a5fa;

      font-weight:600;
    }

    .status{

      padding:8px 14px;

      border-radius:999px;

      font-size:14px;

      font-weight:700;
    }

    .pending{
      background:rgba(234,179,8,0.18);
      color:#facc15;
    }

    .accepted{
      background:rgba(34,197,94,0.18);
      color:#4ade80;
    }

    .rejected{
      background:rgba(239,68,68,0.18);
      color:#f87171;
    }

    .info{

      display:flex;

      gap:22px;

      flex-wrap:wrap;

      color:#b6c3d7;

      margin-bottom:20px;
    }

    .info div{

      display:flex;

      align-items:center;

      gap:8px;
    }

    .resume-btn{

      display:inline-flex;

      align-items:center;

      gap:10px;

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

    .resume-btn:hover{

      transform:translateY(-2px);

      box-shadow:
              0 14px 28px rgba(35,131,255,0.28);
    }

    /* EMPTY */

    .empty{

      padding:56px 20px;

      text-align:center;

      background:
              rgba(12,18,32,0.72);

      border:
              1px solid rgba(148,163,184,0.14);

      border-radius:18px;
    }

    .empty i{

      font-size:58px;

      color:#3b82f6;
    }

    .empty h2{

      margin-top:24px;

      font-size:26px;
    }

    .empty p{

      margin-top:14px;

      color:#9fb0c8;

      font-size:18px;
    }

    @media(max-width:1000px){

      .stats{
        grid-template-columns:1fr 1fr;
      }
    }

    @media(max-width:850px){

      .dashboard{
        grid-template-columns:1fr;
      }

      .sidebar{
        min-height:auto;
      }

      .topbar{
        flex-direction:column;
        align-items:flex-start;
        gap:12px;
      }

      .stats{
        grid-template-columns:1fr;
      }

      .main{
        padding:20px;
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
