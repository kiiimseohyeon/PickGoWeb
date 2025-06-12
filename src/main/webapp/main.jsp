<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PickGo</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/pickgo.css">
</head>
<body>

    <%@ include file="header.jsp" %>
    <%@ include file="menu.jsp" %>
    <%@ include file="mainBanner.jsp" %>
    <%@ include file="carousel.jsp" %>

    <jsp:include page="category.jsp">
        <jsp:param name="title" value="놀거리" />
    </jsp:include>

    <%@ include file="footer.jsp" %>

  <script>
  document.addEventListener("DOMContentLoaded", function () {
    const menuIcon = document.querySelector(".menu-icon");
    const sideMenu = document.getElementById("sideMenu");

    if (menuIcon && sideMenu) {
      menuIcon.addEventListener("click", function () {
        sideMenu.classList.toggle("active");
      });
    } else {
      console.warn("menuIcon 또는 sideMenu가 없습니다.");
    }
  });
</script>

</body>
</html>
