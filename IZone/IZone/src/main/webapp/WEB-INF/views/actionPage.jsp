<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Project Management</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center" style="margin-top: 300px;">
            <!-- CREATE PROJECT Section -->
            <div class="col-md-6 text-center">
                <h2>Create a New Project</h2>
                <a class="btn btn-success btn-lg mt-4" href="${pageContext.request.contextPath}/projectForm" role="button">Create Project</a>
            </div>
        </div>
        <hr class="my-5">
        <div class="row justify-content-center">
            <!-- WORK ON PROJECT Section -->
            <div class="col-md-6">
                <h2 class="text-center">Work on an Existing Project</h2>
                <!-- Display Error Message -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" role="alert">
                        ${error}
                    </div>
                </c:if>
                <form action="${pageContext.request.contextPath}/board" method="post">
                    <div class="form-group">
                        <input type="text" id="projectName" name="projectName" class="form-control mb-3" placeholder="Enter Project Name" required>
                        <input type="text" id="projectKey" name="projectKey" class="form-control" placeholder="Enter Project Key" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary btn-lg">Work on Project</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
