<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		String userid=request.getParameter("id");
		String password=request.getParameter("passwd");
		
		if(userid.equals("pickgo")&&password.equals("1234")){
			session.setAttribute("userid", userid);
			response.sendRedirect("main.jsp");
		}else{
			response.sendRedirect("Login_failed.jsp");
		}
	%>
</body>
</html>
