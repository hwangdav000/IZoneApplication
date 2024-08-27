<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix ="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix ="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>JIRA Application - Home</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>


<div class="container mt-5">
    <div class="jumbotron text-center" style="margin-top: 300px;">
        <h1 class="display-4">Welcome to IZONE!</h1>
        <p class="lead">IZONE is a work management tool for software teams that need to organize and track their work</p>
        <hr class="my-4">
        <p>Get started now!</p>
        <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/login" role="button">Login</a>
        <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/userForm" role="button">Register Account</a>
    </div>
</div>

</body>
</html>
