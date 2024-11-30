package termpackage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // DB 연결 정보를 적절히 변경하세요.
    private static final String URL = "jdbc:mysql://localhost:3306/sample";
    private static final String USER = "root";
    private static final String PASSWORD = "root";
    
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");  // MySQL JDBC 드라이버 로드
            return DriverManager.getConnection(URL, USER, PASSWORD); // DB 연결
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}