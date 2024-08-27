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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	
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
            <div class="pt-3 pb-2 mb-3 border-bottom">
                <h1 class="h2">Design Board</h1>
            </div>

            <div class="row">
                <!-- TO DO -->
                <div class="col-md-4">
                    <div class="card h-100 mb-4 shadow-sm d-flex flex-column">
                        <div class="card-body flex-grow-1 d-flex flex-column">
                            <h5 class="card-title">To Do</h5>
                            <a href="${pageContext.request.contextPath}/issueForm" class="btn btn-primary mb-3">Add Issue</a>
                            
                            <!-- List Issues in 'To Do' -->
                            <c:forEach items="${todoIssues}" var="issue">
                                <div class="issue-item">
                                    <h6>${issue.issueName}</h6>
                                    <p class="card-text">Assignee: ${issue.assignee}</p>
                                    <p class="card-text">${issue.issueSummary}</p>
                                    <button class="btn btn-secondary btn-sm view-issue-btn" value="${issue.issueId}">View Issue</button>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- IN PROGRESS -->
                <div class="col-md-4">
                    <div class="card h-100 mb-4 shadow-sm d-flex flex-column">
                        <div class="card-body flex-grow-1 d-flex flex-column">
                            <h5 class="card-title">In Progress</h5>
                            <a href="${pageContext.request.contextPath}/issueForm" class="btn btn-primary mb-3">Add Issue</a>
                            
                            <!-- List Issues in 'In Progress' -->
                            <c:forEach items="${inProgressIssues}" var="issue">
                                <div class="issue-item">
                                    <h6>${issue.issueName}</h6>
                                    <p class="card-text">Assignee: ${issue.assignee}</p>
                                    <p class="card-text">${issue.issueSummary}</p>
                                    <button class="btn btn-secondary btn-sm view-issue-btn" value="${issue.issueId}">View Issue</button>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>

                <!-- DONE -->
                <div class="col-md-4">
                    <div class="card h-100 mb-4 shadow-sm d-flex flex-column">
                        <div class="card-body flex-grow-1 d-flex flex-column">
                            <h5 class="card-title">Done</h5>
                            <a href="${pageContext.request.contextPath}/issueForm" class="btn btn-primary mb-3">Add Issue</a>
                            
                            <!-- List Issues in 'Done' -->
                            <c:forEach items="${doneIssues}" var="issue">
                                <div class="issue-item">
                                    <h6>${issue.issueName}</h6>
                                    <p class="card-text">Assignee: ${issue.assignee}</p>
                                    <p class="card-text">${issue.issueSummary}</p>
                                    <button class="btn btn-secondary btn-sm view-issue-btn" value="${issue.issueId}">View Issue</button>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>

        </main>
    </div>
</div>

<div class="modal fade" id="issueModal" tabindex="-1" role="dialog" aria-labelledby="issueModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="issueModalLabel">Issue Details</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <!-- Issue Details -->
        <div class="container">
          <form id="issueForm">
            <div class="row">
              <div class="col-md-4">
                <h6><strong>Issue Name:</strong></h6>
                <div class="d-none d-md-block">
                  <p id="issueName"></p>
                </div>
                <input type="text" class="form-control d-md-none" id="issueNameInput" value="Login Issue" disabled>
              </div>
            
              <div class="col-md-4">
                <h6><strong>Issue ID:</strong></h6>
                <p id="issueId"></p>
              </div>
              <div class="col-md-4">
                <h6><strong>Created Date:</strong></h6>
                <p id="createdDateTime"></p>
              </div>
              
            </div>
            <div class="row">
            	<div class="col-md-4">
	                <h6><strong>Issue Type:</strong></h6>
	                <div class="d-none d-md-block">
	                  <p id="issueType"></p>
	                </div>
	                <input type="text" class="form-control d-md-none" id="issueTypeInput" value="Bug" disabled>
              </div>
              <div class="col-md-4">
                <h6><strong>Assignee:</strong></h6>
                <div class="d-none d-md-block">
                  <p id="assignee"></p>
                </div>
                <input type="text" class="form-control d-md-none" id="assigneeInput" value="John Doe" disabled>
              </div>
              <div class="col-md-4">
                <h6><strong>Reporter:</strong></h6>
                <div class="d-none d-md-block">
                  <p id="reporter"></p>
                </div>
                <input type="text" class="form-control d-md-none" id="reporterInput" value="Jane Smith" disabled>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <h6><strong>Status:</strong></h6>
                <div class="d-none d-md-block">
                  <p id="issueStatus"></p>
                </div>
                <input type="text" class="form-control d-md-none" id="issueStatusInput" value="Open" disabled>
              </div>
              <div class="col-md-6">
                <h6><strong>Priority:</strong></h6>
                <div class="d-none d-md-block">
                  <p id="priority"></p>
                </div>
                <input type="text" class="form-control d-md-none" id="priorityInput" value="High" disabled>
              </div>
            </div>
           
            <div class="row">
              <div class="col-md-12">
                <h6><strong>Summary:</strong></h6>
                <div class="d-none d-md-block">
                  <p id="issueSummary"></p>
                </div>
                <textarea class="form-control d-md-none" id="issueSummaryInput" rows="3" disabled>User cannot log in with valid credentials.</textarea>
              </div>
            </div>
            <!-- Attachments Display -->
            <div class="row">
              <div class="col-md-12">
                <h6><strong>Attachments:</strong></h6>
                <div id="attachmentsContainer" class="d-flex flex-wrap">
                  <!-- Attachments will be dynamically inserted here -->
                </div>
              </div>
            </div>
            <!-- Comments Display -->
            <div class="row">
              <div class="col-md-12">
                <h6><strong>Comments:</strong></h6>
                <ul id="commentsList">
                  <!-- Comments will be dynamically inserted here -->
                </ul>
              </div>
            </div>
            <!-- Add Comment Section -->
            <div class="container mt-3">
              <h6><strong>Add Comment:</strong></h6>
              <form id="commentForm">
                <div class="form-group">
                  <textarea class="form-control" id="commentText" rows="3" placeholder="Add a comment"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Add Comment</button>
              </form>
            </div>
            <!-- Add Attachment Section -->
            <div class="container mt-3">
              <h6><strong>Add Attachment:</strong></h6>
              <form id="attachmentForm" enctype="multipart/form-data">
                <div class="form-group">
                  <input type="file" class="form-control-file" id="attachmentFile">
                </div>
                <button type="submit" class="btn btn-primary">Add Attachment</button>
              </form>
            </div>
          </form>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="editButton">Edit</button>
        <button type="button" class="btn btn-success" id="saveButton" style="display:none;">Save</button>
      </div>
    </div>
  </div>
</div>

<script src="./js/viewIssue.js"></script>
</body>
</html>
