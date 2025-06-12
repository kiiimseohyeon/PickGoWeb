package pick_go.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DataBase {
    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/ipp_pickgo?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
            "root",
            "1234"
        );
    }
}
