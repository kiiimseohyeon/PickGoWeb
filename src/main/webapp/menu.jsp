<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%request.setCharacterEncoding("UTF-8"); %>
<style>
  .side-menu {
    width: 260px;
    height: 100vh;
    background-color: #A9A9A9;
    padding: 20px;
    position: fixed;
    top: 0;
    left: 0;
    overflow-y: auto;
    z-index: 999;
    box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
    transform: translateX(-100%);
    transition: transform 0.3s ease;
  }

  .side-menu.active {
    transform: translateX(0);
  }

  .close-btn {
    font-size: 20px;
    font-weight: bold;
    cursor: pointer;
    margin-bottom: 10px;
    float: right;
  }

  .region-title {
    font-weight: bold;
    font-size: 22px;
    margin-bottom: 10px;
    clear: both;
  }

  .region-list {
    margin-top: 20px;
    font-weight: bold;
    font-size: 18px;
  }

  .dong-list {
    margin-left: 15px;
    margin-top: 5px;
    font-size: 15px;
    color: #0077cc;
  }

  .dong-list span {
    display: inline-block;
    margin: 4px 8px 4px 0;
    padding: 4px 10px;
    background: #f0f0f0;
    border-radius: 12px;
    cursor: pointer;
  }

  .dong-list span:hover {
    background-color: #ccc;
    color: #000;
  }
</style>

<div class="side-menu" id="sideMenu">
  <div class="close-btn" onclick="toggleMenu()">✖</div>


  <div class="region-title">- 대전광역시</div>

<div class="region-list" onclick="goToRecommend('동구')">· 동구</div>
<div class="region-list" onclick="goToRecommend('중구')">· 중구</div>
<div class="region-list" onclick="goToRecommend('서구')">· 서구</div>
<div class="region-list" onclick="goToRecommend('서구')">· 유성구</div>
<div class="region-list" onclick="goToRecommend('서구')">· 대덕구</div>
</div>

<script>
  function toggleMenu() {
    const menu = document.getElementById("sideMenu");
    menu.classList.toggle("active");
  }

  function goToRecommend(dong) {
    location.href = 'regionResult.jsp?dong=' + encodeURIComponent(dong);
  }

  // 메뉴 클릭 연결
  const menuIcon = document.querySelector("menu-icon");
  const sideMenu = document.getElementById("sideMenu");

  if (menuIcon && sideMenu) {
    menuIcon.addEventListener("click", toggleMenu);
  } else {
    console.warn("menuIcon 또는 sideMenu 못 찾음");
  }
</script>
