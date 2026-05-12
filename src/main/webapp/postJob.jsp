<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>

  <title>Post Job</title>

  <style>

    body{
      font-family: Arial;
      background:#f4f4f4;
    }

    .container{
      width:500px;
      margin:50px auto;
      background:white;
      padding:30px;
      border-radius:10px;
      box-shadow:0px 0px 10px gray;
    }

    input, textarea{
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

  <h2>Post New Job</h2>

  <form action="${pageContext.request.contextPath}/postJob"
        method="post">

    <input type="text"
           name="jobTitle"
           placeholder="Job Title"
           required>

    <input type="text"
           name="companyName"
           placeholder="Company Name"
           required>

    <input type="text"
           name="location"
           placeholder="Location"
           required>

    <input type="text"
           name="salary"
           placeholder="Salary"
           required>

    <textarea name="description"
              placeholder="Job Description"
              rows="5"
              required></textarea>

    <button type="submit">
      Post Job
    </button>

  </form>

</div>

</body>

</html>