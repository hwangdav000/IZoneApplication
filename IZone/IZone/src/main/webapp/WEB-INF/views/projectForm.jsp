<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Project Form</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <div class="row justify-content-center" style="margin-top: 300px; margin-bottom: 50px"> 
        <div class="col-md-8">
            <div class="card">
                <div class="card-header text-center">
                    <h3>Create Project</h3>
                </div>
                <div class="card-body">
                    <f:form action="${pageContext.request.contextPath}/saveProject" modelAttribute="project" method="post">
                        
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
                                    <input type="email" name="userEmails" class="form-control" placeholder="Enter user email" required>
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
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script>
    $(document).ready(function(){
        // Add new email input field
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
