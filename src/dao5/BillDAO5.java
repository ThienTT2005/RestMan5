package dao5;

import model5.*;

import java.sql.*;

import java.math.*;

public class BillDAO5 extends DAO5 {

    public Bill5 getBillByOrder(Order5 order) throws SQLException {
        String sql = "SELECT b.*,mc.id customerMemberId,mc.name customerName,ms.id staffMemberId,ms.name staffName,s.position,card.code,card.createDate,card.status cardStatus,card.pointsBalance,card.totalPointsEarned,card.totalPointsUsed,card.customerId cardCustomerId FROM tblBill5 b LEFT JOIN tblMember5 mc ON mc.id=b.customerId LEFT JOIN tblMember5 ms ON ms.id=b.staffId LEFT JOIN tblStaff5 s ON s.memberId=b.staffId LEFT JOIN tblMembershipCard5 card ON card.id=b.membershipCardId WHERE b.orderId=?";
        try (Connection c = DAO5.connect();PreparedStatement p = c.prepareStatement(sql)) {
            p.setLong(1, order.getId());
            try (ResultSet r = p.executeQuery()) {
                if (!r.next())return null;
                Bill5 b = new Bill5();
                b.setId(r.getLong("id"));
                b.setOrder(order);
                b.setPaymentTime(r.getTimestamp("paymentTime"));
                b.setTotalAmount(order.getTotalAmount());
                b.setPointsUsed(r.getInt("pointsUsed"));
                b.setPointsEarned(r.getInt("pointsEarned"));
                BigDecimal discount = BigDecimal.valueOf(b.getPointsUsed()).multiply(new BigDecimal("1000"));
                b.setDiscountAmount(discount);
                b.setFinalAmount(b.getTotalAmount().subtract(discount).max(BigDecimal.ZERO));
                if (r.getObject("customerMemberId")!=null) {
                    Customer5 customer = new Customer5();
                    customer.setId(r.getLong("customerMemberId"));
                    customer.setName(r.getString("customerName"));
                    b.setCustomer(customer);
                }
                if (r.getObject("staffMemberId")!=null) {
                    Staff5 staff = new Staff5();
                    staff.setId(r.getLong("staffMemberId"));
                    staff.setName(r.getString("staffName"));
                    staff.setPosition(r.getString("position"));
                    b.setStaff(staff);
                }
                if (r.getObject("membershipCardId")!=null) {
                    MembershipCard5 card = new MembershipCard5();
                    card.setId(r.getLong("membershipCardId"));
                    card.setCode(r.getString("code"));
                    card.setCreateDate(r.getTimestamp("createDate"));
                    card.setStatus(r.getString("cardStatus"));
                    card.setPointsBalance(r.getInt("pointsBalance"));
                    card.setTotalPointsEarned(r.getInt("totalPointsEarned"));
                    card.setTotalPointsUsed(r.getInt("totalPointsUsed"));
                    card.setCustomer(b.getCustomer());
                    b.setCard(card);
                }
                return b;
            }
        }
    }
}
