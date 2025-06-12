<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="navbar">
	<div class="menu-icon">&#9776;</div>

	<div style="flex: 1; text-align: center; font-size: 22px; font-weight: bold;">
        <a href="<%= request.getContextPath() %>/main.jsp">
            <img src="<%= request.getContextPath() %>/images/logo.png" alt="Logo" style="height: 45px;" />
        </a>
    </div>

	<div class="search-bar">
		<form method="post"
			action="<%= request.getContextPath() %>/tag_research.jsp">
			<input type="text" name="tags" placeholder="태그 검색 (예: 힐링 맛집)">
			<input type="submit" value="🔍">
		</form>
	</div>
</div>
