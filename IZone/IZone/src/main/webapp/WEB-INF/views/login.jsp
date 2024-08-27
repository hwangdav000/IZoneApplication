<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Form</title>
<title>Please sign in</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<%--
	<sec:authorize access="isAuthenticated()">
            <p>Logged in User: ${pageContext.request.userPrincipal.name}</p>
            <sec:authentication property="principal.authorities" var="authorities" />
            <p>Roles:
                <c:forEach items="${authorities}" var="authority">
                    ${authority.authority}&nbsp;
                </c:forEach>
            </p>
   	</sec:authorize>
	--%>
	<div class="container" style="margin-top: 300px;">
			
	    <div class="d-flex justify-content-center form-container">
	        
	        <f:form action="${pageContext.request.contextPath}/login" method="post">
	        	<div class="form-group">
	                <h2 style="color:#007bff;">Login to IZONE</h2>
	            </div>
	            <div class="form-group">
	                <label for="username">Username:</label>
	                <input id="username" class="form-control" type="text" name="username" required>
	            </div>
	
	            <div class="form-group">
	                <label for="password">Password:</label>
	                <input id="password" class="form-control" type="password" name="password" required>
	            </div>
	            
	            <div class="text-muted">
	                Don't have an account? <a href="/userForm">Create one here!</a>
	            </div>
	
	            <input class="btn btn-primary mt-3" type="submit" value="Submit">
	     
	       </f:form>
	    </div>
	</div>

</body>
</html>