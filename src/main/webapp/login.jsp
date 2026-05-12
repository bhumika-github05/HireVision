<!DOCTYPE html>
<html>

<head>
    <title>HireVision Login</title>

    <style>

        body{
            font-family: Arial;
            background:#f4f4f4;
        }

        .container{
            width:400px;
            margin:100px auto;
            background:white;
            padding:20px;
            border-radius:10px;
        }

        input{
            width:100%;
            padding:10px;
            margin-top:10px;
        }

        button{
            width:100%;
            padding:10px;
            margin-top:15px;
            background:#28a745;
            color:white;
            border:none;
            cursor:pointer;
        }

        button:hover{
            background:#218838;
        }

    </style>

</head>

<body>

<div class="container">

    <h2>User Login</h2>

    <form action="${pageContext.request.contextPath}/login"
          method="post">

        <input type="email"
               name="email"
               placeholder="Enter Email"
               required>

        <input type="password"
               name="password"
               placeholder="Enter Password"
               required>

        <button type="submit">
            Login
        </button>

    </form>

</div>

</body>
</html>