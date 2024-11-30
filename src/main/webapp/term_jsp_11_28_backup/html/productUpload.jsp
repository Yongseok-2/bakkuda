<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="termpackage.DBConnection" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.servlet.http.Part" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 등록 처리</title>
</head>
<body>
    <h1>상품 등록 처리</h1>
<%
    // 폼에서 전달된 값 받기
    String pd_name = request.getParameter("pd_name");
    String pd_price_str = request.getParameter("pd_price");
    String pd_information = request.getParameter("pd_information");
    String category = request.getParameter("category");
    String owner = request.getParameter("owner");

    // 가격 값이 비어 있지 않다면 정수로 변환
    int pd_price = 0;
    if (pd_price_str != null && !pd_price_str.isEmpty()) {
        try {
            pd_price = Integer.parseInt(pd_price_str);
        } catch (NumberFormatException e) {
            // 가격이 숫자가 아닌 경우 오류 처리
            out.println("<p>가격을 올바르게 입력해주세요.</p>");
            return;
        }
    } else {
        // 가격을 입력하지 않은 경우
        out.println("<p>가격을 입력해주세요.</p>");
        return;
    }

    // 상품 정보와 나머지 값 처리
    // ...
%>

</body>
</html>
