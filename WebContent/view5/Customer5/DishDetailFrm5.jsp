
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="dao5.*" %>
<%@ include file="/WEB-INF/jspf/common.jspf" %>

<%
    String key = request.getParameter("key");
    Object[] result = (Object[]) session.getAttribute("search5_" + key);

    if (result == null) {
        response.sendRedirect(request.getContextPath() + "/view5/Customer5/HomeFrm5.jsp");
        return;
    }

    List<Dish5> list = (List<Dish5>) result[0];
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

    Dish5 dish = list.get(idx);
    List<DishSize5> sizes;

    try {
        sizes = new DishSizeDAO5().getDishSizeByDish(dish);
    } catch (Exception e) {
        throw new ServletException(e);
    }
%>

<%@ include file="/WEB-INF/jspf/start.jspf" %>

<section class="panel panel--wide">
    <h1 class="page-title">Chi tiết món ăn</h1>

    <div class="detail-grid">
        <div class="image-frame">
            <% if (dish.getImage() != null && !dish.getImage().isEmpty()) { %>
            <img src="<%= request.getContextPath() + "/" + esc(dish.getImage()) %>"
                 alt="<%= esc(dish.getName()) %>">
            <% } else { %>
            Hình ảnh minh họa
            <% } %>
        </div>

        <div>
            <dl class="detail-fields">
                <dt>Tên món:</dt>
                <dd><strong><%= esc(dish.getName()) %></strong></dd>

                <dt>Loại món:</dt>
                <dd><%= esc(dish.getType()) %></dd>

                <dt>Giá bán:</dt>
                <dd><strong><%= money(dish.getBasePrice()) %></strong></dd>
            </dl>

            <% if (!sizes.isEmpty()) { %>
            <strong>Size:</strong>

            <div class="table-wrap">
                <table>
                    <thead>
                    <tr>
                        <th>Size</th>
                        <th class="num">Giá bán</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (DishSize5 ds : sizes) {
                        BigDecimal sizePrice = dish.getBasePrice()
                                .multiply(BigDecimal.valueOf(
                                        ds.getSize().getPricePercentage()))
                                .divide(new BigDecimal("100"));
                    %>
                    <tr>
                        <td><%= esc(ds.getSize().getName()) %></td>
                        <td class="num"><%= money(sizePrice) %></td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>
        </div>
    </div>

    <p class="description">
        <strong>Mô tả:</strong>
        <%= esc(dish.getDescription()) %>
    </p>

    <div class="actions">
        <a class="btn btn--secondary"
           href="<%= request.getContextPath() %>/view5/Customer5/SearchListFrm5.jsp?keyword=<%= java.net.URLEncoder.encode((String) result[2], "UTF-8") %>">
            Quay lại
        </a>

        <a class="btn btn--large"
           href="<%= request.getContextPath() %>/view5/Customer5/OrderHandoff5.jsp?kind=dish&amp;key=<%= esc(key) %>&amp;index=<%= idx %>">
            Đặt món
        </a>
    </div>
</section>

<%@ include file="/WEB-INF/jspf/end.jspf" %>
