<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, termpackage.DBConnection" %>
<%@ page session="true" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>

<%
    // 로그인된 사용자 ID 가져오기 (세션에서)
    String userId = (String) session.getAttribute("username");

    // 로그인되지 않은 경우 리다이렉트
    if (userId == null) {
        out.println("<script>alert('로그인이 필요합니다.'); location.href='../html/login.html';</script>");
        return;
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // 업로드 디렉토리 설정
        String uploadPath = "C:\\Users\\Beomryeol\\git\\bagguda\\myapp\\src\\main\\webapp\\term_jsp\\upload";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // MultipartRequest 객체 생성
        MultipartRequest multi = new MultipartRequest(request, uploadPath, 10 * 1024 * 1024, "UTF-8", new DefaultFileRenamePolicy());

        // 폼 데이터 읽기
        String marketName = multi.getParameter("market_name");
        String description = multi.getParameter("description");
        String fileName = multi.getFilesystemName("user_image"); // 업로드된 파일 이름

        // 업로드된 파일 경로 설정
        String filePath = "upload/" + fileName;

        // 값 확인 (디버깅용)
        System.out.println("전송된 마켓 이름: " + marketName);
        System.out.println("전송된 설명: " + description);
        System.out.println("저장된 이미지 경로: " + filePath);

        // 데이터베이스에 업데이트 수행
        try (Connection conn = DBConnection.getConnection()) {
            String updateQuery = "UPDATE users SET market_name = ?, description = ?, user_image = ? WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(updateQuery)) {
                pstmt.setString(1, marketName);
                pstmt.setString(2, description);
                pstmt.setString(3, filePath); // 업로드된 파일 경로 저장
                pstmt.setString(4, userId);

                int rowsUpdated = pstmt.executeUpdate();
                if (rowsUpdated > 0) {
                    out.println("<script>alert('장터 정보가 성공적으로 업데이트되었습니다.'); location.href='my_interface.jsp';</script>");
                } else {
                    out.println("<script>alert('업데이트 실패. 다시 시도해주세요.'); location.href='test.jsp';</script>");
                }
            }
        } catch (SQLException e) {
            System.out.println("데이터베이스 오류: " + e.getMessage());
            out.println("<script>alert('데이터베이스 오류가 발생했습니다.'); location.href='test.jsp';</script>");
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장터 정보 수정</title>
</head>
<body>
    <h2>장터 정보 수정</h2>
    <form method="POST" action="test.jsp" enctype="multipart/form-data">
        <div>
            <label for="market_name">장터 이름:</label>
            <input type="text" id="market_name" name="market_name" required><br>
        </div>
        <div>
            <label for="description">장터 설명:</label>
            <textarea id="description" name="description" required></textarea><br>
        </div>
        <div>
            <label for="user_image">이미지 업로드:</label>
            <input type="file" id="user_image" name="user_image" accept="image/*" required><br>
        </div>
        <button type="submit">수정하기</button>
    </form>
</body>
</html>
