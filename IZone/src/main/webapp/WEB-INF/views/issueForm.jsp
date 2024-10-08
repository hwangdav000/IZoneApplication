<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
		<div class="row justify-content-center mt-3">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header text-center">
                <h3>Issue Creation</h3>
            </div>
            <div class="card-body">

                <f:form action="saveIssue" method="POST" modelAttribute="issue" enctype="multipart/form-data">

                    <div class="form-group col-md-12">
                        <label for="issueType">Issue Type</label>
                        <f:select path="issueType" class="form-control">
                            <c:forEach items="${issueTypes}" var="type">
                                <f:option value="${type}">${type}</f:option>
                            </c:forEach>
                        </f:select>
                        <f:errors path="issueType" class="text-danger"/>
                    </div>

                    <div class="form-group col-md-12">
                        <label for="priority">Priorities</label>
                        <f:select path="priority" class="form-control">
                            <c:forEach items="${priorities}" var="p">
                                <f:option value="${p}">${p}</f:option>
                            </c:forEach>
                        </f:select>
                        <f:errors path="priority" class="text-danger"/>
                    </div>

                    <div class="form-group col-md-12">
                        <label for="issueStatus">Issue Status</label>
                        <f:select path="issueStatus" class="form-control">
                            <c:forEach items="${issueStatuses}" var="status">
                                <f:option value="${status}">${status}</f:option>
                            </c:forEach>
                        </f:select>
                        <f:errors path="issueStatus" class="text-danger"/>
                    </div>

                    <div class="form-group col-md-12">
                        <label for="issueName">Issue Name: </label>
                        <f:input path="issueName" id="issueName" class="form-control" value="${i.issueName}" />
                        <f:errors path="issueName" cssClass="text-danger"/>
                    </div>
                    
                    <div class="form-group col-md-12">
                        <label for="issueSummary">Issue Summary</label>
                        <f:input path="issueSummary" id="issueSummary" class="form-control" value="${i.issueSummary}" />
                        <f:errors path="issueSummary" cssClass="text-danger"/>
                    </div>

                    <div class="form-group col-md-12">
                        <label for="assignee">Assignee</label>
                        <f:input path="assignee" id="assignee" class="form-control" value="${i.assignee}" />
                        <f:errors path="assignee" cssClass="text-danger"/>
                    </div>

                    <div class="form-group col-md-12">
                        <label for="attachments">Attachments</label>
                        <input type="file" name="attachments" id="attachments" class="form-control" multiple />
                    </div>

                    <div class="form-group text-center">
                        <input type="submit" value="Submit" class="btn btn-primary"/>
                    </div>
                </f:form>
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
