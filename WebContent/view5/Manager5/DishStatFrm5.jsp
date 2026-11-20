
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="dao5.*" %>
<%@ include file="/WEB-INF/jspf/common.jspf" %>
<%@ include file="/WEB-INF/jspf/managerGuard.jspf" %>

<%
    if (!"dish".equals(request.getParameter("type"))) {
%>
<script>
    alert("Chức năng thống kê này chưa được hỗ trợ");
    location.href = "<%= request.getContextPath() %>/view5/Manager5/StatSelectFrm5.jsp";
</script>
<%
        return;
    }

    LocalDate start;
    LocalDate end;

    try {
        start = LocalDate.parse(request.getParameter("startDate"));
        end = LocalDate.parse(request.getParameter("endDate"));

        if (end.isBefore(start)) {
            throw new Exception();
        }
    } catch (Exception e) {
%>
<script>
    alert("Khoảng thời gian không hợp lệ");
    location.href = "<%= request.getContextPath() %>/view5/Manager5/StatSelectFrm5.jsp";
</script>
<%
        return;
    }

    List<DishStat5> stats;

    try {
        stats = new DishStatDAO5().getDishStat(start, end);
    } catch (Exception e) {
        throw new ServletException(e);
    }

    if (stats.isEmpty()) {
%>
<script>
    alert("Không có dữ liệu thống kê trong khoảng thời gian đã chọn");
    location.href = "<%= request.getContextPath() %>/view5/Manager5/StatSelectFrm5.jsp";
</script>
<%
        return;
    }

    String key = java.util.UUID.randomUUID().toString();
    session.setAttribute("stat5_" + key, stats);

    BigDecimal total = BigDecimal.ZERO;
    long qty = 0;

    for (DishStat5 stat : stats) {
        total = total.add(stat.getTotalAmount());
        qty += stat.getQuantitySold();
    }
%>

<%@ include file="/WEB-INF/jspf/start.jspf" %>

<section class="panel panel--wide">
    <h1 class="page-title">
        Thống kê món ăn theo doanh thu
    </h1>

    <div class="date-row">
        <span>
            <strong>Từ ngày:</strong>
            <%= start.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %>
        </span>

        <span>
            <strong>Đến ngày:</strong>
            <%= end.format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %>
        </span>
    </div>

    <div class="table-wrap">
        <table>
            <thead>
            <tr>
                <th class="center">TT</th>
                <th>Tên món</th>
                <th class="num">Số lượng bán</th>
                <th class="num">Tổng doanh thu</th>
            </tr>
            </thead>
            <tbody>
            <% for (int i = 0; i < stats.size(); i++) {
                DishStat5 statRow = stats.get(i);
            %>
            <tr>
                <td class="center"><%= i + 1 %></td>
                <td>
                    <a href="<%= request.getContextPath() %>/view5/Manager5/DishOrderFrm5.jsp?key=<%= esc(key) %>&amp;index=<%= i %>">
                        <%= esc(statRow.getName()) %>
                    </a>
                </td>
                <td class="num"><%= statRow.getQuantitySold() %></td>
                <td class="num"><%= money(statRow.getTotalAmount()) %></td>
            </tr>
            <% } %>

            <tr class="total-row">
                <td colspan="2">Tổng</td>
                <td class="num"><%= qty %></td>
                <td class="num"><%= money(total) %></td>
            </tr>
            </tbody>
        </table>
    </div>

    <div class="actions">
        <a class="btn btn--secondary" href="<%= request.getContextPath() %>/view5/Manager5/StatSelectFrm5.jsp">
            Quay lại
        </a>
    </div>
</section>

<%@ include file="/WEB-INF/jspf/end.jspf" %>
