<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="termpackage.DBConnection" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.io.IOException" %>

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
    <title>상품 등록</title>
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../css/item.css">
</head>
<body style="overflow-x: hidden">

    <!-- 상단 -->
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

<main>
    <div class="item-interface-container">
        <h2>물품 정보</h2>

        <form action="item_process.jsp" method="POST" enctype="multipart/form-data">
            <!-- 물품 이미지 업로드 -->
            <div class="item-img">
                <span id="image-count">물품 이미지(0/10)</span>
                <div class="photo-upload-container">
                    <div class="upload-box" id="custom-upload-box">
                        <img src="../images/add-photo.svg" alt="이미지등록">
                        이미지 등록
                    </div>
                    <input type="file" id="photo-input" accept="image/*" multiple hidden>
                </div>
                <div id="photo-preview"></div> <!-- 미리보기 영역 -->
            </div>
            <!-- 물품명 -->
            <div class="item-input-container">
                <span id="image-count">물품명</span>
                <input type="text" placeholder="물품명을 입력해주세요" class="item-input" name="pd_name" required>
            </div>

            <!-- 가격 -->
            <div class="item-input-container">
                <span id="image-count">가격</span>
                <input type="text" placeholder="가격을 입력해주세요" class="item-input" name="pd_price" required>
            </div>

            <!-- 설명 -->
            <div id="details">
                <span id="image-count">물품 설명</span>
                <textarea id="item_details" name="pd_information" rows="4" cols="50" placeholder="물품에 대한 자세한 설명을 적어주세요."></textarea>
            </div>

            <!-- 카테고리 및 상태 선택 -->
            <div class="item-cartegory-container">
                <span id="image-count">카테고리</span>
                <select class="item-cartegory" name="category[]">
                    <option value="" disabled selected>선택</option>
                    <option value="노트북">노트북</option>
                    <option value="지이잉">지이잉</option>
                    <option value="기타">기타</option>
                </select>
            </div>

            <!-- 거래 방식 -->
            <div class="item-trade-container">
                <span id="image-count">거래방식</span>
                <div class="trade-title-container">
                    <div class="trade-system">
					    <div class="trade-system-checkbox">
					        <div class="meet">
					            <input type="checkbox" id="meet-checkbox" name="trade_system[]" value="meet"> 직거래
					        </div>
					        <div class="post">
					            <input type="checkbox" id="post-checkbox" name="trade_system[]" value="post"> 택배
					        </div>
					    </div>
					</div>
				<div class="trade-method">
				    <div class="exchange">
				        <div class="trade-box">
				            <label id="trade-icon">
				                <input type="checkbox" id="trade-checkbox" name="trade_method[]" value="exchange"> 
				                <img src="../images/trade-icon.svg" alt="물물교환 아이콘" id="trade-icon">
				                물물교환
				            </label>
				        </div>
				    </div>
				    <div class="sell">
				        <div class="sell-box">
				            <label id="sell-icon">
				                <input type="checkbox" id="sell-checkbox" name="trade_method[]" value="sell">
				                <img src="../images/sell-icon.svg" alt="판매 아이콘" id="sell-icon">
				                판매
				            </label>
				        </div>
				    </div>
				</div>

                </div>
            </div>

            <!-- 물품 상태 -->
            <div class="item-condition">
                <span id="image-count">물품 상태</span>
                <fieldset>
                    <div class="radio-group">
                        <label>
                            <input type="radio" name="pd_status" value="new_item" required>
                            <span>새 물품(미사용)</span>
                        </label>
                        <label>
                            <input type="radio" name="pd_status" value="no_usage">
                            <span>사용감 없음</span>
                        </label>
                        <label>
                            <input type="radio" name="pd_status" value="light_usage">
                            <span>사용감 적음</span>
                        </label>
                        <label>
                            <input type="radio" name="pd_status" value="heavy_usage">
                            <span>사용감 많음</span>
                        </label>
                        <label>
                            <input type="radio" name="pd_status" value="broken">
                            <span>고장/파손 물품</span>
                        </label>
                    </div>
                </fieldset>
            </div>

            <!-- 거래 희망 지역 -->
            <div class="location-select-container">
                <span id="image-count">거래 희망 지역</span>
                <select class="location-select" name="location_1">
                    <option value="" disabled selected>선택</option>
                    <option value="서울">서울</option>
                    <option value="부산">부산</option>
                    <option value="대구">대구</option>
                </select>
                <span class="separator"> > </span>
                <select class="location-select" name="location_2">
                    <option value="" disabled selected>선택</option>
                    <option value="서울어딘가">서울어딘가</option>
                    <option value="어디어딘가">어디어딘가</option>
                    <option value="어딘가">어딘가</option>
                </select>
            </div>

            <!-- 제출 버튼 -->
            <div id="upload-container">
                <button id="upload-button" type="submit">상품 등록</button>
            </div>
        </form>
    </div>
</main>
    <script src="../scripts.js"></script>
    <script src="../js/itemscripts.js"></script>
</body>
</html>
