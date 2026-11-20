
package dao5;

import model5.Customer5;
import model5.Member5;
import model5.Staff5;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AuthDAO5 extends DAO5 {

    public Member5 login(
            String username,
            String password
    ) throws SQLException {

        String sql =
                "SELECT m.id, m.username, m.name, " +
                        "m.address, m.email, m.phone, " +
                        "s.position, c.memberId AS customerId " +
                        "FROM tblMember5 m " +
                        "LEFT JOIN tblStaff5 s ON s.memberId = m.id " +
                        "LEFT JOIN tblCustomer5 c ON c.memberId = m.id " +
                        "WHERE m.username = ? AND m.password = ?";

        try (
                Connection con = DAO5.connect();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {

                if (!rs.next()) {
                    return null;
                }

                Member5 member;

                String position = rs.getString("position");

                if (position != null) {

                    Staff5 staff = new Staff5();
                    staff.setPosition(position);

                    member = staff;

                } else if (rs.getObject("customerId") != null) {

                    member = new Customer5();

                } else {

                    member = new Member5();
                }

                member.setId(rs.getLong("id"));
                member.setUsername(rs.getString("username"));
                member.setName(rs.getString("name"));
                member.setAddress(rs.getString("address"));
                member.setEmail(rs.getString("email"));
                member.setPhone(rs.getString("phone"));

                return member;
            }
        }
    }
}
