<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>IZONE - board</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./css/style.css">
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/home">IZONE Board</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
            ${project.projectName}
        </ul>
        <ul class="navbar-nav ml-auto">
            <sec:authorize access="isAuthenticated()">
                <li class="nav-item">
                    <span class="navbar-text" style="color: white;">
                        User: ${pageContext.request.userPrincipal.name}
                        <br/>
                        <sec:authentication property="principal.authorities" var="authorities" />
                        Role:
                        <c:forEach items="${authorities}" var="authority">
                            ${authority.authority}&nbsp;
                        </c:forEach>
                    </span>
                </li>
                <li class="nav-item">
                    <a class="btn btn-danger ml-2 mt-2" href="${pageContext.request.contextPath}/login?logout">Logout</a>
                </li>
            </sec:authorize>
            <sec:authorize access="!isAuthenticated()">
                <li class="nav-item">
                    <a class="btn btn-primary" href="${pageContext.request.contextPath}/login">Login</a>
                </li>
            </sec:authorize>
        </ul>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <nav class="col-md-2 sidebar bg-dark">
            <ul class="nav flex-column">
                <li class="nav-item mt-2">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/board">Board</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/backlog">Backlog</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/issueForm">Add Issue</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/projectEdit">Project Settings</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="${pageContext.request.contextPath}/userEdit">User Settings</a>
                </li>
            </ul>
        </nav>

        <!-- Main Content -->
        <main role="main" class="col-md-10 ml-sm-auto px-4">
            <div class="container mt-5">
			    <div class="row justify-content-center"> 
			        <div class="col-md-8">
			            <div class="card">
			                <div class="card-header text-center">
			                    <h3>Edit Project</h3>
			                </div>
			                <div class="card-body">
			                    <f:form action="${pageContext.request.contextPath}/saveProjectEdit" modelAttribute="project" method="post">
			                        
			                        <div class="form-group">
			                            <label for="projectName">Project Name </label>
			                            <f:input id="projectName" path="projectName" class="form-control" value="${p.projectName}"/>
			                            <f:errors path="projectName" cssClass="text-danger"/>
			                        </div>
			                        <div class="form-group">
			                            <label for="projectKey">Project Key</label>
			                            <f:input id="projectKey" path="projectKey" class="form-control" value="${p.projectKey}"/>
			                            <f:errors path="projectKey" cssClass="text-danger"/>
			                        </div>
			
			                        <!-- Email Invitations Section -->
			                        <div class="form-group">
			                            <label for="userEmails">User Emails</label>
			                            <div id="emailContainer">
			                                <div class="input-group mb-3">
			                                    <input name="userEmails" class="form-control" placeholder="Enter user email" required>
			                                    <div class="input-group-append">
			                                        <button class="btn btn-success add-email" type="button">Add</button>
			                                    </div>
			                                </div>
			                            </div>
			                        </div>
			
			                        <div class="text-center">
			                            <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/actionPage" role="button">Back</a>
			                            <button type="submit" class="btn btn-primary btn-lg">Submit</button>
			                        </div>
			                    </f:form>
			                </div>
			            </div>
			        </div>
			    </div>
			    
		        <div class="container mt-5">
		      
		            <table class="table table-striped table-bordered">
		                <thead>
		                    <tr>
		                        <th>Email List</th>
		                        <th>Action</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <c:forEach items="${p.userEmails}" var="email">
		                        <tr>
		                            <td>${email}</td>
		                            <td><a href="${pageContext.request.contextPath}/deleteEmail?projectId=${p.projectId}&userEmail=${email}" class="btn btn-danger btn-sm">Delete</a></td>
		                        </tr>
		                    </c:forEach>
		                </tbody>
		            </table>
		        </div>
			   
    
			</div>
        </main>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    $(document).ready(function(){
        // Add new email input field
        // TODO change it so that REMOVE references proper email
        $('.add-email').click(function(){
            var emailInputHtml = `
                <div class="input-group mb-3">
                    <input type="email" name="userEmails" class="form-control" placeholder="Enter user email" required>
                    <div class="input-group-append">
                        <button class="btn btn-danger remove-email" type="button">Remove</button>
                    </div>
                </div>`;
            $('#emailContainer').append(emailInputHtml);
        });

        // Remove email input field
        $(document).on('click', '.remove-email', function(){
            $(this).closest('.input-group').remove();
        });
    });
</script>
</body>
</html>
