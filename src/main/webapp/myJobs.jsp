<%@ page import="java.sql.*" %>
<%@ page import="com.hirevision.util.DBConnection" %>
<%@ page import="com.hirevision.model.User" %>

<%

  User recruiter =
          (User) session.getAttribute("loggedInUser");

  int recruiterId =
          recruiter.getId();

%>

<!DOCTYPE html>
<html>

<head>

  <title>My Posted Jobs</title>

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

    .delete-btn{
      background:red;
      color:white;
      padding:10px 15px;
      text-decoration:none;
      border-radius:5px;
    }

    .delete-btn:hover{
      background:darkred;
    }

    h1{
      text-align:center;
    }

  </style>

</head>

<body>

<div class="container">

  <h1>My Posted Jobs</h1>

  <%

    Connection conn =
            DBConnection.getConnection();

    String sql =
            "SELECT * FROM jobs WHERE posted_by=?";

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
      <b>Company:</b>
      <%= rs.getString("company_name") %>
    </p>

    <p>
      <b>Location:</b>
      <%= rs.getString("location") %>
    </p>

    <p>
      <b>Salary:</b>
      <%= rs.getString("salary") %>
    </p>

    <br>

    <a class="delete-btn"
       href="deleteJob?id=<%= rs.getInt("id") %>"
       onclick="return confirm('Are you sure you want to delete this job?');">

      Delete Job

    </a>

  </div>

  <%

    }

    conn.close();

  %>

</div>

</body>

</html>