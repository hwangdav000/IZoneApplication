<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Role Form</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/home">Bank Application</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/roleForm">Role</a></li>
            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/userForm">User</a></li>
        </ul>
        <ul class="navbar-nav ml-auto">
            <sec:authorize access="isAuthenticated()">
                <li class="nav-item">
                    <span class="navbar-text" style="color: black;">
                        User: ${pageContext.request.userPrincipal.name}
                        <br/>
                        <sec:authentication property="principal.authorities" var="authorities" />
                        Roles:
                        <c:forEach items="${authorities}" var="authority">
                            ${authority.authority}&nbsp;
                        </c:forEach>
                    </span>
                </li>
                <li class="nav-item">
                    <a class="btn btn-danger ml-2 mt-2" href="${pageContext.request.contextPath}/logout">Logout</a>
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

<sec:authorize access="hasAuthority('ADMIN')">
<div class="container mt-4">
 	<div class="row justify-content-center">
     <div class="col-md-8">
         <div class="card">
             <div class="card-header text-center">
                 <h3>Role Registration Form</h3>
             </div>
             <div class="card-body">
            
	        <f:form action="saveRole" method="GET" modelAttribute="role">
	            <div class="form-group">
	                <label for="roleId">Role Id:</label>
	                <f:input path="roleId" id="roleId" class="form-control" readonly="true" value="${r.roleId}" />
	                <f:errors path="roleId" cssClass="text-danger"/>
	            </div>
	
	            <div class="form-group">
	                <label for="roleName">Role Name:</label>
	                <f:input path="roleName" id="roleName" class="form-control" value="${r.roleName}" />
	                <f:errors path="roleName" cssClass="text-danger"/>
	            </div>
	
	            <div class="form-group text-center">
	                <input type="submit" value="Submit" class="btn btn-primary"/>
	            </div>
	        </f:form>
    		</div>
		</div>
	</div>
	</div>
</div>
</sec:authorize>

<div class="container mt-3">
    <h2 class="text-center mb-4">List of Roles</h2>
     <table class="table table-striped table-bordered">
         <thead>
             <tr>
                 <th><a href="${pageContext.request.contextPath}/roleForm?sortBy=RoleId">Role Id</a></th>
                 <th><a href="${pageContext.request.contextPath}/roleForm?sortBy=RoleName">Role Name</a></th>
                 <sec:authorize access="hasAuthority('ADMIN')">
                     <th colspan="2">Action</th>
                 </sec:authorize>
             </tr>
         </thead>
         <tbody>
             <c:forEach items="${roles}" var="r">
                 <tr>
                     <td>${r.getRoleId()}</td>
                     <td>${r.getRoleName()}</td>
                     <sec:authorize access="hasAuthority('ADMIN')">
                         <td><a href="updateRole?roleId=${r.getRoleId()}" class="btn btn-warning btn-sm">Update</a></td>
                         <td><a href="deleteRole?roleId=${r.getRoleId()}" class="btn btn-danger btn-sm">Delete</a></td>
                     </sec:authorize>
                 </tr>
             </c:forEach>
         </tbody>
     </table>
	  
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>