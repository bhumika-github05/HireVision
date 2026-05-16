<%@ page import="java.sql.*" %>
<%@ page import="com.hirevision.util.DBConnection" %>
<%@ page import="com.hirevision.model.User" %>

<!DOCTYPE html>
<html>

<head>

  <title>View Applicants</title>

  <style>

    body{
      font-family:Arial;
      background:#f4f4f4;
    }

    .container{
      width:80%;
      margin:30px auto;
    }

    .card{
      background:white;
      padding:20px;
      margin-bottom:20px;
      border-radius:10px;
      box-shadow:0px 0px 10px gray;
    }

    h1{
      text-align:center;
    }

    .resume-btn{
      background:#007bff;
      color:white;
      padding:10px 15px;
      text-decoration:none;
      border-radius:5px;
    }

    .resume-btn:hover{
      background:#0056b3;
    }

  </style>

</head>

<body>

<div class="container">

  <h1>Applicants</h1>

  <%
    User loggedInUser =
            (User) session.getAttribute("loggedInUser");

    if(loggedInUser == null){
        response.sendRedirect("login.jsp");
        return;
    }

    if(!"Recruiter".equals(loggedInUser.getRole())){
        response.sendRedirect("candidateDashboard.jsp");
        return;
    }

    int recruiterId =
            loggedInUser.getId();

    Connection conn =
            DBConnection.getConnection();

    String sql =
            "SELECT applications.id, " +
                    "users.full_name, users.email, " +
                    "jobs.job_title, " +
                    "applications.resume_link, " +
                    "applications.status " +
                    "FROM applications " +
                    "JOIN users ON applications.user_id = users.id " +
                    "JOIN jobs ON applications.job_id = jobs.id " +
                    "WHERE jobs.posted_by = ? " +
                    "ORDER BY applications.id DESC";

    PreparedStatement ps =
            conn.prepareStatement(sql);

    ps.setInt(1, recruiterId);

    ResultSet rs =
            ps.executeQuery();

    while(rs.next()){

  %>

  <div class="card">

    <h2>
      <%= rs.getString("job_title") %>
    </h2>

    <p>
      <b>Candidate:</b>
      <%= rs.getString("full_name") %>
    </p>

    <p>
      <b>Email:</b>
      <%= rs.getString("email") %>
    </p>

    <p>
      <b>Status:</b>
      <%= rs.getString("status") %>
    </p>

    <br>

    <a href="updateApplicationStatus?id=<%= rs.getInt("id") %>&status=Accepted"
       style="
   background:green;
   color:white;
   padding:8px 15px;
   text-decoration:none;
   border-radius:5px;">

      Accept

    </a>

    &nbsp;

    <a href="updateApplicationStatus?id=<%= rs.getInt("id") %>&status=Rejected"
       style="
   background:red;
   color:white;
   padding:8px 15px;
   text-decoration:none;
   border-radius:5px;">

      Reject

    </a>

    <a class="resume-btn"
       href="<%= rs.getString("resume_link") %>"
       target="_blank">

      View Resume

    </a>

  </div>

  <%

    }

    conn.close();

  %>

</div>

</body>

</html>
