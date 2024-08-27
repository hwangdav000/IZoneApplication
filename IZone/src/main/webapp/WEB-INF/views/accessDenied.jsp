<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Access Denied</title>
</head>
<body>
<div align="center">
<h1>Synergisticit</h1>
<h3>Access Denied</h3>
Hi <Strong>${pageContext.request.userPrincipal.name}</Strong>, you are not authorized to access this page.
<br>Please click the home link below to get to home page:
<br><a href="${pageContext.request.contextPath}/home">Home</a>

</div>
</body>
</html>