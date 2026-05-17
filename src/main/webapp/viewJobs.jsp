<%@ page import="java.util.List" %>
<%@ page import="com.hirevision.dao.JobDAO" %>
<%@ page import="com.hirevision.dao.ApplicationDAO" %>
<%@ page import="com.hirevision.model.Job" %>
<%@ page import="com.hirevision.model.User" %>

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

    List<Job> jobs =
            jobDAO.getAllJobs();
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Browse Jobs - HireVision</title>

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

        /* SEARCH */

        .search-box{

            margin-bottom:22px;

            position:relative;
        }

        .search-box i{

            position:absolute;

            left:18px;

            top:50%;

            transform:translateY(-50%);

            color:#94a3b8;
        }

        .search-box input{

            width:100%;

            height:46px;

            border:none;

            outline:none;

            border-radius:12px;

            padding-left:52px;

            background:
                    rgba(2,6,23,0.44);

            border:
                    1px solid rgba(148,163,184,0.18);

            color:white;

            font-size:15px;
        }

        /* JOB GRID */

        .job-grid{

            display:grid;

            grid-template-columns:
            repeat(auto-fit, minmax(300px, 1fr));

            gap:18px;
        }

        .job-card{

            background:
                    rgba(12,18,32,0.68);

            border:
                    1px solid rgba(148,163,184,0.14);

            border-radius:18px;

            padding:22px;

            transition:0.3s;

            position:relative;

            overflow:hidden;
        }

        .job-card:hover{

            transform:translateY(-2px);

            border-color:
                    rgba(35,131,255,0.38);

            box-shadow:
                    0 20px 40px rgba(37,99,235,0.14);
        }

        .job-card.hidden{
            display:none;
        }

        .empty-state{
            display:none;
            padding:28px;
            border:1px solid rgba(148,163,184,0.14);
            border-radius:18px;
            background:rgba(12,18,32,0.68);
            color:#9fb0c8;
            text-align:center;
        }

        .empty-state.show{
            display:block;
        }

        .job-top{

            display:flex;

            justify-content:space-between;

            align-items:flex-start;

            margin-bottom:18px;
        }

        .job-title h2{

            font-size:20px;

            line-height:1.3;
        }

        .company{

            margin-top:8px;

            color:#2383ff;

            font-weight:600;
        }

        .salary{

            padding:9px 13px;

            border-radius:12px;

            background:
                    rgba(37,99,235,0.16);

            color:#60a5fa;

            font-weight:700;

            font-size:14px;
        }

        .job-info{

            display:flex;

            gap:18px;

            margin-top:16px;

            color:#b7c4d8;

            font-size:14px;

            flex-wrap:wrap;
        }

        .job-info div{

            display:flex;

            align-items:center;

            gap:8px;
        }

        .description{

            margin-top:20px;

            color:#aebcd1;

            line-height:1.7;

            font-size:15px;
        }

        .bottom{

            margin-top:24px;
        }

        .file-label{

            width:100%;

            height:46px;

            border-radius:12px;

            border:
                    1px dashed rgba(96,165,250,0.45);

            display:flex;

            justify-content:center;

            align-items:center;

            gap:10px;

            cursor:pointer;

            color:#c7d2fe;

            transition:0.3s;

            background:
                    rgba(255,255,255,0.02);
        }

        .file-label:hover{

            background:
                    rgba(37,99,235,0.10);

            border-color:#3b82f6;
        }

        .file-input{
            display:none;
        }

        .file-name{
            display:block;
            min-height:18px;
            margin-top:8px;
            color:#9fb0c8;
            font-size:13px;
            word-break:break-word;
        }

        .apply-btn{

            width:100%;

            height:48px;

            margin-top:16px;

            border:none;

            border-radius:12px;

            background:
                    linear-gradient(
                            90deg,
                            #3d5bff,
                            #168bff
                    );

            color:white;

            font-size:15px;

            font-weight:800;

            cursor:pointer;

            transition:0.3s;
        }

        .apply-btn:hover{

            transform:translateY(-2px);

            box-shadow:
                    0 16px 30px rgba(35,131,255,0.28);
        }

        .applied-btn{

            width:100%;

            height:48px;

            border:none;

            border-radius:12px;

            background:#334155;

            color:#cbd5e1;

            font-size:15px;

            font-weight:700;

            cursor:not-allowed;
        }

        @media(max-width:900px){

            .dashboard{
                grid-template-columns:1fr;
            }

            .sidebar{
                min-height:auto;
            }

            .main{
                padding:20px;
            }

            .topbar{
                flex-direction:column;
                align-items:flex-start;
                gap:12px;
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

            <a href="viewJobs.jsp"
               class="active">

                <i class="bi bi-briefcase"></i>

                Browse Jobs

            </a>

            <a href="myApplications.jsp">

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
                    Browse Jobs
                </h1>

                <p>
                    Explore opportunities tailored for you.
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

        <!-- SEARCH -->

        <div class="search-box">

            <i class="bi bi-search"></i>

            <input type="text"
                   id="searchInput"
                   placeholder="Search by role, company or location...">

        </div>

        <!-- JOBS -->

        <div class="job-grid"
             id="jobGrid">

            <%
                for(Job job : jobs){

                    boolean alreadyApplied =
                            applicationDAO.hasAlreadyApplied(
                                    loggedInUser.getId(),
                                    job.getId()
                            );
            %>

            <div class="job-card searchable">

                <div class="job-top">

                    <div class="job-title">

                        <h2>
                            <%= job.getJobTitle() %>
                        </h2>

                        <div class="company">
                            <%= job.getCompanyName() %>
                        </div>

                    </div>

                    <div class="salary">

                        &#8377;<%= job.getSalary() %>

                    </div>

                </div>

                <div class="job-info">

                    <div>
                        <i class="bi bi-geo-alt"></i>
                        <%= job.getLocation() %>
                    </div>

                    <div>
                        <i class="bi bi-briefcase"></i>
                        Full Time
                    </div>

                </div>

                <div class="description">

                    <%= job.getDescription() %>

                </div>

                <div class="bottom">

                    <%
                        if(alreadyApplied){
                    %>

                    <button class="applied-btn"
                            disabled>

                        Applied

                    </button>

                    <%
                    } else {
                    %>

                    <form action="applyJob"
                          method="post"
                          enctype="multipart/form-data">

                        <input type="hidden"
                               name="jobId"
                               value="<%= job.getId() %>">

                        <label class="file-label">

                            <i class="bi bi-upload"></i>

                            Upload Resume

                            <input type="file"
                                   name="resume"
                                   class="file-input"
                                   onchange="showSelectedFile(this)"
                                   required>

                        </label>

                        <span class="file-name">
                            No file selected
                        </span>

                        <button type="submit"
                                class="apply-btn">

                            Apply Now

                        </button>

                    </form>

                    <%
                        }
                    %>

                </div>

            </div>

            <%
                }
            %>

        </div>

        <div class="empty-state"
             id="emptyState">
            No jobs found for your search.
        </div>

        </div>

    </main>

</div>

<script>

    const searchInput =
        document.getElementById("searchInput");

    const emptyState =
        document.getElementById("emptyState");

    searchInput.addEventListener("input", searchJobs);

    function searchJobs(){

        const input =
            searchInput
                .value
                .trim()
                .toLowerCase();

        const cards =
            document.querySelectorAll(".searchable");

        let visibleCount = 0;

        cards.forEach(function(card){

            const text =
                [
                    card.querySelector(".job-title")?.textContent,
                    card.querySelector(".company")?.textContent,
                    card.querySelector(".job-info")?.textContent,
                    card.querySelector(".description")?.textContent
                ]
                    .join(" ")
                    .toLowerCase();

            const matches =
                text.includes(input);

            card.classList.toggle("hidden", !matches);

            if(matches){
                visibleCount++;
            }
        });

        emptyState.classList.toggle("show", visibleCount === 0);
    }

    function showSelectedFile(input){

        const fileName =
            input.files.length > 0
                ? input.files[0].name
                : "No file selected";

        const label =
            input
                .closest("form")
                .querySelector(".file-name");

        label.textContent = fileName;
    }

</script>

</body>

</html>
