<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <%
        String cssPath = request.getContextPath() + "/pickgo.css";
    %>
    <link rel="stylesheet" href="<%= cssPath %>">
</head>
<body>

    <%@ include file="header.jsp" %>
  
	로그인 실패!
	<p><a href="./Login.jsp">로그인 화면으로 이동</a>

    <%@ include file="footer.jsp" %>
</body>
</html>
