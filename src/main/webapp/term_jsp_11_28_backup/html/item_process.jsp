<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="termpackage.DBConnection" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 처리</title>
    <script type="text/javascript">
        // 상품 등록 성공 후 알림을 띄우고 index.jsp로 리다이렉트
        function showAlertAndRedirect() {
            alert("상품 등록에 성공하셨습니다.");
            window.location.href = "../index.jsp"; // index.jsp로 리다이렉트
        }
    </script>
</head>
<body>
<%
    // 세션에서 로그인한 사용자의 아이디를 가져옴
    String owner = (String) session.getAttribute("username");  // 세션에서 사용자 아이디 가져오기

    // 만약 세션에 아이디가 없으면 로그인 페이지로 리다이렉트
    if (owner == null) {
        response.sendRedirect("login.html");  // 로그인 페이지로 리다이렉트
        return;
    }

    // 파일 업로드 처리
    String uploadPath = "D:\\term\\myapp\\src\\main\\webapp\\term_jsp\\upload"; // 파일 저장 경로
    int maxSize = 5 * 1024 * 1024; // 5MB 제한
    String encoding = "UTF-8";

    MultipartRequest multi = null;

    try {
        multi = new MultipartRequest(request, uploadPath, maxSize, encoding, new DefaultFileRenamePolicy());

        // 업로드된 파일명 및 데이터 수집
        Enumeration files = multi.getFileNames();
        List<String> pd_images = new ArrayList<>(); // 여러 이미지 파일을 저장할 리스트

        while (files.hasMoreElements()) {
            String fileInputName = (String) files.nextElement();
            String pd_image = multi.getFilesystemName(fileInputName); // 저장된 파일명
            if (pd_image != null) {
                pd_images.add("upload/" + pd_image); // 상대 경로 저장
            }
        }

        // 폼 데이터 수집
        String pd_name = multi.getParameter("pd_name");
        int pd_price = Integer.parseInt(multi.getParameter("pd_price"));
        String pd_information = multi.getParameter("pd_information");
        String category = multi.getParameter("category");
        String pd_status = multi.getParameter("pd_status");
        String trade_method = multi.getParameter("trade_method");  // 거래방식 (exchange, sell)
        String trade_system = multi.getParameter("trade_system");
        String location_1 = multi.getParameter("location_1"); // 거래 희망 지역 1
        String location_2 = multi.getParameter("location_2"); // 거래 희망 지역 2

        // 체크박스 상태 확인
        if (multi.getParameter("trade_exchange") != null) {
            trade_method = "exchange"; // 물물교환
        } else if (multi.getParameter("trade_sell") != null) {
            trade_method = "sell"; // 판매
        }

        if (multi.getParameter("trade_meet") != null) {
            trade_system = "meet"; // 물물교환
        } else if (multi.getParameter("trade_post") != null) {
            trade_system = "post"; // 판매
        }

        // 물물교환 가격 처리
        String trade_price = multi.getParameter("trade_price");
        String trade_max_price = multi.getParameter("trade_max_price");

        // 판매 가격 처리
        String sell_price = multi.getParameter("sell_price");

        // DB 저장
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();
            if (conn != null) {
                // SQL 작성 및 실행
                String sql = "INSERT INTO products (pd_name, pd_price, pd_image, pd_information, owner, pd_status, category, trade_method, trade_system, location_1, location_2) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, pd_name);
                stmt.setInt(2, pd_price);
                stmt.setString(3, String.join(",", pd_images)); // 여러 이미지 경로를 콤마로 구분하여 저장
                stmt.setString(4, pd_information);
                stmt.setString(5, owner);  // 로그인된 사용자 아이디를 owner로 설정
                stmt.setString(6, pd_status);
                stmt.setString(7, category);
                stmt.setString(8, trade_method);  // 거래 방식 (exchange, sell)
                stmt.setString(9, trade_system);  // 거래 방식 (exchange, sell)
                stmt.setString(10, location_1);
                stmt.setString(11, location_2);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<script type='text/javascript'>");
                    out.println("showAlertAndRedirect();");  // 상품 등록 성공 후 알림 및 리다이렉트
                    out.println("</script>");
                } else {
                    out.println("<p>상품 등록 실패. 다시 시도해 주세요.</p>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>SQL 에러 발생: " + e.getMessage() + "</p>");
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>파일 업로드 에러: " + e.getMessage() + "</p>");
    }
%>
</body>
</html>