
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="dao5.*" %>
<%@ include file="/WEB-INF/jspf/common.jspf" %>
<%@ include file="/WEB-INF/jspf/managerGuard.jspf" %>

<%
    String key = request.getParameter("key");

    List<DishOrder5> items =
            (List<DishOrder5>) session.getAttribute("orders5_" + key);

    if (items == null) {
        response.sendRedirect(request.getContextPath() + "/view5/Manager5/StatSelectFrm5.jsp");
        return;
    }

    int idx;

    try {
        idx = Integer.parseInt(request.getParameter("index"));
    } catch (Exception e) {
        response.sendError(400);
        return;
    }

    if (idx < 0 || idx >= items.size()) {
        response.sendError(404);
        return;
    }

    DishOrder5 selected = items.get(idx);
    Order5 order;
    Bill5 bill;

    try {
        order = new OrderDAO5().getOrderByDishOrder(selected);

        bill = order == null
                ? null
                : new BillDAO5().getBillByOrder(order);

    } catch (Exception e) {
        throw new ServletException(e);
    }

    if (bill == null) {
        response.sendError(404, "Không tìm thấy hóa đơn");
        return;
    }

    StringBuilder tableNumbers = new StringBuilder();

    for (OrderTable5 orderTable : order.getOrderTables()) {
        if (tableNumbers.length() > 0) {
            tableNumbers.append(", ");
        }

        tableNumbers.append(
                orderTable.getTable().getTableNumber()
        );
    }
%>

<%@ include file="/WEB-INF/jspf/start.jspf" %>

<section class="panel panel--wide">
    <h1 class="page-title">Hóa đơn</h1>

    <dl class="info-list">
        <dt>Mã hóa đơn:</dt>
        <dd>HD<%= String.format("%06d", bill.getId()) %></dd>

        <dt>Khách hàng:</dt>
        <dd>
            <%= bill.getCustomer() == null
                    ? "Khách vãng lai"
                    : esc(bill.getCustomer().getName()) %>
        </dd>

        <dt>Số bàn:</dt>
        <dd><%= esc(tableNumbers) %></dd>

        <dt>Nhân viên:</dt>
        <dd>
            <%= bill.getStaff() == null
                    ? "—"
                    : esc(bill.getStaff().getName()) %>
        </dd>

        <dt>Thời gian:</dt>
        <dd><%= date(bill.getPaymentTime()) %></dd>

        <dt>Mã thẻ thành viên:</dt>
        <dd>
            <%= bill.getCard() == null
                    ? "Không sử dụng"
                    : esc(bill.getCard().getCode()) %>
        </dd>

        <dt>Điểm tích lũy sử dụng:</dt>
        <dd>
            <%= bill.getPointsUsed() %>
            (giảm <%= money(bill.getDiscountAmount()) %>)
        </dd>

        <dt>Điểm tích lũy nhận:</dt>
        <dd><%= bill.getPointsEarned() %></dd>
    </dl>

    <div class="table-wrap">
        <table>
            <thead>
            <tr>
                <th class="center">TT</th>
                <th>Tên món</th>
                <th class="num">Số lượng</th>
                <th class="num">Đơn giá</th>
                <th class="num">Thành tiền</th>
            </tr>
            </thead>
            <tbody>
            <% int rowNumber = 0; %>

            <% for (DishOrder5 dishItem : order.getDishes()) {
                BigDecimal unitPrice = dishItem.getQuantity() == 0
                        ? BigDecimal.ZERO
                        : dishItem.getAmount().divide(
                        BigDecimal.valueOf(dishItem.getQuantity()),
                        2,
                        RoundingMode.HALF_UP
                );
            %>
            <tr>
                <td class="center"><%= ++rowNumber %></td>
                <td>
                    <%= esc(dishItem.getDishSize().getDish().getName()) %>
                    (<%= esc(dishItem.getDishSize().getSize().getName()) %>)
                </td>
                <td class="num"><%= dishItem.getQuantity() %></td>
                <td class="num"><%= money(unitPrice) %></td>
                <td class="num"><%= money(dishItem.getAmount()) %></td>
            </tr>
            <% } %>

            <% for (ComboOrder5 comboItem : order.getCombos()) {
                BigDecimal unitPrice = comboItem.getQuantity() == 0
                        ? BigDecimal.ZERO
                        : comboItem.getAmount().divide(
                        BigDecimal.valueOf(comboItem.getQuantity()),
                        2,
                        RoundingMode.HALF_UP
                );
            %>
            <tr>
                <td class="center"><%= ++rowNumber %></td>
                <td>
                    Combo: <%= esc(comboItem.getCombo().getName()) %>
                </td>
                <td class="num"><%= comboItem.getQuantity() %></td>
                <td class="num"><%= money(unitPrice) %></td>
                <td class="num"><%= money(comboItem.getAmount()) %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <p class="bill-total">
        Tổng tiền:
        <span class="price">
            <%= money(bill.getFinalAmount()) %>
        </span>
    </p>

    <div class="actions">
        <a class="btn btn--secondary" href="javascript:history.back()">
            Quay lại
        </a>
    </div>
</section>

<%@ include file="/WEB-INF/jspf/end.jspf" %>
