<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그아웃</title>
</head>
<body>
<%
    // 세션 무효화: 로그인 상태를 종료
    session.invalidate(); // 세션 무효화
    // 로그아웃 후 메인 화면으로 리디렉션
    response.sendRedirect("../index.jsp"); // index.jsp로 리디렉션
%>
</body>
</html>