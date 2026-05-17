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

    /* APPLICANT CARD */

    .applicants{

      display:grid;

      gap:20px;
    }

    .applicant-card{

      background:
              rgba(12,18,32,0.72);

      border:
              1px solid rgba(148,163,184,0.14);

      border-radius:24px;

      padding:28px;

      transition:0.3s;
    }

    .applicant-card:hover{

      transform:translateY(-3px);

      box-shadow:
              0 18px 36px rgba(37,99,235,0.14);
    }

    .card-top{

      display:flex;

      justify-content:space-between;

      align-items:flex-start;

      margin-bottom:20px;
    }

    .candidate h2{

      font-size:26px;
    }

    .candidate p{

      margin-top:8px;

      color:#60a5fa;

      font-weight:600;
    }

    .status{

      padding:10px 18px;

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

      margin-bottom:24px;
    }

    .info div{

      display:flex;

      align-items:center;

      gap:8px;
    }

    .actions{

      display:flex;

      gap:14px;

      flex-wrap:wrap;
    }

    .resume-btn,
    .accept-btn,
    .reject-btn{

      padding:12px 18px;

      border:none;

      border-radius:12px;

      color:white;

      font-weight:700;

      cursor:pointer;

      text-decoration:none;

      transition:0.3s;
    }

    .resume-btn{

      background:
              linear-gradient(
                      90deg,
                      #3d5bff,
                      #168bff
              );
    }
    .accept-btn{

      background:
              linear-gradient(
                      135deg,
                      #34d399,
                      #6ee7b7
              );

      color:#06281f;

      box-shadow:
              0 8px 20px rgba(110,231,183,0.18);
    }

    .reject-btn{

      background:
              linear-gradient(
                      135deg,
                      #f87171,
                      #fca5a5
              );

      color:#3b0a0a;

      box-shadow:
              0 8px 20px rgba(248,113,113,0.18);
    }

    .resume-btn:hover,
    .accept-btn:hover,
    .reject-btn:hover{

      transform:translateY(-2px);
    }

    .empty{

      text-align:center;

      padding:80px 20px;
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

      .card-top{
        flex-direction:column;
        gap:14px;
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
