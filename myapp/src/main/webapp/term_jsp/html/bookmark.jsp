<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, termpackage.DBConnection" %>
<%@ page session="true" %> 

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>바꾸다</title>
    <link rel="stylesheet" href="../styles.css">
</head>
<body>
<header class="header">
    <img src="../images/top_banner.svg" alt="맨위 로고" class="top-bar">
    <div class="search-bar">
        <a href="../index.jsp"><img src="../images/main_logo.svg" alt="로고" class="logo"></a>
        <form id="searchForm" action="search_result.html" method="GET">
            <div class="search-input-container">
                <input type="text" placeholder="🔍 물품명, 장터명, 카테고리 태그 등" class="search-input" id="searchInput" name="query">
                <button type="submit" class="search-button" id="searchButton">🔍</button>
            </div>
        </form>
        <div class="icons">
            <a href="../html/bookmark.jsp"><img src="../images/bookmark01.png" alt="북마크" class="icons"></a>
            <a href="#"><img src="../images/favorite01.png" alt="즐겨찾기" class="icons"></a>
            <a href="../html/my_interface.jsp"><img src="../images/interpace01.png" alt="내정보" class="icons"></a>

            <% 
            // 세션에서 username 가져오기
            String username = (String) session.getAttribute("username"); // 세션에서 사용자 이름 가져오기
            if (username != null) { 
            %>
                <span class="username-display"><%= username %></span>
                <a href="../html/logout.jsp">
                    <input type="button" class="logout-button" value="로그아웃">
                </a>
            <% 
            } else { 
            %>
                <a href="../html/login.html">
                    <input type="button" class="login-button" value="로그인">
                </a>
            <% 
            } 
            %>
        </div>
    </div>
    <nav class="manu-bar">
        <button class="category-btn">카테고리</button>
        <a href="../index.jsp#my-wants">내가 원해요</a>
        <a href="../index.jsp#others-wants">상대방이 원해요</a>
        <a href="#">급상승</a>
        <a href="#">쏙</a>
        <a href="#">이벤트</a>
        <a href="item.html">상품등록</a>
    </nav>
</header>
    <!--메인-->
    <div class="bookmark"> 북마크</div>
 <!-- 오른쪽바 -->
 <div style="flex: 0 0 auto;">
    <div class="container" id="stickyContainer">
        <button type="button" value="Top" onclick="clickme()" style="width: 100%; margin-bottom: 10px; padding: 5px; border-radius: 5px; background: white; border: 1px solid #0880F8;">Top</button>
        <div class="heart-container">
            <div class="heart">❤️</div>
            <span class="heart-count">2</span> <!-- 하트 받은 개수 -->
        </div>
        <hr class="divider"> <!-- 구분선-->
        
        <div class="recent-viewed">최근 본 상품</div>
        <ul id="recentViewedList"></ul> <!-- 최근 본 상품 목록 -->
        <ul id="delete-btn"></ul>
        <!-- 전체 삭제 버튼 -->
    </div>
</div>
</div>

    <script src="scripts.js"></script>
</body>
</html>
