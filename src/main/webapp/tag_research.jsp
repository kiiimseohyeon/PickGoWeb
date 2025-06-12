<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pick_go.dao.PlaceDAO" %>
<%@ page import="pick_go.dto.PlaceDTO" %>
<%@ page import="java.util.*" %>
<%@ include file="header.jsp" %> 
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>태그 기반 장소 검색</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/pickgo.css">
    
    <style>
       body { font-family: Arial, sans-serif; margin:0; padding:0; background:#000; color: #fff; }
        .card-img-top { height:180px; object-fit:cover; }
        .search-form { margin: 30px auto 20px; max-width: 480px; }
          .card-body {
            color: #fff; /* 흰색으로 텍스트 색상 설정 */
        }
        .card {
    height: 350px; /* 카드 높이를 고정 (원하는 높이로 설정) */
}

.card-img-top {
    height: 200px; /* 이미지 높이 고정 */
    object-fit: cover; /* 이미지를 비율에 맞게 채움 */
}
        
    </style>
</head>
<body>
    <div class="container">
        <h2 class="mt-4 mb-3">태그 기반 장소 검색</h2>
        <form method="post" action="tag_research.jsp" class="search-form">
            <label>검색할 태그들을 입력하세요 (예: 맛집 대전):</label>
            <div class="input-group mb-2">
                <input type="text" name="tags" class="form-control" size="50" required>
                <button class="btn btn-primary" type="submit">검색</button>
            </div>
        </form>
        <hr>
        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String input = request.getParameter("tags");
                if (input != null && !input.trim().isEmpty()) {
                    List<String> keywords = new ArrayList<>();
                    for (String word : input.trim().toLowerCase().split("\\s+")) {
                        if (!word.isEmpty()) keywords.add(word);
                    }
                    out.println("<div class='mb-2'>입력 태그: <span style='color:#29497d;font-weight:bold'>" + keywords + "</span></div>");
                    try {
                        PlaceDAO dao = new PlaceDAO();
                        List<PlaceDTO> places = dao.findPlacesByTags(keywords);

                        if (places.isEmpty()) {
                            out.println("<p style='color:red;'>❌ 입력한 모든 태그를 포함한 장소가 없습니다.</p>");
                        } else {
        %>
        <div class="container my-4">
            <h5>✅ 모든 태그를 포함한 장소</h5>
            <div class="row row-cols-1 row-cols-md-4 g-4">
                <% for (PlaceDTO place : places) { %>
                <div class="col">
                    <div class="card h-100 shadow-sm">
                        <img src="<%= place.getImage() %>" class="card-img-top" alt="<%= place.getName() %>">
                        <div class="card-body">
                            <h5 class="card-title"><%= place.getName() %></h5>
                            <% if (place.getDescription() != null) { %>
                            <p class="card-text" style="font-size:14px;"><%= place.getDescription() %></p>
                            <% } %>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
        <%
                        }
                    } catch (Exception e) {
                        out.println("<p style='color:red;'>오류: " + e.getMessage() + "</p>");
                    }
                }
            }
        %>
    </div>
    
    <!-- Bootstrap JS (필수는 아니지만 추가 추천) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
