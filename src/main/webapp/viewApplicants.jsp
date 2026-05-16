<%@ page import="java.sql.*" %>
<%@ page import="com.hirevision.util.DBConnection" %>

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
                    "JOIN jobs ON applications.job_id = jobs.id";

    PreparedStatement ps =
            conn.prepareStatement(sql);

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