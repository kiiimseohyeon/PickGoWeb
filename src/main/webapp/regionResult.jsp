//지역 기반 추천 결과
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.sql.*, java.util.*, java.net.URLDecoder" %>
<%

    String dong = request.getParameter("dong");
    if (dong == null) dong = "알 수 없음";
    dong = URLDecoder.decode(dong, "UTF-8");

    String DB_URL = "jdbc:mysql://localhost:3306/ipp_pickgo?useSSL=false&serverTimezone=UTC";
    String DB_USER = "root";
    String DB_PASSWORD = "1234";

    List<String[]> foodList = new ArrayList<>();
    List<String[]> cafeList = new ArrayList<>();
    List<String[]> spotList = new ArrayList<>();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

        String sql = "SELECT p.name, p.image_url, p.category " +
                     "FROM place p " +
                     "JOIN district d ON p.district_id = d.id " +
                     "WHERE d.name = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, dong);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            String name = rs.getString("name");
            String rawUrl = rs.getString("image_url");
            String category = rs.getString("category");
            String imageUrl = (rawUrl != null && !rawUrl.trim().isEmpty())
                                ? rawUrl.replace("https://ibb.co/", "https://i.ibb.co/") + ".jpg"
                                : "";

            String[] place = new String[]{imageUrl, name};

            switch (category) {
                case "맛집": foodList.add(place); break;
                case "카페": cafeList.add(place); break;
                case "놀거리": spotList.add(place); break;
            }
        }

        rs.close();
        ps.close();
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>DB 오류: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title><%= dong %> 추천 장소</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/pickgo.css">
  <style>
    body { font-family: Arial, sans-serif; margin:0; padding:0; background:#000; color: #fff; }
    header {
      background:  #111; 
      color: #fff; 
      display: flex;
      align-items: center;
      padding: 15px 25px;
    }
    .logo { font-size: 26px; font-weight: bold; flex-grow: 1; color: #000; }
    .back-btn {
      cursor: pointer; font-size: 18px; color: #555; 
      user-select: none;
      transition: color 0.3s ease;
      color: #fff;
    }
    .back-btn:hover { color: #ccc; }
    h2 {
      margin: 30px 20px 15px;
      color: #fff;
      border-bottom: 2px solid #777;
      padding-bottom: 5px;
    }
    .gallery {
      display: flex;
      flex-wrap: nowrap;
      overflow-x: auto;
      gap: 20px;
      padding: 0 20px 40px;
      scroll-snap-type: x mandatory;
      -webkit-overflow-scrolling: touch;
    }
    .gallery::-webkit-scrollbar {
      height: 8px;
    }
    .gallery::-webkit-scrollbar-thumb {
      background: #ccc;
      border-radius: 4px;
    }
    .place {
      flex: 0 0 auto;
      width: 220px;
      background: #111;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      overflow: hidden;
      text-align: left;  /* 이미지 왼쪽 정렬 */
      transition: transform 0.3s ease;
      scroll-snap-align: start;
    }
    .place:hover { transform: translateY(-5px); }
    .place img {
      width: 100%; height: 140px; object-fit: cover;
      display: block;
      margin: 0;  /* 좌우 여백 제거 */
    }
    .place-name {
      font-weight: bold; padding: 12px 10px; font-size: 16px;
      color: #fff;
      white-space: nowrap;
      text-overflow: ellipsis;
      overflow: hidden;
    }
    .empty-msg {
      color: #666; font-style: italic; margin: 10px 0 30px;
      width: 100%; text-align: center;
    }
  </style>
</head>
<body>
<% request.setCharacterEncoding("UTF-8"); %>
   <header style="display: flex; justify-content: space-between; align-items: center; padding: 15px 25px; background: #000;">
  
  <!-- 추천 장소  -->
  <div style="flex: 1; text-align: left; font-size: 22px; font-weight: bold; ">
    <%= dong %> 추천 장소
  </div>

  <!-- 로고 -->
  <div style="flex: 1; text-align: center;">
    <img src="<%= request.getContextPath() %>/images/logo.png" alt="Logo" style="height: 45px;" />
  </div>

  <!-- 뒤로가기 버튼 -->
  <div class="back-btn" onclick="history.back()" style="flex: 1; text-align: right; font-size: 18px; color: #555; cursor: pointer;">
    ← 뒤로가기
  </div>

</header>



  <section>
    <h2>맛집 - 음식점</h2>
    <div class="gallery">
      <% if (foodList.isEmpty()) { %>
        <div class="empty-msg">해당 지역의 맛집 정보가 없습니다.</div>
      <% } else {
        for (String[] place : foodList) { %>
          <div class="place">
          <a href="/information.jsp?placeId=<%= place[1] %>">
            <img src="<%= place[0] %>" alt="<%= place[1] %> 사진" />
            </a>
            <div class="place-name" title="<%= place[1] %>"><%= place[1] %></div>
          </div>
      <% } } %>
    </div>
  </section>

  <section>
    <h2>카페</h2>
    <div class="gallery">
      <% if (cafeList.isEmpty()) { %>
        <div class="empty-msg">해당 지역의 카페 정보가 없습니다.</div>
      <% } else {
        for (String[] place : cafeList) { %>
          <div class="place">
          <a href="/information.jsp?placeId=<%= place[1] %>">
            <img src="<%= place[0] %>" alt="<%= place[1] %> 사진" />
            </a>
            <div class="place-name" title="<%= place[1] %>"><%= place[1] %></div>
          </div>
      <% } } %>
    </div>
  </section>

  <section>
    <h2>놀거리</h2>
    <div class="gallery">
      <% if (spotList.isEmpty()) { %>
        <div class="empty-msg">해당 지역의 볼거리 정보가 없습니다.</div>
      <% } else {
        for (String[] place : spotList) { %>
          <div class="place">
          <a href="/information.jsp?placeId=<%= place[1] %>">
            <img src="<%= place[0] %>" alt="<%= place[1] %> 사진" />
            </a>
            <div class="place-name" title="<%= place[1] %>"><%= place[1] %></div>
          </div>
      <% } } %>
    </div>
  </section>
  <%@ include file="footer.jsp" %>
</body>
</html>
