<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, termpackage.DBConnection" %>
<%@ page import="java.io.*, javax.servlet.*" %>

<%
    // 로그인된 사용자 확인
    String username = (String) session.getAttribute("username");
    if (username == null) {
        out.println("<script>alert('로그인을 하셔야 이용하실 수 있습니다.'); location.href='../html/login.html';</script>");
        return; // 로그인하지 않은 경우, 리다이렉트
    }

    // 폼에서 전송된 값 수신
    String marketName = request.getParameter("market_name");  // POST 방식으로 전송된 값 수신
    String description = request.getParameter("description");
    String imageUrl = null;  // 기본적으로 이미지가 없을 수 있음

    // 디버그: 전송된 값 출력
    out.println("<p>전송된 마켓 이름: " + marketName + "</p>");
    out.println("<p>전송된 설명: " + description + "</p>");

    // 이미지 업로드 처리
    Part imagePart = request.getPart("image");  // 파일 업로드 부분 받기
    if (imagePart != null && imagePart.getSize() > 0) {
        String fileName = imagePart.getSubmittedFileName();
        String uploadPath = application.getRealPath("/uploads/") + fileName;

        // 파일 저장
        try (InputStream fileContent = imagePart.getInputStream()) {
            File file = new File(uploadPath);
            try (OutputStream os = new FileOutputStream(file)) {
                byte[] buffer = new byte[1024];
                int length;
                while ((length = fileContent.read(buffer)) != -1) {
                    os.write(buffer, 0, length);
                }
            }
            imageUrl = "uploads/" + fileName;  // 이미지 URL 저장
        } catch (IOException e) {
            out.println("<p>이미지 업로드 실패: " + e.getMessage() + "</p>");
        }
    }

    // 디버그: 이미지 URL 출력
    out.println("<p>이미지 URL: " + imageUrl + "</p>");

    // DB에 업데이트
    try (Connection conn = DBConnection.getConnection()) {
        String updateSQL = "UPDATE users SET market_name = ?, description = ?, image_url = ? WHERE id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(updateSQL)) {
            pstmt.setString(1, marketName);
            pstmt.setString(2, description);
            pstmt.setString(3, imageUrl);  // 이미지 URL은 null일 수 있음
            pstmt.setString(4, username);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                out.println("<p>장터 정보가 성공적으로 업데이트되었습니다.</p>");
            } else {
                out.println("<p>업데이트 실패. 다시 시도해주세요.</p>");
            }
        }
    } catch (SQLException e) {
        out.println("<p>DB 업데이트 중 오류가 발생했습니다: " + e.getMessage() + "</p>");
    }
%>

<a href="my_interface.jsp">내 정보로 돌아가기</a>
