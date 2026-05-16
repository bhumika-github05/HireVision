<%@ page import="java.util.List" %>
<%@ page import="com.hirevision.dao.JobDAO" %>
<%@ page import="com.hirevision.model.Job" %>
<%@ page import="com.hirevision.model.User" %>
<%@ page import="com.hirevision.dao.ApplicationDAO" %>

<%
    JobDAO dao = new JobDAO();

    List<Job> jobs = dao.getAllJobs();

    User loggedInUser =
            (User) session.getAttribute("loggedInUser");

    ApplicationDAO applicationDAO =
            new ApplicationDAO();
%>

<!DOCTYPE html>
<html>

<head>

    <title>Available Jobs</title>

    <style>

        body{
            font-family: Arial;
            background:#f4f4f4;
        }

        .container{
            width:80%;
            margin:30px auto;
        }

        .job-card{
            background:white;
            padding:20px;
            margin-bottom:20px;
            border-radius:10px;
            box-shadow:0px 0px 10px gray;
        }

        .apply-btn{
            background:#28a745;
            color:white;
            padding:10px 20px;
            border:none;
            border-radius:5px;
            cursor:pointer;
            transition:0.3s;
        }

        .apply-btn:hover{
            background:#218838;
            transform:scale(1.05);
        }

        .applied-btn{
            background:gray;
            color:white;
            padding:10px 20px;
            border:none;
            border-radius:5px;
            cursor:not-allowed;
        }

        h1{
            text-align:center;
        }

        h2{
            color:#007bff;
        }

    </style>

</head>

<body>

<div class="container">

    <h1>Available Jobs</h1>

    <%
        for(Job job : jobs){

            boolean alreadyApplied =
                    applicationDAO.hasAlreadyApplied(
                            loggedInUser.getId(),
                            job.getId()
                    );
    %>

    <div class="job-card">

        <h2>
            <%= job.getJobTitle() %>
        </h2>

        <p>
            <b>Company:</b>
            <%= job.getCompanyName() %>
        </p>

        <p>
            <b>Location:</b>
            <%= job.getLocation() %>
        </p>

        <p>
            <b>Salary:</b>
            <%= job.getSalary() %>
        </p>

        <p>
            <b>Description:</b>
            <%= job.getDescription() %>
        </p>

        <br>

        <%
            if(alreadyApplied){
        %>

        <button
                disabled
                class="applied-btn">

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

            <input type="file"
                   name="resume"
                   required>

            <br><br>

            <button type="submit"
                    class="apply-btn">

                Apply Now

            </button>

        </form>

        <%
            }
        %>

    </div>

    <%
        }
    %>

</div>

</body>

</html>