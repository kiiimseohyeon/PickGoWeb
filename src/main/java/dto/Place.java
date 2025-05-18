//장소 정보 DTO
package db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

    private static final String URL = "jdbc:mysql://localhost:3306/ipp_pickgo"; // DB명에 맞게 수정
    private static final String USER = "root"; // 사용자명에 맞게 수정
    private static final String PASSWORD = "비밀번호"; // 실제 비밀번호로 수정

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버 로드
            return DriverManager.getConnection(URL, USER, PASSWORD); // 연결 반환
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
