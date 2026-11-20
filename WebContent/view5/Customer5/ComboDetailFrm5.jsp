
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/jspf/common.jspf" %>

<%
    String key = request.getParameter("key");
    Object[] result = (Object[]) session.getAttribute("search5_" + key);

    if (result == null) {
        response.sendRedirect(request.getContextPath() + "/view5/Customer5/HomeFrm5.jsp");
        return;
    }

    List<Combo5> list = (List<Combo5>) result[1];
    int idx;

    try {
        idx = Integer.parseInt(request.getParameter("index"));
    } catch (Exception e) {
        response.sendError(400);
        return;
    }

    if (idx < 0 || idx >= list.size()) {
        response.sendError(404);
        return;
    }

    Combo5 combo = list.get(idx);
%>

<%@ include file="/WEB-INF/jspf/start.jspf" %>

<section class="panel panel--wide">
    <h1 class="page-title">Chi tiết combo</h1>

    <div class="detail-grid">
        <div class="image-frame">
            <% if (combo.getImage() != null && !combo.getImage().isEmpty()) { %>
            <img src="<%= request.getContextPath() + "/" + esc(combo.getImage()) %>"
                 alt="<%= esc(combo.getName()) %>">
            <% } else { %>
            Hình ảnh minh họa
            <% } %>
        </div>

        <dl class="detail-fields">
            <dt>Tên combo:</dt>
            <dd><strong><%= esc(combo.getName()) %></strong></dd>

            <dt>Giá combo:</dt>
            <dd class="price"><%= money(combo.getPrice()) %></dd>

            <dt>Từ ngày:</dt>
            <dd>
                <%= combo.getStartDate() == null
                        ? "—"
                        : combo.getStartDate().toLocalDateTime()
                        .format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %>
            </dd>

            <dt>Đến ngày:</dt>
            <dd>
                <%= combo.getEndDate() == null
                        ? "—"
                        : combo.getEndDate().toLocalDateTime()
                        .format(DateTimeFormatter.ofPattern("dd/MM/yyyy")) %>
            </dd>

            <dt>Mô tả:</dt>
            <dd><%= esc(combo.getDescription()) %></dd>
        </dl>
    </div>

    <h2 class="section-title">
        Danh sách món ăn trong combo
    </h2>

    <div class="table-wrap">
        <table>
            <thead>
            <tr>
                <th class="center">TT</th>
                <th>Tên món</th>
                <th>Size áp dụng</th>
                <th class="center">Số lượng</th>
            </tr>
            </thead>
            <tbody>
            <% int rowNumber = 0; %>
            <% for (ComboDetail5 detail : combo.getDetails()) { %>
            <tr>
                <td class="center"><%= ++rowNumber %></td>
                <td><%= esc(detail.getDishSize().getDish().getName()) %></td>
                <td><%= esc(detail.getDishSize().getSize().getName()) %></td>
                <td class="center"><%= detail.getQuantity() %></td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <div class="actions">
        <a class="btn btn--secondary"
           href="<%= request.getContextPath() %>/view5/Customer5/SearchListFrm5.jsp?keyword=<%= java.net.URLEncoder.encode((String) result[2], "UTF-8") %>">
            Quay lại
        </a>

        <a class="btn btn--large"
           href="<%= request.getContextPath() %>/view5/Customer5/OrderHandoff5.jsp?kind=combo&amp;key=<%= esc(key) %>&amp;index=<%= idx %>">
            Đặt món
        </a>
    </div>
</section>

<%@ include file="/WEB-INF/jspf/end.jspf" %>
