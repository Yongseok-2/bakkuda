<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="termpackage.DBConnection" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입 처리</title>
</head>
<body>
<%
    // 사용자 입력 값 가져오기
    String userId = request.getParameter("id");
    String userPw = request.getParameter("pw");
    String confirmPw = request.getParameter("confirm_pw"); // 비밀번호 확인 필드 추가

    // 유효성 검사
    if (userId == null || userId.trim().isEmpty() || userPw == null || userPw.trim().isEmpty() || confirmPw == null || confirmPw.trim().isEmpty()) {
        out.println("<script>alert('아이디, 비밀번호, 비밀번호 확인을 모두 입력해주세요.'); history.back();</script>");
        return;
    }

    // 비밀번호 일치 확인
    if (!userPw.equals(confirmPw)) {
        out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 데이터베이스 연결
        conn = DBConnection.getConnection();

        // 아이디 중복 검사
        String checkSql = "SELECT id FROM users WHERE id = ?";
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setString(1, userId);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // 아이디가 이미 존재하는 경우
            out.println("<script>alert('이미 사용 중인 아이디입니다.'); history.back();</script>");
            return;
        }

        // SQL 작성: 사용자 정보를 데이터베이스에 삽입
        String sql = "INSERT INTO users (id, pw) VALUES (?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        pstmt.setString(2, userPw);

        // 데이터 삽입
        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 회원가입 성공 시, 로그인 페이지로 리디렉션하며 사용자 이름을 포함한 축하 메시지 출력
            out.println("<script>alert('회원가입을 축하드립니다, " + userId + "님!'); window.location.href = 'login.html';</script>");
        } else {
            out.println("<script>alert('회원가입에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('에러가 발생했습니다: " + e.getMessage() + "'); history.back();</script>");
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
</body>
</html>
