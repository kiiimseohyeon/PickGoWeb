<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
 	
	<form action="Login_process.jsp" method="post">
		<p> 아이디: <input type="text" name="id">
		<p> 비밀번호: <input type="text" name="passwd">
		<p> <input type="submit" value="로그인">
	</form>

    <%@ include file="footer.jsp" %>
</body>
</html>
