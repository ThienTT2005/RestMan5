
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="dao5.*" %>
<%@ include file="/WEB-INF/jspf/common.jspf" %>
<%@ include file="/WEB-INF/jspf/managerGuard.jspf" %>

<%
    String key = request.getParameter("key");

    List<DishStat5> stats =
            (List<DishStat5>) session.getAttribute("stat5_" + key);

    if (stats == null) {
        response.sendRedirect(request.getContextPath() + "/view5/Manager5/StatSelectFrm5.jsp");
        return;
    }

    int index;

    try {
        index = Integer.parseInt(request.getParameter("index"));
    } catch (Exception e) {
        response.sendError(400);
        return;
    }

    if (index < 0 || index >= stats.size()) {
        response.sendError(404);
        return;
    }

    DishStat5 stat = stats.get(index);
    List<DishOrder5> orders;

    try {
        orders = new DishOrderDAO5().getDishOrderByDishStat(stat);
    } catch (Exception e) {
        throw new ServletException(e);
    }

    String orderKey = java.util.UUID.randomUUID().toString();
    session.setAttribute("orders5_" + orderKey, orders);

    BigDecimal total = BigDecimal.ZERO;
    int qty = 0;

    for (DishOrder5 orderItem : orders) {
        total = total.add(orderItem.getAmount());
        qty += orderItem.getQuantity();
    }
%>

<%@ include file="/WEB-INF/jspf/start.jspf" %>

<section class="panel panel--wide">
    <h1 class="page-title">Danh sách lượt gọi món</h1>

    <p class="subtitle">
        <strong>Tên món:</strong>
        <%= esc(stat.getName()) %>
    </p>

    <div class="date-row">
        <span>
            <strong>Từ ngày:</strong>
            <%= stat.getStartDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %>
        </span>
        <span>
            <strong>Đến ngày:</strong>
            <%= stat.getEndDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %>
        </span>
    </div>

    <div class="table-wrap">
        <table>
            <thead>
            <tr>
                <th class="center">TT</th>
                <th>Số bàn</th>
                <th class="num">Số lượng</th>
                <th class="num">Đơn giá</th>
                <th class="num">Thành tiền</th>
                <th>Thời gian gọi</th>
            </tr>
            </thead>
            <tbody>
            <% for (int i = 0; i < orders.size(); i++) {
                DishOrder5 item = orders.get(i);

                StringBuilder tableNumbers = new StringBuilder();

                for (OrderTable5 orderTable :
                        item.getOrder().getOrderTables()) {

                    if (tableNumbers.length() > 0) {
                        tableNumbers.append(", ");
                    }

                    tableNumbers.append(
                            orderTable.getTable().getTableNumber()
                    );
                }

                BigDecimal unitPrice = item.getQuantity() == 0
                        ? BigDecimal.ZERO
                        : item.getAmount().divide(
                        BigDecimal.valueOf(item.getQuantity()),
                        2,
                        RoundingMode.HALF_UP
                );
            %>
            <tr>
                <td class="center"><%= i + 1 %></td>
                <td><%= esc(tableNumbers) %></td>
                <td class="num"><%= item.getQuantity() %></td>
                <td class="num"><%= money(unitPrice) %></td>
                <td class="num">
                    <a href="<%= request.getContextPath() %>/view5/Manager5/BillFrm5.jsp?key=<%= esc(orderKey) %>&amp;index=<%= i %>">
                        <%= money(item.getAmount()) %>
                    </a>
                </td>
                <td><%= date(item.getOrder().getOrderTime()) %></td>
            </tr>
            <% } %>

            <tr class="total-row">
                <td colspan="2">Tổng</td>
                <td class="num"><%= qty %></td>
                <td></td>
                <td class="num"><%= money(total) %></td>
                <td></td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="actions">
        <a class="btn btn--secondary"
           href="<%= request.getContextPath() %>/view5/Manager5/DishStatFrm5.jsp?type=dish&amp;startDate=<%= stat.getStartDate() %>&amp;endDate=<%= stat.getEndDate() %>">
            Quay lại
        </a>
    </div>
</section>

<%@ include file="/WEB-INF/jspf/end.jspf" %>
