<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
  <title>Recruiter Dashboard</title>

  <style>
    body{
      font-family: Arial;
      background:#f4f4f4;
      text-align:center;
    }

    .box{
      width:500px;
      margin:100px auto;
      background:white;
      padding:30px;
      border-radius:10px;
      box-shadow:0px 0px 10px gray;
    }

    h1{
      color:#007bff;
    }
  </style>
</head>

<body>

<div class="box">

  <h1>Recruiter Dashboard</h1>

  <h2>
    Welcome,
    <%= session.getAttribute("userName") %>
  </h2>

  <p>
    Role:
    <%= session.getAttribute("userRole") %>
  </p>

  <br><br>

  <a href="logout"
     style="
   background:red;
   color:white;
   padding:10px 20px;
   text-decoration:none;
   border-radius:5px;">
    Logout
  </a>

</div>

</body>
</html>