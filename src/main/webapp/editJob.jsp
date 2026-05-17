<%@ page import="com.hirevision.model.User" %>
<%@ page import="com.hirevision.model.Job" %>
<%@ page import="com.hirevision.dao.JobDAO" %>

<%
    User loggedInUser =
            (User) session.getAttribute("loggedInUser");

    if(loggedInUser == null){
        response.sendRedirect("auth.jsp");
        return;
    }

    String jobIdParam =
            request.getParameter("id");

    if(jobIdParam == null){
        response.sendRedirect("myJobs.jsp");
        return;
    }

    int jobId;

    try{
        jobId =
                Integer.parseInt(jobIdParam);
    }catch(NumberFormatException e){
        response.sendRedirect("myJobs.jsp");
        return;
    }

    JobDAO jobDAO =
            new JobDAO();

    Job job =
            jobDAO.getJobById(jobId);

    if(job == null){
        response.sendRedirect("myJobs.jsp");
        return;
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Edit Job - HireVision</title>

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

            min-height:100vh;

            overflow-x:hidden;

            position:relative;
        }

        body::before{

            content:"";

            position:fixed;

            inset:0;

            background:
                    linear-gradient(
                            rgba(59,130,246,0.04) 1px,
                            transparent 1px
                    ),
                    linear-gradient(
                            90deg,
                            rgba(59,130,246,0.04) 1px,
                            transparent 1px
                    );

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
                            #4f46e5,
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

            color:#94a3b8;

            font-size:12px;

            margin-top:6px;
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

            transition:0.3s;

            font-size:15px;

            font-weight:600;
        }

        .menu a:hover,
        .menu .active{

            background:
                    linear-gradient(
                            135deg,
                            rgba(37,99,235,0.42),
                            rgba(37,99,235,0.13)
                    );

            color:white;

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

        .main{

            padding:24px 34px 34px;
        }

        .content-shell{

            max-width:1260px;

            margin:0 auto;
        }

        .topbar{

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

            color:#94a3b8;

            margin-top:8px;
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

            background:
                    linear-gradient(
                            135deg,
                            #3b82f6,
                            #7c3aed
                    );

            font-weight:800;
        }

        .profile h4{

            font-size:16px;
        }

        .profile p{

            color:#94a3b8;

            margin-top:4px;

            font-size:14px;
        }

        .form-card{

            max-width:900px;

            background:
                    rgba(12,18,32,0.72);

            border:
                    1px solid rgba(148,163,184,0.12);

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

            font-size:15px;

            font-weight:600;

            color:#dbeafe;
        }

        .input-group input,
        .input-group textarea{

            width:100%;

            background:
                    rgba(255,255,255,0.04);

            border:
                    1px solid rgba(148,163,184,0.12);

            border-radius:12px;

            padding:15px 16px;

            color:white;

            font-size:15px;

            outline:none;
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

            width:100%;

            height:52px;

            border:none;

            border-radius:12px;

            padding:0 16px;

            background:
                    linear-gradient(
                            90deg,
                            #3758f9,
                            #2f8cff
                    );

            color:white;

            font-size:17px;

            font-weight:700;

            cursor:pointer;

            margin-top:24px;

            transition:0.3s;
        }

        .submit-btn:hover{

            transform:translateY(-2px);

            box-shadow:
                    0 12px 30px rgba(59,130,246,0.35);
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

            .topbar{
                align-items:flex-start;
                flex-direction:column;
                gap:16px;
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

        <div class="content-shell">

            <div class="topbar">

                <div class="page-title">

                    <h1>Edit Job</h1>

                    <p>
                        Update your posted job details.
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

            <div class="form-card">

                <form action="updateJob"
                      method="post">

                    <input type="hidden"
                           name="id"
                           value="<%= job.getId() %>">

                    <div class="form-grid">

                        <div class="input-group">

                            <label>Job Title</label>

                            <input type="text"
                                   name="title"
                                   value="<%= job.getJobTitle() %>"
                                   required>

                        </div>

                        <div class="input-group">

                            <label>Company Name</label>

                            <input type="text"
                                   name="company"
                                   value="<%= job.getCompanyName() %>"
                                   required>

                        </div>

                        <div class="input-group">

                            <label>Location</label>

                            <input type="text"
                                   name="location"
                                   value="<%= job.getLocation() %>"
                                   required>

                        </div>

                        <div class="input-group">

                            <label>Salary</label>

                            <input type="text"
                                   name="salary"
                                   value="<%= job.getSalary() %>"
                                   required>

                        </div>

                        <div class="input-group full-width">

                            <label>Description</label>

                            <textarea name="description"
                                      required><%= job.getDescription() %></textarea>

                        </div>

                    </div>

                    <button class="submit-btn"
                            type="submit">

                        Update Job

                    </button>

                </form>

            </div>

        </div>

    </main>

</div>

</body>

</html>
