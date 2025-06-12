<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="pick_go.dao.PlaceDAO, pick_go.dto.PlaceDTO" %>

<%
    String idParam = request.getParameter("placeId");
    PlaceDTO place = null;

    if (idParam != null) {
        try {
            int placeId = Integer.parseInt(idParam);
            PlaceDAO dao = new PlaceDAO();
            place = dao.findById(placeId);
        } catch (NumberFormatException e) {
            // 잘못된 숫자일 경우 처리
        }
    }
%>

<% if (place == null) { %>
    <h2 style="text-align:center; padding: 50px;">장소를 찾을 수 없습니다.</h2>
<% } else { %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= place.getName() %> - 상세 정보</title>
     <link rel="stylesheet" href="<%= request.getContextPath() %>/pickgo.css">
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #222;
            font-family: 'Arial', sans-serif;
        }
        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        .top-bar {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            background-color: #fff;
            border-bottom: 1px solid #ddd;
        }
        .back-btn {
            font-size: 16px;
            background-color: #fff;
            border: 1px solid #ccc;
            padding: 6px 12px;
            border-radius: 6px;
            cursor: pointer;
            margin-right: 15px;
        }
        .back-btn:hover {
            background-color: #ddd;
        }
        .place-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
        }
        .content {
            padding: 30px;
        }
        .place-title {
            font-size: 28px;
            margin-bottom: 15px;
            color: #333;
        }
        .place-desc {
            font-size: 16px;
            color: #555;
            line-height: 1.6;
        }
    </style>
     
</head>
<body>
<%@ include file="header.jsp" %>
    <div class="container">
        <div class="top-bar">
            <button class="back-btn" onclick="history.back()">← 뒤로 가기</button>
            <div><strong><%= place.getName() %></strong></div>
        </div>
        <img class="place-image" src="<%= place.getImage() %>" alt="<%= place.getName() %>">
        <div class="content">
            <div class="place-title"><%= place.getName() %></div>
            <div class="place-desc"><%= place.getDescription() %></div>
        </div>
    </div>
   <%@ include file="footer.jsp" %>
</body>
</html>
<% } %>

