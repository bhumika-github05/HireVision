<%@ page import="com.hirevision.model.User" %>
<%@ page import="com.hirevision.dao.JobDAO" %>
<%@ page import="com.hirevision.dao.ApplicationDAO" %>
<%@ page import="com.hirevision.model.Job" %>
<%@ page import="java.util.List" %>

<%
    User loggedInUser =
            (User) session.getAttribute("loggedInUser");

    if(loggedInUser == null){
        response.sendRedirect("auth.jsp");
        return;
    }

    JobDAO jobDAO = new JobDAO();

    ApplicationDAO applicationDAO =
            new ApplicationDAO();

    List<Job> recentJobs =
            jobDAO.getAllJobs();

    int totalJobs =
            recentJobs.size();

    int appliedJobs =
            applicationDAO
                    .getApplicationsByUser(
                            loggedInUser.getId()
                    ).size();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HireVision Dashboard</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{
            min-height:100vh;
            font-family:'Inter', Arial, sans-serif;
            color:#ffffff;
            background:
                    radial-gradient(circle at 8% 12%, rgba(37,99,235,0.22), transparent 30%),
                    radial-gradient(circle at 90% 92%, rgba(124,58,237,0.16), transparent 28%),
                    linear-gradient(135deg, #061226 0%, #030816 48%, #01040d 100%);
            overflow-x:hidden;
        }

        body::before{
            content:"";
            position:fixed;
            inset:0;
            background:
                    linear-gradient(rgba(59,130,246,0.04) 1px, transparent 1px),
                    linear-gradient(90deg, rgba(59,130,246,0.04) 1px, transparent 1px);
            background-size:54px 54px;
            pointer-events:none;
        }

        .dashboard{
            min-height:100vh;
            display:grid;
            grid-template-columns:250px 1fr;
            position:relative;
            z-index:1;
        }

        .sidebar{
            min-height:100vh;
            padding:24px 14px;
            background:rgba(5,12,28,0.84);
            border-right:1px solid rgba(148,163,184,0.12);
            backdrop-filter:blur(18px);
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
            background:linear-gradient(135deg, #2857ff, #7c3aed);
            box-shadow:0 16px 34px rgba(37,99,235,0.34);
            font-size:24px;
        }

        .logo-text h1{
            font-size:20px;
            line-height:1;
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
            transition:background 0.2s ease, color 0.2s ease, box-shadow 0.2s ease;
        }

        .menu a:hover,
        .menu a.active{
            color:#ffffff;
            background:linear-gradient(135deg, rgba(37,99,235,0.42), rgba(37,99,235,0.13));
            box-shadow:inset 0 0 0 1px rgba(35,131,255,0.42), 0 14px 34px rgba(37,99,235,0.18);
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
            min-height:52px;
            display:flex;
            justify-content:flex-end;
            align-items:center;
            margin-bottom:22px;
        }

        .profile{
            display:flex;
            align-items:center;
            gap:12px;
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
            line-height:1.2;
        }

        .profile p{
            margin-top:3px;
            color:#9aa8bf;
            font-size:13px;
        }

        .hero{
            min-height:190px;
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:26px;
            padding:34px;
            border:1px solid rgba(148,163,184,0.14);
            border-radius:18px;
            background:linear-gradient(135deg, rgba(12,18,32,0.78), rgba(5,12,28,0.86));
            box-shadow:0 30px 80px rgba(0,0,0,0.22), inset 0 1px 0 rgba(255,255,255,0.04);
            overflow:hidden;
        }

        .hero h1{
            max-width:620px;
            font-size:38px;
            line-height:1.16;
            font-weight:800;
        }

        .hero h1 span{
            display:block;
            margin-top:8px;
            color:#2383ff;
        }

        .hero p{
            margin-top:18px;
            color:#b8c2d5;
            font-size:18px;
        }

        .hero-visual{
            width:245px;
            height:132px;
            position:relative;
            flex:0 0 auto;
        }

        .hero-card{
            position:absolute;
            right:22px;
            top:4px;
            width:105px;
            height:118px;
            border-radius:15px;
            background:linear-gradient(180deg, rgba(37,99,235,0.74), rgba(30,64,175,0.42));
            box-shadow:0 24px 50px rgba(37,99,235,0.32);
        }

        .hero-card::before{
            content:"";
            position:absolute;
            left:18px;
            top:22px;
            width:24px;
            height:24px;
            border-radius:50%;
            background:#9ee8ff;
        }

        .hero-card::after{
            content:"";
            position:absolute;
            left:18px;
            right:20px;
            top:62px;
            height:34px;
            border-top:6px solid rgba(56,189,248,0.9);
            border-bottom:6px solid rgba(56,189,248,0.52);
        }

        .hero-bag{
            position:absolute;
            left:8px;
            bottom:14px;
            width:112px;
            height:72px;
            border-radius:16px;
            background:linear-gradient(180deg, #0ea5e9, #1d4ed8);
            box-shadow:0 18px 40px rgba(14,165,233,0.38);
        }

        .hero-bag::before{
            content:"";
            position:absolute;
            left:38px;
            top:-22px;
            width:38px;
            height:26px;
            border:8px solid rgba(59,130,246,0.85);
            border-bottom:none;
            border-radius:12px 12px 0 0;
        }

        .hero-lens{
            position:absolute;
            right:0;
            bottom:10px;
            width:64px;
            height:64px;
            border:9px solid #3b82f6;
            border-radius:50%;
            box-shadow:0 0 24px rgba(59,130,246,0.46);
        }

        .hero-lens::after{
            content:"";
            position:absolute;
            right:-25px;
            bottom:-12px;
            width:36px;
            height:8px;
            border-radius:999px;
            background:#3b82f6;
            transform:rotate(45deg);
        }

        .stats{
            display:grid;
            grid-template-columns:repeat(2, minmax(0, 1fr));
            gap:20px;
            margin-top:22px;
        }

        .stat-card,
        .section{
            border:1px solid rgba(148,163,184,0.14);
            background:rgba(12,18,32,0.68);
            box-shadow:inset 0 1px 0 rgba(255,255,255,0.04);
        }

        .stat-card{
            min-height:140px;
            border-radius:18px;
            padding:24px;
        }

        .stat-icon{
            width:54px;
            height:54px;
            display:grid;
            place-items:center;
            border-radius:15px;
            font-size:24px;
            margin-bottom:18px;
        }

        .blue{
            color:#60a5fa;
            background:rgba(37,99,235,0.2);
        }

        .cyan{
            color:#22d3ee;
            background:rgba(6,182,212,0.18);
        }

        .stat-card h2{
            font-size:36px;
            line-height:1;
        }

        .stat-card p{
            margin-top:8px;
            color:#9fb0c8;
            font-size:16px;
        }

        .section{
            margin-top:22px;
            padding:26px;
            border-radius:18px;
        }

        .section-title{
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:18px;
            margin-bottom:20px;
        }

        .section-title h2{
            font-size:24px;
        }

        .view-all{
            color:#2383ff;
            text-decoration:none;
            font-weight:800;
            font-size:15px;
        }

        .job-list{
            display:grid;
            gap:14px;
        }

        .job-card{
            min-height:82px;
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:22px;
            padding:18px 20px;
            border:1px solid rgba(148,163,184,0.12);
            border-radius:15px;
            background:rgba(255,255,255,0.035);
            transition:transform 0.2s ease, border-color 0.2s ease, box-shadow 0.2s ease;
        }

        .job-card:hover{
            transform:translateY(-2px);
            border-color:rgba(35,131,255,0.38);
            box-shadow:0 18px 36px rgba(37,99,235,0.12);
        }

        .job-card h3{
            font-size:19px;
        }

        .job-card p{
            margin-top:7px;
            color:#9fb0c8;
            font-size:15px;
        }

        .apply-btn{
            min-width:132px;
            height:46px;
            border:none;
            border-radius:12px;
            background:linear-gradient(90deg, #3d5bff, #168bff);
            color:white;
            font-size:15px;
            font-weight:800;
            cursor:pointer;
            transition:transform 0.2s ease, box-shadow 0.2s ease;
        }

        .apply-btn:hover{
            transform:translateY(-2px);
            box-shadow:0 16px 30px rgba(35,131,255,0.28);
        }

        @media(max-width:980px){
            .dashboard{
                grid-template-columns:1fr;
            }

            .sidebar{
                min-height:auto;
                position:static;
            }

            .menu{
                grid-template-columns:repeat(4, minmax(0, 1fr));
            }

            .menu a{
                justify-content:center;
            }

            .menu a span{
                display:none;
            }

            .main{
                padding:22px;
            }
        }

        @media(max-width:720px){
            .topbar,
            .hero,
            .job-card{
                align-items:flex-start;
                flex-direction:column;
            }
            .hero-visual{
                display:none;
            }

            .stats{
                grid-template-columns:1fr;
            }

            .apply-btn{
                width:100%;
            }
        }
    </style>
</head>

<body>
<div class="dashboard">
    <aside class="sidebar">
        <div class="logo">
            <div class="logo-icon">
                <i class="bi bi-columns-gap"></i>
            </div>
            <div class="logo-text">
                <h1>Hire<span>Vision</span></h1>
                <p>Smart Hiring, Better Future</p>
            </div>
        </div>

        <nav class="menu">
            <a href="candidateDashboard.jsp" class="active">
                <i class="bi bi-house-door"></i>
                <span>Dashboard</span>
            </a>
            <a href="viewJobs.jsp">
                <i class="bi bi-briefcase"></i>
                <span>Browse Jobs</span>
            </a>
            <a href="myApplications.jsp">
                <i class="bi bi-file-earmark-text"></i>
                <span>My Applications</span>
            </a>
            <a href="auth.jsp">
                <i class="bi bi-box-arrow-right"></i>
                <span>Logout</span>
            </a>
        </nav>
    </aside>

    <main class="main">
        <div class="content-shell">
            <div class="topbar">
                <div class="profile">
                    <div class="profile-avatar">
                        <%= loggedInUser.getFullName().substring(0, 1).toUpperCase() %>
                    </div>
                    <div>
                        <h4><%= loggedInUser.getFullName() %></h4>
                        <p>Candidate</p>
                    </div>
                </div>
            </div>

            <section class="hero">
                <div>
                    <h1>
                        Welcome back,
                        <span><%= loggedInUser.getFullName() %></span>
                    </h1>
                    <p>Find your dream opportunity today.</p>
                </div>

                <div class="hero-visual" aria-hidden="true">
                    <div class="hero-bag"></div>
                    <div class="hero-card"></div>
                    <div class="hero-lens"></div>
                </div>
            </section>

            <section class="stats">
                <div class="stat-card">
                    <div class="stat-icon blue">
                        <i class="bi bi-file-earmark-check"></i>
                    </div>
                    <h2><%= appliedJobs %></h2>
                    <p>Applied Jobs</p>
                </div>

                <div class="stat-card">
                    <div class="stat-icon cyan">
                        <i class="bi bi-briefcase"></i>
                    </div>
                    <h2><%= totalJobs %></h2>
                    <p>Available Jobs</p>
                </div>
            </section>

            <section class="section">
                <div class="section-title">
                    <h2>Recent Jobs</h2>
                    <a href="viewJobs.jsp" class="view-all">View All</a>
                </div>

                <div class="job-list">
                    <%
                        int count = 0;

                        for(Job job : recentJobs){

                            if(count == 3){
                                break;
                            }
                    %>

                    <div class="job-card">
                        <div>
                            <h3><%= job.getJobTitle() %></h3>
                            <p>
                                <%= job.getCompanyName() %>
                                &bull;
                                <%= job.getLocation() %>
                                &bull;
                                &#8377;<%= job.getSalary() %>
                            </p>
                        </div>

                        <a href="viewJobs.jsp">
                            <button class="apply-btn">Apply Now</button>
                        </a>
                    </div>

                    <%
                            count++;
                        }
                    %>
                </div>
            </section>
        </div>
    </main>
</div>
</body>
</html>
