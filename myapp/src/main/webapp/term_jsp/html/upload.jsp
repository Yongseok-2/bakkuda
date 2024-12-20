<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.File" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="termpackage.DBConnection" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 등록 처리</title>
</head>
<body>
    <h2>상품 등록 처리</h2>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // 폼 데이터 수집
        String pd_name = request.getParameter("pd_name");
        int pd_price = Integer.parseInt(request.getParameter("pd_price"));
        String pd_information = request.getParameter("pd_information");
        String category = request.getParameter("category");
        String owner = request.getParameter("owner");
        String pd_status = request.getParameter("pd_status");

        // 파일 업로드 처리
        Part filePart = request.getPart("pd_image");
        String fileName = filePart.getSubmittedFileName();
        String uploadPath = getServletContext().getRealPath("") + "uploads";

        // 업로드 디렉토리 생성
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // 파일 저장
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        // DB 저장
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBConnection.getConnection();
            if (conn != null) {
                // SQL 쿼리 작성
                String sql = "INSERT INTO products (pd_name, pd_price, pd_image, pd_information, owner, pd_status, category) VALUES (?, ?, ?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, pd_name);
                stmt.setInt(2, pd_price);
                stmt.setString(3, "uploads/" + fileName); // 상대 경로 저장
                stmt.setString(4, pd_information);
                stmt.setString(5, owner);
                stmt.setString(6, pd_status);
                stmt.setString(7, category);

                // SQL 실행
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<p>상품 등록 성공!</p>");
                    out.println("<a href='index.jsp'>메인 페이지로 돌아가기</a>");
                } else {
                    out.println("<p>상품 등록 실패. 다시 시도해 주세요.</p>");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>에러 발생: " + e.getMessage() + "</p>");
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
</body>
</html>
