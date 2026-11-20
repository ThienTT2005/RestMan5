
package dao5;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO5 {

    private static final String DB_URL =
            "jdbc:mysql://localhost:3306/restman5"
                    + "?useUnicode=true"
                    + "&characterEncoding=UTF-8"
                    + "&serverTimezone=Asia/Ho_Chi_Minh";

    public static Connection connect() throws SQLException {

        String url = System.getenv().getOrDefault(
                "RESTMAN_DB_URL",
                DB_URL
        );

        String user = System.getenv().getOrDefault(
                "RESTMAN_DB_USER",
                "root"
        );

        String password = System.getenv().getOrDefault(
                "RESTMAN_DB_PASSWORD",
                "123456"
        );

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException(
                    "Không tìm thấy MySQL JDBC Driver. "
                            + "Hãy kiểm tra thư viện mysql-connector-j.",
                    e
            );
        }

        return DriverManager.getConnection(
                url,
                user,
                password
        );
    }
}
