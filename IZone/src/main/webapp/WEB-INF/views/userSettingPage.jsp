<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
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
                    <a class="nav-link active" href="${pageContext.request.contextPath}/userSettingPage">User Settings</a>
                </li>
            </ul>
        </nav>

        <!-- Main Content -->
        <main role="main" class="col-md-10 ml-sm-auto px-4 mt-3 ml-2">
            <div class="container mt-5">
		    <div class="row justify-content-center">
		        <div class="col-md-8">
		            <div class="card">
		                <div class="card-header text-center">
		                    <h3>User Settings Form</h3>
		                </div>
		                <div class="card-body">
		                    <f:form action="${pageContext.request.contextPath}/saveUserSettingPage" modelAttribute="user" method="post">
		                        <div class="form-group">
		                            <label for="userId">User Id</label>
		                            <f:input id="userId" path="userId" readonly="true" class="form-control" value="${u.userId}"/>
		                            <f:errors path="userId" cssClass="text-danger"/>
		                        </div>
		                        <div class="form-group">
		                            <label for="username">User Name</label>
		                            <f:input id="username" path="username" class="form-control" value="${u.username}"/>
		                            <f:errors path="username" cssClass="text-danger"/>
		                        </div>
		                        <div class="form-group">
		                            <label for="userPassword">Password</label>
		                            <f:input id="userPassword" path="userPassword" type="password" class="form-control" value=""/>
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
				                                    <f:checkbox path="userRoles" value="${role.roleId}" checked="true" />
				                                    ${role.roleName}
				                                </c:when>
				                                <c:otherwise>
				                                    <f:checkbox path="userRoles" value="${role.roleId}" />
				                                    ${role.roleName}
				                                </c:otherwise>
				                            </c:choose>
				                        </c:forEach>
					                    
					                    <f:errors path="userRoles" cssClass="text-danger"/>
					                </div>
		                        </sec:authorize>
		
		                        <div class="text-center">
		                        
								    <c:if test="${not empty error}">
					                    <div class="alert alert-danger" role="alert">
					                        ${error}
					                    </div>
					                </c:if>
								    <button type="submit" class="btn btn-primary btn-lg">Submit</button>
								</div>
		
		                    </f:form>
		                </div>
		            </div>
		        </div>
		    </div>
		

	        <div class="container mt-5">
		        <sec:authorize access="hasAuthority('ADMIN')">
				    <h2 class="text-center mb-4">User List</h2>
				</sec:authorize>
				
				<sec:authorize access="hasAuthority('USER')">
				    <h2 class="text-center mb-4">User</h2>
				</sec:authorize>
				
	            <table class="table table-striped table-bordered">
	                <thead>
	                    <tr>
	                        <th><a href="${pageContext.request.contextPath}/userSettingPage?sortBy=userId" style="color: white;">User Id</a></th>
	                        <th><a href="${pageContext.request.contextPath}/userSettingPage?sortBy=username" style="color: white;">User Name</a></th>
	                        <th><a href="${pageContext.request.contextPath}/userSettingPage?sortBy=userEmail" style="color: white;">Email</a></th>
	                        <th><a href="${pageContext.request.contextPath}/userSettingPage?sortBy=userRoles" style="color: white;">Roles</a></th>
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
	                            <td><a href="${pageContext.request.contextPath}/updateUserSettingPage?userId=${user.userId}" class="btn btn-warning btn-sm">Update</a></td>
	                            <td><a href="${pageContext.request.contextPath}/deleteUserSettingPage?userId=${user.userId}" class="btn btn-danger btn-sm">Delete</a></td>
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


</body>
</html>
