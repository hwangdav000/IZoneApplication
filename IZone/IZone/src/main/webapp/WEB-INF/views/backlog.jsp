<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>IZONE - Board</title>
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
        <main role="main" class="col-md-10 ml-sm-auto px-4 mt-3 ml-2">
            <h2>Issues</h2>
            
            <!-- Search Bar -->
            <div class="mb-3">
                <input type="text" id="issueSearch" class="form-control" placeholder="Search for issues...">
            </div>
            
            <!-- Issues Table -->
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Issue Name</th>
                        <th>Summary</th>
                        <th>Assignee</th>
                        <th>Priority</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody id="issuesTable">
                    <c:forEach items="${issues}" var="issue">
                        <tr>
                            <td>${issue.issueName}</td>
                            <td>${issue.issueSummary}</td>
                            <td>${issue.assignee}</td>
                            <td>${issue.priority}</td>
                            <td>${issue.issueStatus}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/issue/${issue.issueId}" class="btn btn-primary">View Issue</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </main>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    $(document).ready(function(){
        // Search functionality
        $("#issueSearch").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#issuesTable tr").filter(function() {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>

</body>
</html>
