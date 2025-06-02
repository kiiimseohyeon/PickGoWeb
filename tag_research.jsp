<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="pick_go.dto.PlaceDTO" %>
<%@ page import="pick_go.dao.PlaceDAO" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>태그 기반 장소 검색</title>
</head>
<body>

<h2>태그 기반 장소 검색</h2>
<form method="post" action="tag_research.jsp">
    <label>검색할 태그들을 입력하세요 (예: 맛집 대전):</label><br>
    <input type="text" name="tags" size="50" required>
    <input type="submit" value="검색">
</form>

<hr>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String input = request.getParameter("tags");
        if (input != null && !input.trim().isEmpty()) {
            List<String> keywords = Arrays.asList(input.trim().toLowerCase().split("\\s+"));
            try {
                PlaceDAO dao = new PlaceDAO();
                List<PlaceDTO> places = dao.findPlacesByTags(keywords);

                if (places.isEmpty()) {
                    out.println("<p style='color:red;'>❌ 입력한 모든 태그를 포함한 장소가 없습니다.</p>");
                } else {
                    out.println("<h3>✅ 모든 태그를 포함한 장소:</h3><ul>");
                    for (PlaceDTO place : places) {
                        out.println("<li>" + place.getName() + "</li>");
                    }
                    out.println("</ul>");
                }

            } catch (Exception e) {
                out.println("<p style='color:red;'>오류: " + e.getMessage() + "</p>");
            }
        }
    }
%>

</body>
</html>


<%--
<%@ page import="java.util.*, pick_go.pick_go_tag_research" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>태그 기반 장소 검색</title>
</head>
<body>
    <h2>태그 기반 장소 검색</h2>
    <form method="post" action="tag_research.jsp">
        <label>검색할 태그들을 입력하세요 (예: 맛집 대전):</label><br>
        <input type="text" name="tags" size="50" required>
        <input type="submit" value="검색">
    </form>

    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String input = request.getParameter("tags");
            if (input != null && !input.trim().isEmpty()) {
                input = input.trim().toLowerCase();
                List<String> keywords = Arrays.asList(input.split("\\s+"));
                try {
                	List<String> places = pick_go_tag_research.findPlacesByTags(keywords);

                	if (places.isEmpty()) {
                	    out.println("<p style='color:red;'>❌ 입력한 모든 태그를 포함한 장소가 없습니다.</p>");
                	} else {
                	    out.println("<h3>✅ 모든 태그를 포함한 장소:</h3><ul>");
                	    for (String place : places) {
                	        out.println("<li>" + place + "</li>");
                	    }
                	    out.println("</ul>");
                	}

                } catch (Exception e) {
                    out.println("<p style='color:red;'>" + e.getMessage() + "</p>");
                }
            } else {
                out.println("<p style='color:red;'>❌ 태그를 입력해주세요.</p>");
            }
        }
    %>
</body>
</html>


<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>태그 기반 장소 검색</title>
</head>
<body>
    <h2>
     태그 기반 장소 검색</h2>
    <form method="post" action="tag_research.jsp">
        <label>검색할 태그들을 입력하세요 (예: 맛집 대전):</label><br>
        <input type="text" name="tags" size="50" required>
        <input type="submit" value="검색">
    </form>

    <%
        // POST 요청일 때만 처리
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String input = request.getParameter("tags");
            if (input != null && !input.trim().isEmpty()) {
                input = input.trim().toLowerCase();
                String[] inputTags = input.split("\\s+");
                List<String> keywords = Arrays.asList(inputTags);

                // 데이터베이스 접속 정보 설정
                String jdbcUrl = "jdbc:mysql://localhost:3306/ipp_pickgo?useSSL=false&serverTimezone=UTC";
                String dbUser = "root";         // 아이디
                String dbPass = "1234";     // 비밀번호

                Connection conn = null;
                PreparedStatement tagStmt = null;
                PreparedStatement placeStmt = null;
                ResultSet tagRs = null;
                ResultSet placeRs = null;

                try {
                    // JDBC 드라이버 로드
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    // 데이터베이스 연결
                    conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPass);

                    // 1. 입력된 태그 이름들을 기반으로 해당하는 tag_id들을 조회하는 SQL 쿼리 작성
                    String tagIdSql = "SELECT id FROM tag WHERE LOWER(name) IN (" +
                            String.join(",", Collections.nCopies(keywords.size(), "?")) + ")";
                    tagStmt = conn.prepareStatement(tagIdSql);
                    for (int i = 0; i < keywords.size(); i++) {
                        tagStmt.setString(i + 1, keywords.get(i));
                    }

                    tagRs = tagStmt.executeQuery();
                    List<Integer> tagIds = new ArrayList<>();
                    while (tagRs.next()) {
                        tagIds.add(tagRs.getInt("id"));
                    }

                    if (tagIds.size() != keywords.size()) {
                        out.println("<p style='color:red;'>❌ 입력한 태그 중 일부가 존재하지 않습니다.</p>");
                    } else {
                        // 2. 입력된 모든 태그를 포함하는 장소들을 조회하는 SQL 쿼리 작성
                        StringBuilder query = new StringBuilder();
                        query.append("SELECT p.name ")
                             .append("FROM place p ")
                             .append("JOIN place_tag pt ON p.id = pt.place_id ")
                             .append("WHERE pt.tag_id IN (")
                             .append(String.join(",", Collections.nCopies(tagIds.size(), "?")))
                             .append(") ")
                             .append("GROUP BY p.id ")
                             .append("HAVING COUNT(DISTINCT pt.tag_id) = ?");

                        placeStmt = conn.prepareStatement(query.toString());
                        int idx = 1;
                        for (Integer tagId : tagIds) {
                            placeStmt.setInt(idx++, tagId);
                        }
                        placeStmt.setInt(idx, tagIds.size());

                        placeRs = placeStmt.executeQuery();

                        boolean found = false;
                        out.println("<h3>✅ 모든 태그를 포함한 장소:</h3>");
                        out.println("<ul>");
                        while (placeRs.next()) {
                            out.println("<li>" + placeRs.getString("name") + "</li>");
                            found = true;
                        }
                        out.println("</ul>");

                        if (!found) {
                            out.println("<p style='color:red;'>❌ 입력한 모든 태그를 포함한 장소가 없습니다.</p>");
                        }
                    }
                } catch (Exception e) {
                    out.println("<p style='color:red;'>오류 발생: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    // 리소스 해제
                    if (placeRs != null) try { placeRs.close(); } catch (SQLException e) {}
                    if (tagRs != null) try { tagRs.close(); } catch (SQLException e) {}
                    if (placeStmt != null) try { placeStmt.close(); } catch (SQLException e) {}
                    if (tagStmt != null) try { tagStmt.close(); } catch (SQLException e) {}
                    if (conn != null) try { conn.close(); } catch (SQLException e) {}
                }
            } else {
                out.println("<p style='color:red;'>❌ 태그를 입력해주세요.</p>");
            }
        }
    %>
</body>
</html>
--%>
