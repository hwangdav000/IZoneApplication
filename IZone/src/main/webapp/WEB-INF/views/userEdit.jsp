<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/userSettingPage">User Settings</a>
                </li>
            </ul>
        </nav>

        <!-- Main Content -->
        <main role="main" class="col-md-10 ml-sm-auto px-4">
            <div class="pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Design Board</h1>
            </div>

            <div class="row">
                <!-- TO DO -->
                <div class="col-md-4">
                    <div class="card h-100 mb-4 shadow-sm d-flex flex-column">
                        <div class="card-body flex-grow-1 d-flex flex-column">
                            <h5 class="card-title">To Do</h5>
                            
                            <p class="card-text flex-grow-1">Overview of all your projects.</p>
                            
                            <a href="${pageContext.request.contextPath}/projects" class="btn btn-primary mt-auto">View Projects</a>
                        </div>
                    </div>
                </div>

                <!-- IN PROGRESS -->
                <div class="col-md-4">
                    <div class="card h-100 mb-4 shadow-sm d-flex flex-column">
                        <div class="card-body flex-grow-1 d-flex flex-column">
                            <h5 class="card-title">In Progress</h5>
                            <p class="card-text flex-grow-1">See what's been happening lately.</p>
                            <a href="${pageContext.request.contextPath}/activities" class="btn btn-primary mt-auto">View Activities</a>
                        </div>
                    </div>
                </div>

                <!-- DONE -->
                <div class="col-md-4">
                    <div class="card h-100 mb-4 shadow-sm d-flex flex-column">
                        <div class="card-body flex-grow-1 d-flex flex-column">
                            <h5 class="card-title">Done</h5>
                            <p class="card-text flex-grow-1">Tasks assigned to you.</p>
                            <a href="${pageContext.request.contextPath}/tasks" class="btn btn-primary mt-auto">View Tasks</a>
                        </div>
                    </div>
                </div>
            </div>

        </main>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
