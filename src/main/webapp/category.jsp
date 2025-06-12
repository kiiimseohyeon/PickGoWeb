<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page
	import="java.util.*, pick_go.dao.PlaceDAO, pick_go.dto.PlaceDTO"%>

<!-- 놀거리 영역 -->
<div class="category-area">
	<div class="category-title">놀거리</div>
	<div class="carousel-wrapper">
		<button class="scroll-btn left" onclick="scrollLeft('carousel1')">&#8249;</button>
		<div class="category-content" id="carousel1">
			<%
                PlaceDAO dao1 = new PlaceDAO();
                List<PlaceDTO> places1 = dao1.findPlacesByCategory("놀거리");
                for (PlaceDTO place : places1) {
                    String imgSrc = place.getImage();
            %>
			<a
				href="<%= request.getContextPath() %>/information.jsp?placeId=<%= place.getId() %>">
				<div class="category-card">
					<img src="<%= imgSrc %>" alt="<%= place.getName() %>">
					<div class="category-name"><%= place.getName() %></div>
				</div>
			</a>
			<% } %>
		</div>
		<button class="scroll-btn right" onclick="scrollRight('carousel1')">&#8250;</button>
	</div>
</div>

<!-- 맛집 영역 -->
<div class="category-area">
	<div class="category-title">맛집</div>
	<div class="carousel-wrapper">
		<button class="scroll-btn left" onclick="scrollLeft('carousel2')">&#8249;</button>
		<div class="category-content" id="carousel2">
			<%
                PlaceDAO dao2 = new PlaceDAO();
                List<PlaceDTO> places2 = dao2.findPlacesByCategory("맛집");
                for (PlaceDTO place : places2) {
                    String imgSrc = place.getImage();
            %>
			<a
				href="<%= request.getContextPath() %>/information.jsp?placeId=<%= place.getId() %>">

				<div class="category-card">
					<img src="<%= imgSrc %>" alt="<%= place.getName() %>">
					<div class="category-name"><%= place.getName() %></div>
				</div>
			</a>
			<% } %>
		</div>
		<button class="scroll-btn right" onclick="scrollRight('carousel2')">&#8250;</button>
	</div>
</div>

<!-- 카페 영역 -->
<div class="category-area">
	<div class="category-title">카페</div>
	<div class="carousel-wrapper">
		<button class="scroll-btn left" onclick="scrollLeft('carousel3')">&#8249;</button>
		<div class="category-content" id="carousel3">
			<%
                PlaceDAO dao3 = new PlaceDAO();
                List<PlaceDTO> places3 = dao3.findPlacesByCategory("카페");
                for (PlaceDTO place : places3) {
                    String imgSrc = place.getImage();
            %>
			<a
				href="<%= request.getContextPath() %>/information.jsp?placeId=<%= place.getId() %>">

				<div class="category-card">
					<img src="<%= imgSrc %>" alt="<%= place.getName() %>">
					<div class="category-name"><%= place.getName() %></div>
				</div>
			</a>
			<% } %>
		</div>
		<button class="scroll-btn right" onclick="scrollRight('carousel3')">&#8250;</button>
	</div>
</div>

<!-- 슬라이드 이동 JavaScript -->
<script>
    function scrollLeft(id) {
        const el = document.getElementById(id);
        el.scrollBy({ left: -300, behavior: 'smooth' });
    }
    function scrollRight(id) {
        const el = document.getElementById(id);
        el.scrollBy({ left: 300, behavior: 'smooth' });
    }
</script>
