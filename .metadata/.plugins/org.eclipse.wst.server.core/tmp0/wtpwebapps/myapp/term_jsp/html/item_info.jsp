<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.time.*, java.time.format.DateTimeFormatter, java.time.temporal.ChronoUnit, termpackage.DBConnection" %>
<%@ page session="true" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 상세정보</title>
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../css/item_info.css"> 
</head>
<body style="overflow-x: hidden">
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
    	<div class="main-content">
        <div class="item-info">
            <%
                String productId = request.getParameter("product_id");
                if (productId != null) {
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        conn = DBConnection.getConnection();
                        String query = "SELECT pd_name, pd_price, pd_image, pd_information, category, trade_method, owner, created_at " +
                                       "FROM products WHERE product_id = ?";
                        pstmt = conn.prepareStatement(query);
                        pstmt.setInt(1, Integer.parseInt(productId));
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            String pdName = rs.getString("pd_name");
                            int pdPrice = rs.getInt("pd_price");
                            String pdImage = rs.getString("pd_image");
                            String pdInformation = rs.getString("pd_information");
                            String category = rs.getString("category");
                            String tradeMethod = rs.getString("trade_method");
                            String owner = rs.getString("owner");
                            Timestamp createdAtTimestamp = rs.getTimestamp("created_at");

                            // 현재 시간과 상품 등록 시간 비교
							LocalDateTime createdAt = createdAtTimestamp.toLocalDateTime();
							LocalDateTime now = LocalDateTime.now();
							long secondsBetween = ChronoUnit.SECONDS.between(createdAt, now);
							long minutesBetween = ChronoUnit.MINUTES.between(createdAt, now);
							long hoursBetween = ChronoUnit.HOURS.between(createdAt, now);
							long daysBetween = ChronoUnit.DAYS.between(createdAt, now);
							long monthsBetween = ChronoUnit.MONTHS.between(createdAt, now);
							long yearsBetween = ChronoUnit.YEARS.between(createdAt, now);
							
							String timeAgo;
							
							if (secondsBetween < 60) {
							    timeAgo = secondsBetween + "초 전";
							} else if (minutesBetween < 60) {
							    timeAgo = minutesBetween + "분 전";
							} else if (hoursBetween < 24) {
							    timeAgo = hoursBetween + "시간 전";
							} else if (daysBetween < 30) {
							    timeAgo = daysBetween + "일 전";
							} else if (monthsBetween < 12) {
							    timeAgo = monthsBetween + "개월 전";
							} else {
							    timeAgo = yearsBetween + "년 전";
							}

            %>
                            <!-- 상품 상세 정보 -->

			        <div class="product-header">
			            <!-- 왼쪽 이미지 영역 -->
					    <div class="photo-container">
					        <img src="<%= "../" + pdImage %>" alt="상품 이미지" class="product-image">
					    </div>
			            <!-- 세로 구분선 -->
			            <div style="width: 1px; height: 400px; background-color: #ddd; margin: 20px 0;
			            	 margin-right: 5px; margin-left: 15px;"></div>
			            <!-- 오른쪽 상품 정보 영역 -->
			            <div class="product-maininfo">
			                <div class="info-top">
			                    <a href="category_result.jsp?category=<%= java.net.URLEncoder.encode(category, "UTF-8") %>" class="category-link"><%= category %></a>>
			                    <a href="#" class="brand-link">삼성</a> 
			                    <div class="item-name"><%=pdName %></div>
			                </div>
						<div class="info-middle">
						    <div class="trade-info">
						        <div class="trade-method-info" style="display: flex; flex-wrap: wrap;">
						            <% 
						            boolean hasSell = tradeMethod != null && tradeMethod.contains("sell");
						            boolean hasExchange = tradeMethod != null && tradeMethod.contains("exchange");
						
						            // 거래 방식에 맞는 아이콘 추가
						            if (hasSell) { 
						            %>
						                <div class="trade-icon">
						                    <img src="../images/sell-icon.svg" alt="판매 아이콘">
						                </div>
						            <% } 
						
						            if (hasExchange) { 
						            %>
						                <div class="trade-icon">
						                    <img src="../images/trade-icon.svg" alt="교환 아이콘">
						                </div>
						            <% } 
						            %>
						        </div>
						        <div class="trade-details">
						            <a href="category_result.jsp?category=<%= java.net.URLEncoder.encode(category, "UTF-8") %>" class="category-link"><%= category %></a>
						            <div class="trade-price"><%= pdPrice %> 원</div>
						        </div>
						    </div>
						</div>




			                <div class="info-bottom">
			                    <div class="heart-count-icon"><img src="../images/fill-heart.svg"></div>
			                    <div class="heart-count">2</div>
			                    <div class="divider"></div>
			                    <div class="view-count-icon"><img src="../images/fill-eye.svg"></div>
			                    <div class="view-count">87</div>
			                    <div class="divider"></div>
			                    <div class="time-count-icon"><img src="../images/fill-clock.svg"></div>
			                    <div class="time-count"><%=timeAgo %></div>
			                    <a href="#" class="report-link">
			                        <div class="report-icon"><img src="../images/fill-report.svg"></div>
			                        <div class="report">신고하기</div>
			                    </a>
			                </div>
			                <div class="buttons">
			                    <a href="#" class="heart-button-link"><img src="../images/heart.svg" alt="쏙" class="heart-button"></a>
			                    <a href="#" class="chat-button">대화하기</a>
			                    <a href="trade-offer.jsp" class="trade-button">거래하기</a>
			                </div>
			            </div>
			        </div>
			        <div class="product-subinfo">
			            <div class="infotext">
			                <div class="infotext-title"><h2>상품정보</h2></div>
			                <div class="infotext-text"><%=pdInformation %></div>
			            </div>
			            <div class="shopinfo">
			                <div class="shopinfo-title"><h2>창고정보</h2></div>
			                <div class="shopinfo-top">
			                    <div class="shop-img"><img src="../images/account.svg"></div>
			                    <div class="shop-details">
			                        <div class="shop-name"><%=owner %>님의 창고</div>   <!-- 나중에 nickname으로 바꿔야할거같음 -->
			                        <div class="shop-sum">
			                            <a href="#">물품<div class="user-item-count">2</div></a>
			                            <div class="divider-small"></div>
			                            <a href="#">팔로워<div class="user-follower-count">10</div></a>
			                            <div class="divider-small"></div>
			                            <a href="#">거래후기<div class="user-review-count">4</div></a>
			                        </div>
			                    </div>
			                </div>
			                <div class="clover">
			                    <div class="clover-title">클로버지수</div>
			                    <div class="clover-point">53 / 100</div>
			                </div>
			                <div class="clover-bar">
			                    <div class="progress2 progress-moved">
			                        <div class="progress-bar2"></div>
			                    </div>
			                </div>
			            </div>
			        </div>
					<div class="simmilar">
    <div class="silmmiliar-title"><h2>비슷한 물품 추천</h2></div>
    <div class="lastest-item">
        <%
            if (productId != null && category != null) {
                PreparedStatement similarPstmt = null;
                ResultSet similarRs = null;
                try {
                    String similarQuery = "SELECT pd_name, pd_price, pd_image, product_id, trade_method FROM products " +
                                          "WHERE category = ? AND product_id != ? ORDER BY RAND() LIMIT 8";
                    similarPstmt = conn.prepareStatement(similarQuery);
                    similarPstmt.setString(1, category);
                    similarPstmt.setInt(2, Integer.parseInt(productId));
                    similarRs = similarPstmt.executeQuery();

                    while (similarRs.next()) {
                        String similarName = similarRs.getString("pd_name");
                        int similarPrice = similarRs.getInt("pd_price");
                        String similarImage = similarRs.getString("pd_image");
                        int similarId = similarRs.getInt("product_id");
          

                        String tradeIcons = ""; // 거래 아이콘 저장할 변수

                        if (tradeMethod != null) {
                            String[] methods = tradeMethod.split(","); // 거래 방식을 ','로 구분하여 배열로 분리
                            
                            // 각 거래 방식에 따라 아이콘을 추가
                            for (String method : methods) {
                                if ("exchange".equalsIgnoreCase(method.trim())) {
                                    tradeIcons += "<img src='../images/trade-icon.svg' alt='물물교환 아이콘' class='trade-icon'>";
                                } else if ("sell".equalsIgnoreCase(method.trim())) {
                                    tradeIcons += "<img src='../images/sell-icon.svg' alt='판매 아이콘' class='trade-icon'>";
                                }
                            }
                        }
        %>
                        <div class="product-container">
                            <div class="want-item">
                                <a href="item_info.jsp?product_id=<%= similarId %>">
                                    <img src="<%= "../" + similarImage %>" alt="<%= similarName %>" class="pd-image">
                                    <div class="item-details">
                                        <div class="pd-name"><%= similarName %></div>
                                        <div class="pd-price"><%= similarPrice %> 원<%= tradeIcons %>
                                        </div>
                                    </div>
                                </a>
                                <!-- 거래 방식 아이콘 추가 -->

                            </div>
                        </div>
        <%
                    }
                } catch (Exception e) {
                    out.println("<p>비슷한 물품을 가져오는 중 오류 발생: " + e.getMessage() + "</p>");
                } finally {
                    try { if (similarRs != null) similarRs.close(); } catch (SQLException ignored) {}
                    try { if (similarPstmt != null) similarPstmt.close(); } catch (SQLException ignored) {}
                }
            }
        %>
    </div>
</div>



            <%
                        } else {
                            out.println("<p>상품 정보를 찾을 수 없습니다.</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p>데이터베이스 오류: " + e.getMessage() + "</p>");
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
                        try { if (pstmt != null) pstmt.close(); } catch (SQLException ignored) {}
                        try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
                    }
                } else {
                    out.println("<p>상품 ID가 제공되지 않았습니다.</p>");
                }
            %>
        </div>
    </div>
    
    
    <script src="../scripts.js"></script>
</body>
</html>