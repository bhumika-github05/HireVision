<%@ page import="java.sql.*" %>
<%@ page import="com.hirevision.util.DBConnection" %>
<%@ page import="com.hirevision.model.User" %>

<%

  User user =
          (User) session.getAttribute("loggedInUser");

  int userId =
          user.getId();

%>

<!DOCTYPE html>
<html>

<head>

  <title>My Applications</title>

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

    .pending{
      color:orange;
      font-weight:bold;
    }

    .accepted{
      color:green;
      font-weight:bold;
    }

    .rejected{
      color:red;
      font-weight:bold;
    }

  </style>

</head>

<body>

<div class="container">

  <h1>My Applications</h1>

  <%

    Connection conn =
            DBConnection.getConnection();

    String sql =
            "SELECT jobs.job_title, jobs.company_name, " +
                    "applications.status " +
                    "FROM applications " +
                    "JOIN jobs ON applications.job_id = jobs.id " +
                    "WHERE applications.user_id=?";

    PreparedStatement ps =
            conn.prepareStatement(sql);

    ps.setInt(1, userId);

    ResultSet rs =
            ps.executeQuery();

    while(rs.next()){

      String status =
              rs.getString("status");

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

      <b>Status:</b>

      <span class="<%= status.toLowerCase() %>">

            <%= status %>

        </span>

    </p>

  </div>

  <%

    }

    conn.close();

  %>

</div>

</body>

</html>