<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, termpackage.DBConnection" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>카테고리 결과</title>
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../css/search-result.css">
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
    <main>
        <div class="lastest-item-title">
            <h2>카테고리 결과: <%= request.getParameter("category") %></h2>
        </div>
        <div class="lastest-item">
            <%
                String category = request.getParameter("category"); // URL에서 카테고리 값 가져오기

                if (category != null && !category.trim().isEmpty()) {
                    try (Connection conn = DBConnection.getConnection();
                         PreparedStatement pstmt = conn.prepareStatement(
                             "SELECT product_id, pd_name, pd_price, pd_image, trade_method " +
                             "FROM products WHERE category = ?")) {

                        pstmt.setString(1, category); // 카테고리 값 설정
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
                                <div class="product-container">
                                    <div class="want-item">
                                       <a href="../html/item_info.jsp?product_id=<%= rs.getInt("product_id") %>">
                                           <img src="<%= "../" + rs.getString("pd_image") %>" alt="상품 이미지" class="pd-image">
                                           <h5 class="pd-name"><%= rs.getString("pd_name") %></h5>
                                           <p class="pd-price">
                                               ₩<%= rs.getInt("pd_price") %>
                                               <%= tradeIcons.replaceAll("<img ", "<img style='width: 20px; height: 20px;' ") %>
                                           </p>
                                        </a>
                                    </div>
                                </div>
            <%
                            }
                        }
                    } catch (SQLException e) {
                        out.println("<p>상품 정보를 로드하는 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
                    }
                } else {
                    out.println("<p>검색어를 입력해주세요.</p>");
                }
            %>
        </div>
    </main>
    <script src="../scripts.js"></script>
</body>
</html>
