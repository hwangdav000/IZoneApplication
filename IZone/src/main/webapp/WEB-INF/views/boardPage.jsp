<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>IZONE - Board</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
      </div>
      <div class="modal-body">
        <!-- Issue Details -->
        <div class="container">
          <form id="issueForm">
            <div class="row">
              <div class="col-md-4">
                <h6><strong>Issue Name:</strong></h6>
                <input type="text" class="form-control" id="issueName" disabled>
              </div>
              <div class="col-md-4">
                <h6><strong>Issue ID:</strong></h6>
                <input type="text" class="form-control" id="issueId" disabled>
              </div>
              <div class="col-md-4">
                <h6><strong>Created Date:</strong></h6>
                <input type="text" class="form-control" id="createdDateTime" disabled>
              </div>
            </div>
            <div class="row">
              <div class="col-md-4">
                <h6><strong>Issue Type:</strong></h6>
                <select class="form-control" id="issueType" disabled>
			      <option value="TASK">Task</option>
			      <option value="EPIC">Epic</option>
			      <option value="STORY">Story</option>
			      <option value="BUG">Bug</option>
			    </select>
              </div>
              <div class="col-md-4">
                <h6><strong>Assignee:</strong></h6>
                <input type="text" class="form-control" id="assignee" disabled>
              </div>
              <div class="col-md-4">
                <h6><strong>Reporter:</strong></h6>
                <input type="text" class="form-control" id="reporter" disabled>
              </div>
            </div>
            <div class="row">
              <div class="col-md-6">
                <h6><strong>Status:</strong></h6>
                <select class="form-control" id="issueStatus" disabled>
			      <option value="TODO">TODO</option>
			      <option value="INPROGRESS">In Progress</option>
			      <option value="DONE">Done</option>
			      <option value="COMPLETE">Complete</option>
			    </select>

              </div>
              <div class="col-md-6">
                <h6><strong>Priority:</strong></h6>
                <select class="form-control" id="priority" disabled>
			      <option value="HIGHEST">Highest</option>
			      <option value="HIGH">High</option>
			      <option value="MEDIUM">Medium</option>
			      <option value="LOW">Low</option>
			      <option value="LOWEST">Lowest</option>
			    </select>
                
              </div>
            </div>
            <div class="row">
              <div class="col-md-12">
                <h6><strong>Summary:</strong></h6>
                <textarea class="form-control" id="issueSummary" rows="3" disabled></textarea>
              </div>
            </div>
            <!-- Attachments and Comments sections remain unchanged -->
			
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
              <div id="commentContainer">
			  <div class="form-group">
			    <textarea rows="4" cols="50" class="form-control" id="commentText" placeholder="Add a comment"></textarea>
			  </div>
			  <button type="button" id="submitComment" class="btn btn-primary">Add Comment</button>
			  </div>
            </div>
            <!-- Add Attachment Section -->
            <div class="container mt-3">
              <h6><strong>Add Attachment:</strong></h6>
              <div id="attachmentDiv" enctype="multipart/form-data">
			    <div class="form-group">
			        <input type="file" class="form-control-file" id="attachmentFile">
			    </div>
			    <button type="button" id="submitAttachment" class="btn btn-primary">Add Attachment</button>
			  </div>
            </div>
			
          </form>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" id="closeButton" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-danger" id="cancelButton" style="display:none;">Cancel</button>
        <button type="button" class="btn btn-primary" id="editButton">Edit</button>
        <button type="button" class="btn btn-success" id="saveButton" style="display:none;">Save</button>
      </div>
    </div>
  </div>
</div>


<script src="./js/viewIssue.js"></script>
</body>
</html>
