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

  <link rel="stylesheet" href="css/postJob.css">



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
