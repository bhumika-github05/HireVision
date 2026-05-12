<%@ page import="java.util.List" %>
<%@ page import="com.hirevision.dao.JobDAO" %>
<%@ page import="com.hirevision.model.Job" %>

<%
    JobDAO dao = new JobDAO();

    List<Job> jobs = dao.getAllJobs();
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

    </div>

    <%
        }
    %>

</div>

</body>

</html>