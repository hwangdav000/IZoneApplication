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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/userSettingPage">User Settings</a>
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
			                    <h3>User Edit Form</h3>
			                </div>
			                <div class="card-body">
			                    <f:form action="${pageContext.request.contextPath}/saveUserEdit" modelAttribute="user" method="post">
			                        <div class="form-group">
			                            <label for="userId">User Id</label>
			                            <f:input id="userId" path="userId" readonly="true" class="form-control" value="${u.userId}"/>
			                            <f:errors path="userId" cssClass="text-danger"/>
			                        </div>
			                        <div class="form-group">
			                            <label for="username">User Name</label>
			                            <f:input id="username" path="username" readonly="true" class="form-control" value="${u.username}"/>
			                            <f:errors path="username" cssClass="text-danger"/>
			                        </div>
			                        <div class="form-group">
			                            <label for="userPassword">Password</label>
			                            <f:input id="userPassword" path="userPassword" type="password" class="form-control"/>
			                            <f:errors path="userPassword" cssClass="text-danger"/>
			                        </div>
			                        <div class="form-group">
			                            <label for="userEmail">Email</label>
			                            <f:input id="userEmail" path="userEmail" class="form-control" value="${u.userEmail}"/>
			                            <f:errors path="userEmail" cssClass="text-danger"/>
			                        </div>
			
			                        <sec:authorize access="hasAuthority('ADMIN')">
			                            <div class="form-group">
			                                <label>Roles</label>
			                                <div>
			                                    <c:forEach items="${roles}" var="role">
			                                        <c:choose>
			                                            <c:when test="${retrievedRoles.contains(role.roleId)}">
			                                                <f:checkbox path="userRoles" value="${role.roleId}" checked="true"/>
			                                                ${role.roleName}
			                                            </c:when>
			                                            <c:otherwise>
			                                                <f:checkbox path="userRoles" value="${role.roleId}"/>
			                                                ${role.roleName}
			                                            </c:otherwise>
			                                        </c:choose>
			                                    </c:forEach>
			                                </div>
			                                <f:errors path="userRoles" cssClass="text-danger"/>
			                            </div>
			                        </sec:authorize>
			
			                        <div class="text-center">
									    <a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/login" role="button">Back</a>
									    <button type="submit" class="btn btn-primary btn-lg">Edit</button>
									</div>
			
			                    </f:form>
			                </div>
			            </div>
			        </div>
			    </div>
			
			    <sec:authorize access="hasAuthority('ADMIN')">
			        <div class="container mt-5">
			            <h2 class="text-center mb-4">User List</h2>
			            <table class="table table-striped table-bordered">
			                <thead>
			                    <tr>
			                        <th><a href="${pageContext.request.contextPath}/userForm?sortBy=userId">User Id</a></th>
			                        <th><a href="${pageContext.request.contextPath}/userForm?sortBy=username">User Name</a></th>
			                        <th><a href="${pageContext.request.contextPath}/userForm?sortBy=userEmail">Email</a></th>
			                        <th><a href="${pageContext.request.contextPath}/userForm?sortBy=userRoles">Roles</a></th>
			                        <th colspan="2">Action</th>
			                    </tr>
			                </thead>
			                <tbody>
			                    <c:forEach items="${users}" var="user">
			                        <tr>
			                            <td>${user.userId}</td>
			                            <td>${user.username}</td>
			                            <td>${user.userEmail}</td>
			                            <td>
			                                <c:forEach items="${user.userRoles}" var="r">
			                                    ${r.roleName}
			                                </c:forEach>
			                            </td>
			                            <td><a href="${pageContext.request.contextPath}/updateUser?userId=${user.userId}" class="btn btn-warning btn-sm">Update</a></td>
			                            <td><a href="${pageContext.request.contextPath}/deleteUser?userId=${user.userId}" class="btn btn-danger btn-sm">Delete</a></td>
			                        </tr>
			                    </c:forEach>
			                </tbody>
			            </table>
			        </div>
			    </sec:authorize>
			</div>

        </main>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
