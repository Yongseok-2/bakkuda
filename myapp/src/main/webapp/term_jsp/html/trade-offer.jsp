<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, termpackage.DBConnection" %>
<%
    String username = (String) session.getAttribute("username");


	if (username == null) {
	    // 로그인이 안된 경우 경고 문구와 리다이렉트 설정
	    out.println("<script>alert('로그인을 하셔야 이용하실 수 있습니다.'); location.href='../html/login.html';</script>");
	    return; // 이후 코드 실행 방지
    }
%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>바꾸다</title>
    <link rel="stylesheet" href="../styles.css">    
    <link rel="stylesheet" href="../css/trade-offer.css">
    <link rel="stylesheet" href="../css/main2	.css">
</head>
<body style="overflow-x: hidden">

    <!--상단-->
    	<header class="header">
        <img src="../images/top_banner.svg" alt="맨위 로고" class="top-bar">
        <div class="search-bar">
            <a href="../index.jsp"><img src="../images/main_logo.svg" alt="로고" class="logo"></a>
            <form id="searchForm" action="search_result.jsp" method="GET">
                <div class="search-input-container">
                    <input type="text" placeholder="🔍 물품명, 장터명, 카테고리 태그 등" class="search-input" id="searchInput" name="query">
                    <button type="submit" class="search-button" id="searchButton">🔍</button>
                </div>
            </form>
            <div class="icons">
                <a href="bookmark.jsp"><span><img src="../images/bookmark01.png" alt="북마크" class="icons"></span></a>
                <span><img src="../images/favorite01.png" alt="즐겨찾기" class="icons"></span>
                <a href="my_interface.jsp"><span><img src="../images/interpace01.png" alt="내정보" class="icons"></span></a>

                <% 
                // 로그인 상태 확인 후 아이디와 로그아웃 버튼 표시
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
        <nav class="menu-bar">
            <ul>
                <li><a href="#"><img src="../images/category.svg" alt="카테고리">카테고리</a></li>
                <li><a href="../index.html#my-wants">내가 원해요</a></li>
                <li><a href="../index.html#others-wants">상대방이 원해요</a></li>     
                <li><a href="#">급상승</a></li>
                <li><a href="#">쏙</a></li>
                <li><a href="#">이벤트</a></li>
                <li><a href="item.jsp">상품등록</a></li>
                
            </ul>
        </nav>
        
    </header>

    <!-- 상품 등록 폼 (항상 보이도록 설정) -->
   <main>
    <div class="item-interface-container">
        <h2>교환할 물품</h2>
        <div class="lastest-item">
        <%
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement pstmt = conn.prepareStatement(
                     "SELECT product_id, pd_name, pd_price, pd_image, trade_method " +
                     "FROM products WHERE owner = ?")) { // owner 조건만 포함

                pstmt.setString(1, username); // 현재 로그인 사용자 설정

                try (ResultSet rs = pstmt.executeQuery()) {
                    boolean hasResults = false; // 결과 유무 확인
                    while (rs.next()) {
                        hasResults = true;
                        String tradeMethod = rs.getString("trade_method");
                        String tradeIcon = "images/default-icon.svg"; // 기본 아이콘

                        if ("exchange".equalsIgnoreCase(tradeMethod)) {
                            tradeIcon = "../images/trade-icon.svg"; // 교환 아이콘
                        } else if ("sell".equalsIgnoreCase(tradeMethod)) {
                            tradeIcon = "../images/sell-icon.svg"; // 판매 아이콘
                        }
        %>
                        <div class="product-container">
                        	<input type="radio" id="product1" name="selectedProduct" value="상품명 예시">
                            <div class="want-item">
                                <a href="../html/item_info.jsp?product_id=<%= rs.getInt("product_id") %>">
                                    <img src="<%= "../" + rs.getString("pd_image") %>" alt="상품 이미지" class="pd-image">
                                    <h5 class="pd-name"><%= rs.getString("pd_name") %></h5>
                                    <p class="pd-price">
                                        ₩<%= rs.getInt("pd_price") %>
                                        <img src="<%= tradeIcon %>" alt="<%= tradeMethod %>" class="trade-icon">
                                    </p>
                                </a>
                            </div>
                        </div>
        <%
                    }
                    if (!hasResults) {
                        out.println("<p>등록된 물품이 없습니다.</p>");
                    }
                }
            } catch (SQLException e) {
                out.println("<p>상품 정보를 로드하는 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
            }
        %>
        </div>
    </div>
</main>

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

    <script src="../scripts.js"></script>
</body>
</html>
