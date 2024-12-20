<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, termpackage.DBConnection" %>
<%@ page session="true" %> 

<%
    String username = (String) session.getAttribute("username");


	if (username == null) {
	    // 로그인이 안된 경우 경고 문구와 리다이렉트 설정
	    out.println("<script>alert('로그인을 하셔야 이용하실 수 있습니다.'); location.href='../html/login.html';</script>");
	    return; // 이후 코드 실행 방지
    }
	String query = "SELECT market_name, description, user_image FROM users WHERE id = ?";
    String marketName = "알 수 없음"; // 기본값
    String description = ""; // 기본값
    String userImage = ""; // 기본값

    try (Connection conn = DBConnection.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(query)) {

        pstmt.setString(1, username); // 현재 로그인 사용자 설정
        try (ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                marketName = rs.getString("market_name");
                description = rs.getString("description");
                userImage = rs.getString("user_image");
            }
        }
    } catch (SQLException e) {
        out.println("<p>사용자 정보를 가져오는 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>마이페이지</title>
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../css/main2.css">
    <link rel="stylesheet" href="../css/interface.css">
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

    <!-- 메인 내용 -->
    <main class="interface-main">
        <div class="interface-container">
            <div class="photo-container" >
                <div class="empty-image">
                        <img src="<%= "../" + userImage %>" alt="<%= userImage %>" class="empty-image">
                </div>
			<div class="buttons">
			    <a href="test.jsp" class="chat-button">수정하기</a>
			</div>
			
            </div>
            <div class="interface-info-container">
                <div class="shop-name">
                    <h2 id="market-name-img"><%= marketName %></h2>
                </div>
                <textarea class="text-box" placeholder="<%= description != null ? description.replaceAll("\"", "&quot;") : "" %>"></textarea>
            </div>
            <div class="interface-second-container">
                <div class="shop-sum">
                    <a href="#"><div class="user-item"><div class="user-item-count">물품</div><div class="num-link">2</div></div></a>
                    <div style="width: 1px; height: 65px; background-color: #ddd;"></div>
                    <div class="user-follower"><div class="user-follower-count">팔로워</div><div class="num">10</div></div>
                    <div style="width: 1px; height: 65px; background-color: #ddd;"></div>
                    <a href="#"><div class="user-review"><div class="user-review-count">거래후기</div><div class="review-num">4</div></div></a>
                </div>
                <div class="clover">
                    <div class="clover-title">클로버지수</div>
                    <div class="clover-point">53  /  100</div>
                </div>
                <div class="clover-bar">
                    <div class="progress2 progress-moved">
                      <div class="progress-bar2">
                      </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="user-product-container">
            <div id="tab-menu">
              <div id="tab-btn">
                <ul>
                  <li class="active"><a href="#">전체상품</a></li>
                  <li><a href="#">판매중</a></li>
                  <li><a href="#">예약중</a></li>
                  <li><a href="#">판매완료</a></li>
                </ul>	
              </div>
              <div id="tab-cont">
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
							                hasResults = true; // 결과가 있으면 true로 설정
							
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
							                <div class="product-container">
							                    <div class="want-item">
							                        <a href="../html/item_info.jsp?product_id=<%= rs.getInt("product_id") %>">
							                            <img src="<%= "../" + rs.getString("pd_image") %>" alt="상품 이미지" class="pd-image">
							                            <h5 class="pd-name"><%= rs.getString("pd_name") %></h5>
							                            <p class="pd-price">
							                                ₩<%= rs.getInt("pd_price") %>
							                                <%= tradeIcons %>
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
            </div>
          </div>
    </main>

    <!-- 사이드바 -->
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
    <script src="../js/interface.js"></script>
</body>
</html>
s