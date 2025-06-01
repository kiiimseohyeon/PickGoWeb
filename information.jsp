<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // 클라이언트가 요청한 'place' 파라미터 값을 가져옴 (예: ?place=adcafe)
    String place = request.getParameter("place");

    // 장소별로 사용할 이미지, 텍스트, 타이틀 초기화
    String image = "";
    String text = "";
    String title = "";

    // 파라미터 값이 "adcafe"일 경우: 감성 카페 정보 설정
    if ("adcafe".equals(place)) {
        image = "images/cafe1.jpeg";
        title = "ADCAFE";
        text = "대전의 유명한 감성 카페입니다. 대전으로 떠나는 여행지로 추천!";
    } 
    // 파라미터 값이 "couple"일 경우: 커플 추천 장소 정보 설정
    else if ("couple".equals(place)) {
        image = "images/cafe2.jpeg";
        title = "커플 추천 장소";
        text = "데이트 코스로 인기가 많은 낭만적인 공간입니다.";
    } 
    // 파라미터 값이 "healing"일 경우: 힐링 장소 정보 설정
    else if ("healing".equals(place)) {
        image = "images/cafe3.jpeg";
        title = "힐링 장소";
        text = "어르신들이 많이 찾는 조용하고 편안한 분위기의 카페입니다.";
    } 
    // 위 조건들에 해당하지 않는 값일 경우: 기본 메시지 출력
    else {
        title = "알 수 없는 장소";
        text = "해당 장소에 대한 정보가 없습니다.";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <!-- 동적으로 설정된 장소 이름이 타이틀에 포함됨 -->
    <title><%= title %> - 상세 정보</title>
    <style>
        /* 전체 페이지 스타일 설정 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
            padding: 40px;
            max-width: 700px;
            margin: auto;
        }
        h1 {
            text-align: center;
            color: #2c3e50;
        }
        /* 장소 정보 카드 스타일 */
        .place-detail {
            background-color: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        /* 이미지 스타일 */
        .place-detail img {
            width: 100%;
            max-width: 500px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .place-detail p {
            font-size: 18px;
        }
    </style>
</head>
<body>

    <!-- 페이지 헤더: 동적으로 설정된 장소명 표시 -->
    <h1><%= title %></h1>

    <div class="place-detail">
        <!-- 이미지가 설정되어 있을 경우에만 출력 -->
        <% if (!image.isEmpty()) { %>
            <!-- 이미지 경로에 context path를 붙여서 절대 경로로 만듦 -->
            <img src="<%= request.getContextPath() + "/" + image %>" alt="<%= title %> 이미지">
        <% } %>

        <!-- 장소 설명 텍스트 출력 -->
        <p><%= text %></p>
    </div>

</body>
</html>
