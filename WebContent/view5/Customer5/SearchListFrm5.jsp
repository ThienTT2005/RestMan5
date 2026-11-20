
<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ page import="dao5.*" %>

<%@ include file="/WEB-INF/jspf/common.jspf" %>

<%
    request.setCharacterEncoding("UTF-8");

    String keyword = request.getParameter("keyword");

    keyword = keyword == null
            ? ""
            : keyword.trim();

    if (keyword.isEmpty()) {
%>

<script>
    alert("Vui lòng nhập từ khóa tìm kiếm!");
    window.location.href = "<%= request.getContextPath() %>/view5/Customer5/HomeFrm5.jsp";
</script>

<%
        return;
    }

    List<Dish5> dishes;
    List<Combo5> combos;

    try {
        dishes = new DishDAO5().getDishByKeyword(keyword);
        combos = new ComboDAO5().getComboByKeyword(keyword);

    } catch (Exception ex) {
        throw new ServletException(
                "Lỗi truy vấn tìm kiếm",
                ex
        );
    }

    if (dishes.isEmpty() && combos.isEmpty()) {
%>

<script>
    alert("Không tìm thấy món ăn/combo phù hợp!");
    window.location.href = "<%= request.getContextPath() %>/view5/Customer5/HomeFrm5.jsp";
</script>

<%
        return;
    }

    String key = java.util.UUID.randomUUID().toString();

    session.setAttribute(
            "search5_" + key,
            new Object[] {
                    dishes,
                    combos,
                    keyword
            }
    );

    class SearchRow {

        String name;
        String type;
        String description;

        BigDecimal price;

        int index;
        boolean combo;

        SearchRow(
                String name,
                String type,
                String description,
                BigDecimal price,
                int index,
                boolean combo
        ) {
            this.name = name;
            this.type = type;
            this.description = description;
            this.price = price;
            this.index = index;
            this.combo = combo;
        }
    }

    List<SearchRow> rows = new ArrayList<>();

    for (int i = 0; i < dishes.size(); i++) {

        Dish5 dish = dishes.get(i);

        rows.add(
                new SearchRow(
                        dish.getName(),
                        dish.getType(),
                        dish.getDescription(),
                        dish.getBasePrice(),
                        i,
                        false
                )
        );
    }

    for (int i = 0; i < combos.size(); i++) {

        Combo5 combo = combos.get(i);

        rows.add(
                new SearchRow(
                        combo.getName(),
                        "Combo",
                        combo.getDescription(),
                        combo.getPrice(),
                        i,
                        true
                )
        );
    }

    rows.sort(
            (a, b) -> a.name.compareToIgnoreCase(b.name)
    );
%>

<%@ include file="/WEB-INF/jspf/start.jspf" %>

<section class="panel panel--wide">

    <h1 class="page-title">
        Kết quả tìm kiếm
    </h1>

    <p class="subtitle">
        Từ khóa:
        <strong>“<%= esc(keyword) %>”</strong>
    </p>

    <div class="table-wrap">

        <table>
            <thead>
            <tr>
                <th class="center">TT</th>
                <th>Tên</th>
                <th>Loại</th>
                <th class="num">Giá bán</th>
                <th>Mô tả</th>
            </tr>
            </thead>

            <tbody>

            <%
                int number = 0;

                for (SearchRow row : rows) {
            %>

            <tr>
                <td class="center">
                    <%= ++number %>
                </td>

                <td>
                    <a href="<%= request.getContextPath() %><%= row.combo
                                ? "/view5/Customer5/ComboDetailFrm5.jsp"
                                : "/view5/Customer5/DishDetailFrm5.jsp" %>?key=<%= esc(key) %>&amp;index=<%= row.index %>">

                        <%= esc(row.name) %>
                    </a>
                </td>

                <td>
                    <%= esc(row.type) %>
                </td>

                <td class="num">
                    <%= money(row.price) %>
                </td>

                <td>
                    <%= esc(row.description) %>
                </td>
            </tr>

            <% } %>

            </tbody>
        </table>

    </div>

    <div class="actions">

        <a class="btn btn--secondary"
           href="<%= request.getContextPath() %>/view5/Customer5/HomeFrm5.jsp">
            Quay lại
        </a>

    </div>

</section>

<%@ include file="/WEB-INF/jspf/end.jspf" %>
