<!DOCTYPE html>
<html>
<head>
    <title>HireVision Register</title>

    <style>

        body{
            font-family: Arial;
            background:#f4f4f4;
        }

        .container{
            width:400px;
            margin:50px auto;
            background:white;
            padding:20px;
            border-radius:10px;
        }

        input, select{
            width:100%;
            padding:10px;
            margin-top:10px;
        }

        button{
            width:100%;
            padding:10px;
            margin-top:15px;
            background:#007bff;
            color:white;
            border:none;
            cursor:pointer;
        }

        button:hover{
            background:#0056b3;
        }

    </style>

</head>

<body>

<div class="container">

    <h2>User Registration</h2>

    <form action="register" method="post">

        <input type="text"
               name="fullName"
               placeholder="Enter Full Name"
               required>

        <input type="email"
               name="email"
               placeholder="Enter Email"
               required>

        <input type="password"
               name="password"
               placeholder="Enter Password"
               required>

        <select name="role">

            <option value="Candidate">Candidate</option>
            <option value="Recruiter">Recruiter</option>

        </select>

        <button type="submit">
            Register
        </button>

    </form>

</div>

</body>
</html>