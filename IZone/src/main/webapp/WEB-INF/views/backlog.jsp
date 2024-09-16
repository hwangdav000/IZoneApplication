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
                                <button class="btn btn-primary btn-sm view-issue-btn" value="${issue.issueId}">View Issue</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
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

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script src="./js/viewIssue.js"></script>

</body>
</html>
