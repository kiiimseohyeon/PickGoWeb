<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*, java.util.*, java.net.URLDecoder" %>
<%
    String district = request.getParameter("district");
    if (district == null) district = "알 수 없음";
    district = URLDecoder.decode(district, "UTF-8");

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
        ps.setString(1, district);
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
                case "food": foodList.add(place); break;
                case "cafe": cafeList.add(place); break;
                case "spot": spotList.add(place); break;
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
  <title><%= district %> 추천 장소</title>
  <style>
    body { font-family: Arial, sans-serif; margin:0; padding:0; background:#fafafa; color: #000; }
    header {
      background: #f0f0f0; 
      color: #000; 
      display: flex;
      align-items: center;
      padding: 15px 25px;
    }
    .logo { font-size: 26px; font-weight: bold; flex-grow: 1; color: #000; }
    .back-btn {
      cursor: pointer; font-size: 18px; color: #555; 
      user-select: none;
      transition: color 0.3s ease;
    }
    .back-btn:hover { color: #999; }
    h2 {
      margin: 30px 20px 15px;
      color: #000;
      border-bottom: 2px solid #777;
      padding-bottom: 5px;
    }
    .gallery {
      display: flex; flex-wrap: wrap; justify-content: center;
      gap: 20px; padding: 0 20px 40px;
    }
    .place {
      width: 220px; background: white; border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      overflow: hidden; text-align: center;
      transition: transform 0.3s ease;
    }
    .place:hover { transform: translateY(-5px); }
    .place img {
      width: 100%; height: 140px; object-fit: cover;
      display: block;
    }
    .place-name {
      font-weight: bold; padding: 12px 10px; font-size: 16px;
      color: #000;
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

  <header>
    <div class="logo"><%= district %> 추천 장소</div>
    <div class="back-btn" onclick="history.back()">← 뒤로가기</div>
  </header>

  <section>
    <h2>맛집 - 음식점</h2>
    <div class="gallery">
      <% if (foodList.isEmpty()) { %>
        <div class="empty-msg">해당 지역의 맛집 정보가 없습니다.</div>
      <% } else {
        for (String[] place : foodList) { %>
          <div class="place">
            <img src="<%= place[0] %>" alt="<%= place[1] %> 사진" />
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
            <img src="<%= place[0] %>" alt="<%= place[1] %> 사진" />
            <div class="place-name" title="<%= place[1] %>"><%= place[1] %></div>
          </div>
      <% } } %>
    </div>
  </section>

  <section>
    <h2>볼거리</h2>
    <div class="gallery">
      <% if (spotList.isEmpty()) { %>
        <div class="empty-msg">해당 지역의 볼거리 정보가 없습니다.</div>
      <% } else {
        for (String[] place : spotList) { %>
          <div class="place">
            <img src="<%= place[0] %>" alt="<%= place[1] %> 사진" />
            <div class="place-name" title="<%= place[1] %>"><%= place[1] %></div>
          </div>
      <% } } %>
    </div>
  </section>

</body>
</html>
