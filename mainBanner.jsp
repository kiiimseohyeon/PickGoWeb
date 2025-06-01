<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> 

<!-- 장소 배너 카테고리 전체를 감싸는 div -->
<div class="category"> <%-- 기존 카드 구조와 동일하게 씀 --%> 

    <!-- 섹션 타이틀 -->
    <div class="category-title">현재 뜨는 장소</div> 

    <!-- 캐러셀 전체를 감싸는 wrapper -->
    <div class="carousel-wrapper"> 

        <!-- 왼쪽으로 스크롤하는 버튼, JavaScript 함수 호출 -->
        <button class="scroll-btn left" onclick="scrollLeft('banner-carousel')">&#8249;</button>

        <!-- 배너 카드들이 들어갈 캐러셀 콘텐츠 영역 -->
        <div class="category-content" id="banner-carousel"> 

            <!-- 배너 카드 1: adcafe로 이동 -->
            <div class="banner-card"> 
                <!-- 클릭 시 information.jsp에 place=adcafe 파라미터 전달 -->
                <a href="<%= request.getContextPath() %>/information.jsp?place=adcafe">
                    <!-- 카페1 이미지 출력 -->
                    <img src="<%= request.getContextPath() %>/images/cafe1.jpeg" alt="배너1"> 
                </a>
                <!-- 이미지 아래 설명 텍스트 -->
                <div class="banner-text">대전으로 떠나는 여행!<br>ADCAFE</div> 
            </div> 

            <!-- 배너 카드 2: couple로 이동 -->
            <div class="banner-card"> 
                <a href="<%= request.getContextPath() %>/information.jsp?place=couple">
                    <img src="<%= request.getContextPath() %>/images/cafe2.jpeg" alt="배너2"> 
                </a>
                <div class="banner-text">지금 커플들이 많이 찾는곳!</div> 
            </div> 

            <!-- 배너 카드 3: healing으로 이동 -->
            <div class="banner-card"> 
                <a href="<%= request.getContextPath() %>/information.jsp?place=healing">
                    <img src="<%= request.getContextPath() %>/images/cafe3.jpeg" alt="배너3"> 
                </a>
                <div class="banner-text">어르신들이 많이 찾는 힐링</div> 
            </div> 

            <!-- 중복된 배너 카드들 (필요 시 제거 또는 수정 가능) -->
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

        <!-- 오른쪽으로 스크롤하는 버튼 -->
        <button class="scroll-btn right" onclick="scrollRight('banner-carousel')">&#8250;</button> 
    </div> 
</div>
