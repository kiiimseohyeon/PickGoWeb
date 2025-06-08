<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String userid = (String)session.getAttribute("userid");
%>
<div class="navbar">
    <div class="menu-icon">&#9776;</div>
    <div class="logo">
        <img src="<%= request.getContextPath() %>/images/logo.png" alt="Logo">
    </div>
    <div class="search-bar">
        <input type="text" placeholder="Search...">
        <% if (userid == null) { %>
            <a href="Login.jsp">로그인</a>
        <% } else { %>
            <span><%= userid %>님 반갑습니다!</span>
            <a href="Logout.jsp">로그아웃</a>
        <% } %>
    </div>
</div>

/* 상단부 로고, 메뉴바 */
