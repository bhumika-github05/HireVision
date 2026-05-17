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

    <link rel="stylesheet" href="css/viewJobs.css">


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
