<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 
 
<div class="category"> <%-- 기존 카드 구조와 동일하게 씀 --%> 
    <div class="category-title">현재 뜨는 장소</div> 
 
    <div class="carousel-wrapper"> 
        <button class="scroll-btn left" onclick="scrollLeft('banner-carousel')">&#8249;</button>
 
        <div class="category-content" id="banner-carousel"> 
            <div class="banner-card"> 
                <a href="<%= request.getContextPath() %>/information.jsp?place=adcafe">
                    <img src="<%= request.getContextPath() %>/images/cafe1.jpeg" alt="배너1"> 
                </a>
                <div class="banner-text">대전으로 떠나는 여행!<br>ADCAFE</div> 
            </div> 
            <div class="banner-card"> 
                <a href="<%= request.getContextPath() %>/information.jsp?place=couple">
                    <img src="<%= request.getContextPath() %>/images/cafe2.jpeg" alt="배너2"> 
                </a>
                <div class="banner-text">지금 커플들이 많이 찾는곳!</div> 
            </div> 
            <div class="banner-card"> 
                <a href="<%= request.getContextPath() %>/information.jsp?place=healing">
                    <img src="<%= request.getContextPath() %>/images/cafe3.jpeg" alt="배너3"> 
                </a>
                <div class="banner-text">어르신들이 많이 찾는 힐링</div> 
            </div> 
            <div class="banner-card"> 
                <a href="<%= request.getContextPath() %>/information.jsp?place=healing">
                    <img src="<%= request.getContextPath() %>/images/cafe3.jpeg" alt="배너3"> 
                </a>
                <div class="banner-text">어르신들이 많이 찾는 힐링</div> 
            </div> 
            <div class="banner-card"> 
                <a href="<%= request.getContextPath() %>/information.jsp?place=healing">
                    <img src="<%= request.getContextPath() %>/images/cafe3.jpeg" alt="배너3"> 
                </a>
                <div class="banner-text">어르신들이 많이 찾는 힐링</div> 
            </div> 
        </div> 
 
        <button class="scroll-btn right" onclick="scrollRight('banner-carousel')">&#8250;</button> 
    </div> 
</div>
