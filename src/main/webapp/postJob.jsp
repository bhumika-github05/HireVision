<%@ page import="com.hirevision.model.User" %>

<%
  User loggedInUser =
          (User) session.getAttribute("loggedInUser");

  if(loggedInUser == null){
    response.sendRedirect("auth.jsp");
    return;
  }
%>

<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="UTF-8">

  <meta name="viewport"
        content="width=device-width, initial-scale=1.0">

  <title>Post Job - HireVision</title>

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

    /* FORM CARD */

    .form-card{

      max-width:900px;

      background:
              rgba(12,18,32,0.72);

      border:
              1px solid rgba(148,163,184,0.14);

      border-radius:18px;

      padding:28px;

      box-shadow:
              0 24px 48px rgba(37,99,235,0.10);
    }

    .form-grid{

      display:grid;

      grid-template-columns:1fr 1fr;

      gap:20px;
    }

    .full-width{
      grid-column:1 / -1;
    }

    .input-group{

      display:flex;

      flex-direction:column;

      gap:9px;
    }

    .input-group label{

      color:#dbeafe;

      font-size:15px;

      font-weight:600;
    }

    .input-group input,
    .input-group textarea{

      width:100%;

      border:none;

      outline:none;

      border-radius:12px;

      background:
              rgba(255,255,255,0.04);

      border:
              1px solid rgba(148,163,184,0.14);

      color:white;

      padding:14px 16px;

      font-size:15px;

      transition:0.3s;
    }

    .input-group textarea{

      min-height:150px;

      resize:none;
    }

    .input-group input:focus,
    .input-group textarea:focus{

      border-color:#3b82f6;

      box-shadow:
              0 0 0 4px rgba(59,130,246,0.12);
    }

    .submit-btn{

      margin-top:24px;

      width:100%;

      height:52px;

      border:none;

      border-radius:12px;

      background:
              linear-gradient(
                      90deg,
                      #3d5bff,
                      #168bff
              );

      color:white;

      font-size:17px;

      font-weight:800;

      cursor:pointer;

      transition:0.3s;
    }

    .submit-btn:hover{

      transform:translateY(-2px);

      box-shadow:
              0 18px 36px rgba(35,131,255,0.28);
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

      .form-grid{
        grid-template-columns:1fr;
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

      <a href="postJob.jsp"
         class="active">

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
          Post a New Job
        </h1>

        <p>
          Create opportunities and hire the right talent.
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

    <!-- FORM -->

    <div class="form-card">

      <form action="postJob"
            method="post">

        <div class="form-grid">

          <div class="input-group">

            <label>
              Job Title
            </label>

            <input type="text"
                   name="jobTitle"
                   placeholder="Enter job title"
                   required>

          </div>

          <div class="input-group">

            <label>
              Company Name
            </label>

            <input type="text"
                   name="companyName"
                   placeholder="Enter company name"
                   required>

          </div>

          <div class="input-group">

            <label>
              Location
            </label>

            <input type="text"
                   name="location"
                   placeholder="Enter job location"
                   required>

          </div>

          <div class="input-group">

            <label>
              Salary
            </label>

            <input type="text"
                   name="salary"
                   placeholder="Enter salary package"
                   required>

          </div>

          <div class="input-group full-width">

            <label>
              Job Description
            </label>

            <textarea name="description"
                      placeholder="Describe the role, responsibilities, skills required, benefits, etc."
                      required></textarea>

          </div>

        </div>

        <button type="submit"
                class="submit-btn">

          Post Job

        </button>

      </form>

    </div>

    </div>

  </main>

</div>

</body>

</html>
