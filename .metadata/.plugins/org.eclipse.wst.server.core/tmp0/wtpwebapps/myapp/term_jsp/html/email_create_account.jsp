<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>바꾸다</title>
    <link rel="stylesheet" href="../styles.css">
    <link rel="stylesheet" href="../css/style-login.css">
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
    <script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
</head>
<body>
<body style="overflow-x: hidden">

    <!-- 상단 -->
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
    
	<main class="login-main">
	  <img src="../images/main_logo.svg" alt="로고" class="login-logo">
	  <div class="login-container">
		<form id="signup-form" action="email_create_process.jsp" method="POST">
		    <div class="input-group">
		        <label for="user-id">아이디</label>
		        <input type="text" id="id" name="id" placeholder="아이디를 입력하세요" required>
		    </div>
		    <div class="input-group">
		        <label for="user-password">비밀번호</label>
		        <input type="password" id="password" name="pw" placeholder="비밀번호를 입력하세요" required>
		    </div>
		    <div class="input-group">
		        <label for="user-password-confirm">비밀번호 재입력</label>
		        <input type="password" id="confirm-password" name="confirm_pw" placeholder="비밀번호를 다시 입력하세요" required>
		    </div>
		    <button type="submit" class="login-button">회원가입</button>
		</form>

	  </div>
	</main>
  
  
<script>
    document.getElementById('signup-form').addEventListener('submit', function(event) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirm-password').value;

        if (password !== confirmPassword) {
            event.preventDefault();
            alert('비밀번호가 일치하지 않습니다. 다시 확인해주세요.');
        }
    });
</script>




    <script src="../scripts.js"></script>
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
    <script type="text/javascript"></script>
</body>
</html>
