<%-- 
    Document   : top2
    Created on : Jul 13, 2023, 4:08:05 PM
    Author     : Acer
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>TOP2 USER</h1>
        <c:forEach items="${requestScope.LIST_TOP2_USER}" var="user">
        <p>UserID: ${user.userID}</p>
        <p>FullName: ${user.fullName}</p>
        <p>roleID: ${user.roleID}</p>
        <p
        </c:forEach>
    </body>
</html>
