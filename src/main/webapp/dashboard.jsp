<%@ page import="com.hirevision.model.User" %>

<%
    User user =
            (User) session.getAttribute("loggedInUser");

    if(user == null){
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>

<head>

    <title>Dashboard</title>

    <style>

        body{
            font-family: Arial;
            background:#f4f4f4;
        }

        .container{
            width:500px;
            margin:100px auto;
            background:white;
            padding:30px;
            border-radius:10px;
            text-align:center;
        }

        h1{
            color:#28a745;
        }

    </style>

</head>

<body>

<div class="container">

    <h1>Welcome to HireVision</h1>

    <h2>
        Hello,
        <%= user.getFullName() %>
    </h2>

    <p>
        Role:
        <%= user.getRole() %>
    </p>

</div>

</body>
</html>