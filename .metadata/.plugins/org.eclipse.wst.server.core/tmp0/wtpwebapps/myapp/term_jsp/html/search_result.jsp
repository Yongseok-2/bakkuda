<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, termpackage.DBConnection" %>
<%@ page session="true" %> <!-- 세션을 사용할 수 있도록 추가 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>바꾸다</title>
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../css/main2.css">
</head>
<body style="overflow-x: hidden">
	<header class="header">
	    <img src="../images/top_banner.svg" alt="맨위 로고" class="top-bar">
	    <div class="search-bar">
	        <a href="../index.jsp"><img src="../images/main_logo.svg" alt="로고" class="logo"></a>
	        <form id="searchForm" action="search_result.jsp" method="GET"> <!-- search_result.jsp로 GET 방식 요청 -->
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
	            String username = (String) session.getAttribute("username");
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
	<main>
	        <div class="banner-container">
            	<div class="banner">
                	<img src="images/main_banner1.svg" alt="배너" class="banner-img">
            	</div>
        	</div>
	    <!-- 최근 상품 -->
	    <div class="lastest-item-title"><h2>검색 결과</h2></div>
	    <div class="lastest-item">
	        <%
	            String query = request.getParameter("query"); // 검색어를 가져옴
	
	            if (query != null && !query.trim().isEmpty()) { // 검색어가 있을 경우
	                Connection conn = DBConnection.getConnection();
	                if (conn != null) {
	                    try (PreparedStatement pstmt = conn.prepareStatement(
	                            "SELECT product_id, pd_name, pd_price, pd_image, trade_method " +
	                                    "FROM products " +
	                                    "WHERE pd_name LIKE ?");
	                         ) {
	                        pstmt.setString(1, "%" + query + "%"); // 검색어를 LIKE 조건에 추가
	
	                        try (ResultSet rs = pstmt.executeQuery()) {
	                        	while (rs.next()) {
				                     String tradeMethod = rs.getString("trade_method"); // trade_method 값을 가져옴
				                     String tradeIcons = "";

				                     // trade_method가 ','로 구분된 값을 포함할 수 있기 때문에 이를 처리
				                     if (tradeMethod != null) {
				                         String[] methods = tradeMethod.split(","); // 콤마로 구분된 값을 배열로 분리

				                         // 'exchange'와 'sell' 값을 확인해서 각각 아이콘을 지정
				                         for (String method : methods) {
				                             if ("exchange".equalsIgnoreCase(method.trim())) {
				                                 tradeIcons += "<img src='../images/trade-icon.svg' alt='물물교환 아이콘' class='trade-icon'>"; // 교환 아이콘
				                             } else if ("sell".equalsIgnoreCase(method.trim())) {
				                                 tradeIcons += "<img src='../images/sell-icon.svg' alt='판매 아이콘' class='trade-icon'>"; // 판매 아이콘
				                             }
				                         }
				                     }
	        %>
	                                <!-- 검색된 상품 출력 -->
			                    <div class="product-container">
				                    <div class="want-item">
				                        <a href="html/item_info.jsp?product_id=<%= rs.getString("product_id") %>">
				                            <img src="<%= "../"+rs.getString("pd_image") %>" alt="상품 이미지" class="pd-image">
				                            <h5 class="pd-name"><%= rs.getString("pd_name") %></h5>
				                            <p class="pd-price">
				                                <%= rs.getInt("pd_price") %> 원
				                                <%= tradeIcons %> <!-- 동적으로 아이콘을 출력 -->
				                            </p>
				                        </a>
				                    </div>
				                </div>
			                    
			                    
			                    
	        <%
	                            }
	                        } catch (SQLException e) {
	                            out.println("쿼리 실행 중 오류 발생: " + e.getMessage());
	                        }
	                    } catch (SQLException e) {
	                        out.println("DB 연결 오류: " + e.getMessage());
	                    }
	                } else {
	                    out.println("DB 연결 실패");
	                }
	            } else {
	                out.println("검색어를 입력해 주세요.");
	            }
	        %>	
	    </div>
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
	</main>

	<script src="../scripts.js"></script>
</body>
</html>
