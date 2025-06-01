<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String place = request.getParameter("place");

    String image = "";
    String text = "";
    String title = "";

    if ("adcafe".equals(place)) {
        image = "images/cafe1.jpeg";
        title = "ADCAFE";
        text = "대전의 유명한 감성 카페입니다. 대전으로 떠나는 여행지로 추천!";
    } else if ("couple".equals(place)) {
        image = "images/cafe2.jpeg";
        title = "커플 추천 장소";
        text = "데이트 코스로 인기가 많은 낭만적인 공간입니다.";
    } else if ("healing".equals(place)) {
        image = "images/cafe3.jpeg";
        title = "힐링 장소";
        text = "어르신들이 많이 찾는 조용하고 편안한 분위기의 카페입니다.";
    } else {
        title = "알 수 없는 장소";
        text = "해당 장소에 대한 정보가 없습니다.";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= title %> - 상세 정보</title>
    <style>
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
        .place-detail {
            background-color: #fff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
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

    <h1><%= title %></h1>

    <div class="place-detail">
        <% if (!image.isEmpty()) { %>
            <img src="<%= request.getContextPath() + "/" + image %>" alt="<%= title %> 이미지">
        <% } %>

        <p><%= text %></p>
    </div>

</body>
</html>
