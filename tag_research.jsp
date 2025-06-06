<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.PlaceDTO" %>
<%@ page import="dao.PlaceDAO" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>태그 기반 장소 검색</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f7fa;
            margin: 40px auto;
            max-width: 700px;
            padding: 20px;
            border-radius: 12px;
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        h2 {
            color: #2c3e50;
        }

        form {
            margin-bottom: 20px;
        }

        input[type="text"] {
            width: 80%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-bottom: 10px;
        }

        input[type="submit"] {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        .error {
            color: #e74c3c;
        }

        .success {
            color: #27ae60;
        }

        .place-item {
            margin-bottom: 20px;
            border-bottom: 1px solid #ccc;
            padding-bottom: 15px;
        }

        .place-item img {
            width: 100%;
            max-width: 300px;
            height: auto;
            border-radius: 8px;
            margin-top: 10px;
        }

        .tag {
            font-size: 0.9em;
            color: #555;
        }
    </style>
</head>
<body>

<h2>태그 기반 장소 검색</h2>
<form method="post" action="tag_research.jsp">
    <label>검색할 태그들을 입력하세요 (예: 가족, 10대, 20대):</label><br>
    <input type="text" name="tags" required>
    <input type="submit" value="검색">
</form>

<hr>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String input = request.getParameter("tags");
        if (input != null && !input.trim().isEmpty()) {
            List<String> keywords = Arrays.asList(input.trim().split("\\s+"));

            try {
                PlaceDAO dao = new PlaceDAO();
                List<PlaceDTO> places = dao.findPlacesByTags(keywords);

                if (places.isEmpty()) {
                    out.println("<p class='error'>❌ 입력한 모든 태그를 포함한 장소가 없습니다.</p>");
                } else {
                    out.println("<h3 class='success'>✅ 검색 결과:</h3>");
                    for (PlaceDTO place : places) {
                        out.println("<div class='place-item'>");
                        out.println("<b>" + place.getName() + "</b><br>");
                        out.println("<span class='tag'>태그: " + String.join(", ", place.getTags()) + "</span><br>");
                        
                        if (place.getImage() != null && !place.getImage().isEmpty()) {
                            out.println("<img src='images/" + place.getImage() + "' alt='" + place.getName() + "'>");
                        }

                        out.println("</div>");
                    }
                }

            } catch (Exception e) {
                out.println("<p class='error'>오류: " + e.getMessage() + "</p>");
            }
        }
    }
%>

</body>
</html>
