<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, pick_go.dao.PlaceDAO, pick_go.dto.PlaceDTO" %>

<div class="category">
    <div class="category-title">지금 뜨는 장소</div>

    <div class="carousel-wrapper">
        <button class="scroll-btn left" onclick="scrollLeft('banner-carousel')">&#8249;</button>

        <div class="category-content" id="banner-carousel">
            <%
                PlaceDAO dao = new PlaceDAO();
                List<PlaceDTO> bannerList = dao.getMainBannerPlaces();

                for (PlaceDTO place : bannerList) {
            %>
                <!-- 링크 추가 -->
                <div class="banner-card">
                    <a href="information.jsp?placeId=<%= place.getId() %>">
                        <img src="<%= place.getImage() %>" alt="<%= place.getName() %>">
                        <div class="banner-text"><%= place.getName() %></div>
                    </a>
                </div>
            <%
                }
            %>
        </div>

        <button class="scroll-btn right" onclick="scrollRight('banner-carousel')">&#8250;</button>
    </div>
</div>
